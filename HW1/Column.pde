class Column {
  // I'm only doing single columns so no y value needed
  // Origin x, width
  float x, w;
  int c;
  String countryName;
  IntDict annual;
  PImage img;
  color fillColor;
  
  // Constructor requires the top left x, y, width, count of films, and an image flag
  // I know this constructor's super loaded, but I only call it once so it's not too terrible...
  Column(String _countryName, float _x, float _w, int _c, PImage _img) {
    
    countryName = _countryName; 
    x = _x; 
    c = _c;
    w = _w; 
    img = _img;
    
    // Set the fill color based on the width and location
    fillColor = lerpColor(color(75, 101, 132), color(209, 216, 224), x / width);
    
    // I wanted to do the ratings on the constructor so it only goes through the table once for each column 
    annual = new IntDict();
    // Getting rows that match the primary country, then sorting them by date into the dict
    for (TableRow row : netflix.findRows(this.countryName, "primary_country")) {
      String year = row.getString("year_added");
      if (annual.hasKey(year)) {
        annual.increment(year);
      } else {
        annual.set(year, 1);
      }
    }
  }
  
  // Display the column as a column
  void displayColumn() {
    // Draw the column on the graph
    stroke(255);
    fill(fillColor);
    rect(x, 0, w, height);
    
    // If the column length permits, put the country
    if (this.w > 100) {
      imageMode(CENTER);
      image(img, this.x + (this.w / 2), height / 2, 60, 60);
      fill(255);
      textAlign(CENTER, BOTTOM);
      text(this.c, this.x + (this.w / 2), height / 2 + 50);
    }
  }
  
  void displayFull() {
    stroke(255);
    fill(fillColor);
    rect(0, 0, width, height);
    
    imageMode(CORNER);
    image(img, 20, 10, 60, 60);
    fill(0);
    textAlign(LEFT, TOP);
    textSize(16);
    text("Annual breakdown of movies/shows added that were produced in " + this.countryName, 90, 20);
    textSize(12);
    text("- Click anywhere to go back to the main tree map view", 90, 40);
    
    // In a perfect world, this would be an entirely separate class that takes the dict of ratings
    pushMatrix();
    translate(300,200);
    fill(255);
    rect(0,0, 800, 400);
    annual.sortKeys();
    float pointWidth = 800 / (float)annual.size();
    for (int i = 0; i < annual.size(); i++) {
      float x = map(i, 0, annual.size(), pointWidth / 2, 800 + pointWidth / 2);
      float mx = annual.maxValue();
      stroke(0);
      strokeWeight(pointWidth - 5);
      strokeCap(SQUARE);
      float lineTop = map(annual.value(i), 0, mx, 400, 15);
      line(x, 400, x, lineTop);
      strokeWeight(1);
      fill(0);
      textAlign(CENTER, BOTTOM);
      text(annual.key(i), x, 420);
      text(annual.value(i), x, lineTop);
    }
    
    popMatrix();
  }
  
  // Display the hover text after all the columns are drawn
  void displayText() {
    imageMode(CORNERS);
    image(img, mouseX - 40, mouseY - 100, mouseX, mouseY - 60);
    fill(0);
    textAlign(RIGHT, BOTTOM);
    text(this.countryName, mouseX, mouseY - 40);
    text(this.c, mouseX, mouseY - 20);
  }
}
