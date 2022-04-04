// This one took so absolutely freaking long... Like so long...

// Things that have to be initialized early: all the colors, the array of colors
color mint = color(85, 239, 196);
color green = color(0, 184, 148);
color lavender = color(162, 155, 254);
color charcoal = color(99, 110, 114); // or color(45, 52, 54)
color gray = color(178, 190, 195); // or color(99, 110, 114)
color white = color(255);
color[] colors = { mint, green, lavender, white, gray };
float steps;
boolean pressed = false;

// Things that can be initialized later
ArrayList<Square> squares;

void setup() {
  size(500,500);
  
  // Start creating the squares to draw
  // After it loads this first time, it will react to any key press on the keyboard
  startSquares();
}

void draw() {
  background(charcoal);
  strokeWeight(4);
  stroke(charcoal);
  
  // Display each square
  for (Square sq : squares) {
    sq.display();
  }
}

void startSquares() {
  // Initialize the list and create the first square in the list
  squares = new ArrayList<Square>();
  squares.add(new Square(0, 0, width, height));
  // Split up the window into a grid, for each segment, decide if you want to split up the squares
  steps = width / 7;
  for (float i = 0; i < width; i += steps) {
    splitSquaresX(i);
    splitSquaresY(i);
  }
}

void keyReleased() {
  startSquares();
}

void splitSquaresX(float x) {
  // For each square in squares
  for (int i = squares.size() - 1; i >= 0; i--) {
    // Get the current square; 
    Square sq = squares.get(i);
    // If the x passed in (which is the current step) is greater than square's left side, 
    // or the x is less than square's right side (between 0 and width for start), then decide to split
    if (x > sq.x && x < sq.x + sq.w) {
      // Randomly decides whether to split or not; the ratio here affects how small the squares get
      // because higher chance of splitting means smaller squares
      float rand = (float)Math.random();
      if(rand > 0.7) {
        // Remove the current square to replace it with the split ones as necessary
        squares.remove(i);
        splitX(sq, x); 
      }
    }
  }
}

// Essentially the same as the above function but for the y axis
void splitSquaresY(float y) {
  for (int i = squares.size() - 1; i >= 0; i--) {
    Square sq = squares.get(i);
    if (y > sq.y && y < sq.y + sq.h) {
      float rand = (float)Math.random();
      if(rand > 0.7) {
        squares.remove(i);
        splitY(sq, y); 
      }
    }
  }
}

// The actual functions to split up the squares; takes the square and the current y position, which is the step
void splitX(Square sq, float split) {
  // Width of first new square is the split position plus the square's x position
  float width1 = sq.w - (sq.w - split + sq.x);
  // Width of second new square is the current width - the split + the x position
  float width2 = sq.w - split + sq.x;
  // Add the squares in; the second one starts at split
  squares.add(new Square(sq.x, sq.y, width1, sq.h));
  squares.add(new Square(split, sq.y, width2, sq.h));
}

// Essentially the same thing as above but splits on the y axis to make it balanced
void splitY(Square sq, float split) {
  float heightA = sq.h - (sq.h - split + sq.y);
  float heightB = sq.h - split + sq.y;
  squares.add(new Square(sq.x, sq.y, sq.w, heightA));
  squares.add(new Square(sq.x, split, sq.w, heightB));
}
