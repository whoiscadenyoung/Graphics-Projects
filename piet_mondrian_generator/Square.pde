class Square {
  // Created a basic square class here to represent the squares in the random grid
  // Squares all have a width, height, and color 
  float x, y, w, h;
  color col;
  
  // Construct a square based on parameters passed in
  Square(float _x, float _y, float _w, float _h) {
    x = _x; y = _y; w = _w; h = _h;
    // This randomly picks a color for the square from the limited palette of five colors
    int pos = (int)(Math.random() * colors.length);
    col = colors[pos];
  }
  
  // Draw the square with the set color at the set position, from the top left corner
  void display() {
    fill(col);
    rect(x, y, w, h);
  }
}
