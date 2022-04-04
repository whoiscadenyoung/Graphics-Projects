void setup() {
  size(500,500);
}

void draw() {
  background(0);
  // Calling the recursive function with arguments
  // Reps is the depth you want to recurse, circles is the number of circles to draw in each shape
  // So you can play around and draw different things here
  fracCircle(width/2, height/2, width, 5, 4);
}

void fracCircle(float x, float y, float diameter, int circles, int reps) {
  noFill();
  stroke(255);
  // Draw the circle with the passed in coordinates and diameter
  circle(x, y, diameter);
  
  // Radius of larger circle is diameter / 2
  float outerRadius = diameter / 2;
  // Radius of inner circle (which the other circles will wrap around) is done using some trig here
  float innerRadius = (outerRadius - (outerRadius * sin(PI / circles))) / (sin(PI / circles) + 1);
  // Diameter of circles in ring is the difference between outer and inner radii
  float ringDiameter = outerRadius - innerRadius;
  // The distance to the center for the rings is the sum of outer and inner radii divided by two
  float ringCenter = (outerRadius + innerRadius) / 2;
  // This breaks up the unit circle into segments based on the number of circles you want to draw
  float theta = TWO_PI / circles;
  
  // If the base has not been reached yet
  if (reps > 0) {
    // For each circle you want to draw
    for (int i = 1; i <= circles; i++) {
      // Calls fracCircle with the new x, y, diameter, and decremented reps
      fracCircle(ringCenter * cos(theta * i) + x, ringCenter * sin(theta * i) + y, ringDiameter, circles, reps - 1);
    }
  }
  
  
}
