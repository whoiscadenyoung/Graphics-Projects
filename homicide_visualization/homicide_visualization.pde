Table homicides;
ArrayList<Country> countries;

void setup() {
  size(800, 600);
  
  // I converted this to a CSV using Excel so I would be more familiar with it
  homicides = loadTable("HomicideRates.csv", "header, csv");
  // I made an arraylist for all the countries so I could iterate over them
  countries = new ArrayList();
  for (TableRow row : homicides.rows()) {
    countries.add(new Country(row));
  }
}

void draw() {
  // Set the colors and set blend to multiply so overlapping areas darken, like the example
  background(color(255));
  strokeWeight(1);
  stroke(150);
  blendMode(MULTIPLY);
  
  // Max value for the y-axis to be drawn
  float max = maxRate(countries);
  // Width and height are slightly smaller to fit the labels
  float graphWidth = width - 100;
  float graphHeight = height - 50;
  // Increment rate x is to space out the years along the x-axis
  float incX = graphWidth / 8;
  // Increment rate y is to space out the labels along the y-axis
  float incY = (graphHeight - 20) / 7;
  
  // Move the graph to make room for the labels
  translate(50, 25);  
  // For each country in countries draw the line for the country stats
  for (Country country : countries) {
    float x = 0;
    noFill();
    // Using a shape here to make a continuous line that follows a series of vertices
    // Each country is a different unfilled shape
    // The vertices represent the rate for that year
    beginShape();
    for (int year = 2001; year <= 2009; year++) {
      // Get the year and the rate for that year
      String k = String.valueOf(year);
      float v = country.rates.get(k);
      // Find the appropriate y position by mapping the rate to the height of the graph
      float y = graphHeight - map(v, 0, max, 0, graphHeight);
      // Draw the vertex at the point
      vertex(x, y);
      // Increment to move on to the next year
      x += incX;
    }
    endShape();
  }
  
  // Reset the blend mode, strokes, fill, thicken the stroke for the lines, align the text
  blendMode(BLEND);
  fill(0);
  stroke(0);
  strokeWeight(2);
  textAlign(CENTER);
  
  // Display the years across the x-axis and draw lines on top of the graph for visualizing
  float x = 0;
  for (int year = 2001; year <= 2009; year++) {
    String yearName = String.valueOf(year);
    line(x, 0, x, graphHeight);
    text(yearName, x, -10);
    x += incX;
  }
  
  // Set the y-axis values; this is not the most ... abstract but it works
  float y = 15;
  for (int num = 7; num >= 0; num--) {
    String number = String.valueOf(num * 10);
    text(number, -15, y);
    y += incY;
  }
  
  // Set the title
  text("Homicide rates per 100,000 (per year)", graphWidth / 2, graphHeight + 15);
}

// Find the max rate out of all the countries to scale the graph
float maxRate(ArrayList<Country> countries) {
  float currentMax = 0;
  for (Country country : countries ) {
    // This updates currentMax as it finds maxes that are greater than it
    currentMax = max(country.max, currentMax);
  }
  return currentMax;
}
