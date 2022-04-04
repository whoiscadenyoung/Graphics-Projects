PImage img;
PVector eyeCam, centerCam, tiltCam;
float constant, number, radius;
float rot;

// Camera follows mouse movements. Right click and drag to change the angle of the camera
void setup() {
  size(1000, 1000, P3D);
  background(0);
  
  // Camera positions
  eyeCam = new PVector(width/2, height/2, (height/2) / tan(PI/6));
  centerCam = new PVector(width/2, height/2, 0);
  tiltCam = new PVector(0, 1, 0);
  
  // Setting up the math; constant is the golden number
  // Can adjust number and radius to scale the sunflower seeds
  constant = (1 + sqrt(5)) / 2;
  number = 300;
  radius = 20;
  rot = 0;
}

void draw() {
  background(0);
  camera(mouseX, mouseY, eyeCam.z, centerCam.x, centerCam.y, centerCam.z, tiltCam.x, tiltCam.y, tiltCam.z);
  
  // Do a rotate based on right clicking and dragging (this is separate from camera for extra functionality, to see the dome better)
  translate(centerCam.x, centerCam.y, centerCam.z);
  rotateX(rot);
  translate(-centerCam.x, -centerCam.y, -centerCam.z);
  
  // Turn on the lights
  lightSpecular(width/2, height/2, 0);
  lights();
  // Theta is the angle of rotation around the unit circle, so it's the angle of rotation around origin
  // R is the distance from the center of the circle,
  // For each shape being drawn, convert the polar coordinates to normal coordinates, get the color based on the current n
  // For the dome, I map the number to a smaller range to flatten it
  for (int n = 0; n < number; n++) {
    // Define variables to draw sphere
    color blue = color(0, 0, 200);
    color red = color(200, 0, 0);
    color col = lerpColor(blue, red, n / number);
    float r = r(n);
    float theta = theta(n);
    float x = r * cos(theta);
    float y = r * sin(theta);
    float z = map(-n, -number, 0, -150, 0);
    
    // Set the color for the sphere
    fill(col);
    stroke(0);
    strokeWeight(0);

    pushMatrix();
    
    // Translate by the converted polar coodinates
    translate(x * (radius * 1.1), y * (radius * 1.1), z);
    
    // Move the object to the center of the screen
    translate(centerCam.x, centerCam.y, centerCam.z);
    
    // Draw the sphere
    sphere(radius);
    popMatrix();
  }
}

// Creating the polar coordinates
float theta(float n) {
  return 2 * PI * constant * n;
}

float r(float n) {
  return sqrt(n);
}

void mouseDragged() {
  if(mouseButton == RIGHT) {
    rot += float(mouseY - pmouseY)/width;
  }
}
