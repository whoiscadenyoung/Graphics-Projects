Table netflix;
String[] countriesArray;
StringList countriesList;
IntDict countryMap;
int[] countryValues;
ArrayList<Column> columns;
FloatDict[] recentYears;

// This determines the column/country that we're looking at for the singuler view
// Column view = 0, single view = 1, compare view = 2
int view = 0;
Column viewColumn;

int sumValues(IntDict dict) {
  int sum = 0;
  for (int value : dict.values()) {
    sum += value;
  }
  return sum;
}

boolean overColumn(float x, float w) {
  float relativeX = mouseX - x;
    if (mouseX > x && relativeX < w) {
      return true;
    } else return false;
}

boolean overButton(int x, int y, int w, int h)  {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) return true;
  else return false;
}

FloatDict annualProportion(String year) {
  FloatDict perYear = new FloatDict();
  float sumYear = 0;
  for (Column column : columns) {
    sumYear += column.annual.get(year);
  }
  for (Column column : columns) {
    int producedInYear = column.annual.get(year);
    String country = column.countryName;
    perYear.set(country, producedInYear / sumYear);
  }
  return perYear;
}

void setup() {
  size(1400,800);
  
  // Read in the table of data
  netflix = loadTable("netflix_titles.csv", "header, csv");  

  // Create an array from the column of countries
  countriesArray = netflix.getStringColumn("country");
  
  // Create a list and append the primary country for any non-empty values from the array
  countriesList = new StringList();
  for (String country : countriesArray) {
    String primaryCountry = country.split(",")[0];
    if (!primaryCountry.equals("")) countriesList.append(primaryCountry);
  }
 
  // Create a dictionary of countries to count how many movies were filmed there
  countryMap = new IntDict();
  for (String country : countriesList) {
    // Only counting the primary country; would've counted each country multiple times but would've led to weird data
    String primaryCountry = country.split(",")[0];
    if (countryMap.hasKey(primaryCountry)) {
      countryMap.increment(primaryCountry);
    } else {
      countryMap.set(primaryCountry, 1);
    }
  }
    
  // Sort the values in descending order to create the treemap
  // Resize to only select the top 10 countries for the visualization
  countryMap.sortValuesReverse();
  countryMap.resize(10);
  
  columns = new ArrayList<Column>();
  float colPosition = 0;
  for (IntDict.Entry country : countryMap.entries()) {
    float mappedValue = map(country.value, 0, sumValues(countryMap), 0, width);
    PImage img = loadImage(country.key + ".png");
    if (img != null) columns.add(new Column(country.key, colPosition, mappedValue, country.value, img));
    colPosition += mappedValue;
  }
  
  // Create the dicts to use for the compare view, sort them so they display properly
  recentYears = new FloatDict[]{ annualProportion("2018"), annualProportion("2019"), annualProportion("2020") };
  for (FloatDict year : recentYears) {
    year.sortValuesReverse();
  }
}

void draw() {
  // If the view is single, we'll draw it like it should be drawn
  if (view == 1) {
    viewColumn.displayFull();
  }
  // If the view is not single, will either be compare or main
  else {
    if (view == 2) {
      fill(color(75, 101, 132));
      rect(0, 0, width, height);

      textAlign(LEFT, CENTER);
      fill(255);
      textSize(16);
      text("Chart showing changes in the top-producing countries by proportion over three years", 20, 20);
      textSize(12);
      text("- Click the Compare button to return back to the main tree view", 20, 40);
      
      pushMatrix();
      FloatDict pastPosition = new FloatDict();
      float currentX = 0;
      float spaceX = 500;
      float currentY = 0;
      float spaceY = 48;
      translate(200,200);
      textAlign(CENTER, CENTER);
      textSize(32); 
      text("2018", 0, -spaceY);
      text("2019", spaceX, -spaceY);
      text("2020", spaceX * 2, -spaceY);
      textSize(24);
      for (int i = 0; i < recentYears.length; i++) {
        for (FloatDict.Entry country : recentYears[i].entries()) {
          if (pastPosition.hasKey(country.key)) {
            float pastY = pastPosition.get(country.key);
            stroke(0);
            strokeWeight(4);
            line(currentX - spaceX + 120, pastY, currentX - 120, currentY);
            strokeWeight(1);
            stroke(255);
          }
          text(country.key, currentX, currentY);
          pastPosition.set(country.key, currentY);
          currentY += spaceY;
        }
        currentX += spaceX;
        currentY = 0;
      }
      popMatrix();
    } else {
      stroke(1);
      for (Column column : columns) {
        column.displayColumn();
      }
      for (Column column : columns) {
        if (!overButton(20, height - 60, 120, 40) && overColumn(column.x, column.w)) column.displayText(); 
      }
      
      textAlign(LEFT, CENTER);
      fill(255);
      textSize(16);
      text("Tree map displaying the top ten countries that produce Netflix content", 20, 20);
      textSize(12);
      text("- Hover over columns to see the country and number of movies/shows", 20, 40);
      text("- Click columns to transition to ratings view", 20, 56);
      text("- Click compare to switch to a different view", 20, 72);
    }
    fill(255);
    rect(20, height - 60, 120, 40);
    fill(0);
    textSize(16);
    textAlign(CENTER,CENTER);
    text("Compare", 80, height - 40);
  }
}

// Somehow I have to figure out which column the user clicked to know which one to grow...
void mouseClicked() {
  if (view == 1) {
    view = 0;
    println("Clicked screen, switch from view 1 (full screen) to main view");
  } else if (overButton(20, height - 60, 120, 40)) {
      if (view == 2) {
        view = 0;
        println("Clicked button, switch from compare view to main view");
      } else {
        view = 2;
        println("Clicked button, switch from main view to compare view");
      }
  } else if (view == 0) {
    // Create a new array with all the columns from the original one
    // This is the safest way I could think to do it--I'd use Option in Scala or something
    ArrayList<Column> newColumns = new ArrayList<Column>();
    for (Column column : columns) {
      if (overColumn(column.x, column.w)) newColumns.add(column);
    }
    if (!newColumns.isEmpty()) {
      viewColumn = newColumns.get(0);
      newColumns.clear();
      view = 1;
      println("Clicked column, found column, switch from main view to full screen view 1");
    }
  }
}
