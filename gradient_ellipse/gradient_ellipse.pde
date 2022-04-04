color lc;
float x, y;
float w, h;

void setup() {
  size(500,500);
  ellipseMode(CENTER);
}

void draw() {
  background(255);
  
  // Get the positions for the ellipse
  // Width should be twice the height
  x = width / 2;
  y = height / 2;
  w = width;
  h = w / 2;
  
  pushMatrix();
  // Translating so I can do all the calculations about the origin
  translate(x, y);
  // Rotate it 30 degrees as specified
  rotate(-PI/6);
  // Wrote this in terms of 0 to 1 instead of 0 to TWO_PI so lerpColor was more... friendly to read
  // Will essentially allow circles to be drawn along the circumference of the ellipse
  for (float pos = 0; pos < 1; pos += 0.01) {
    if (pos < 0.5) {
      // I want to scale the lerpColor from 0 to 1 for half the ellipse
      lc = lerpColor(color(0, 0, 255), color(255, 0, 0), pos * 2);
    } else {
      // I want to scale the lerpColor from 1 to 0 from the other half of the ellipse
      lc = lerpColor(color(255, 0, 0), color(0, 0, 255), (pos * 2) - 1);
    }
    // The stroke and fill are the lerp colors
    stroke(lc);
    fill(lc);
    // I used circle instead of point so it's more visible
    // This uses trig to get the point on the ellipse based on the position
    circle((w / 2) * cos(TWO_PI * pos), (h / 2) * sin(TWO_PI * pos), 4);
  }
  popMatrix();
}
