PImage img;
Shell shell;
PVector eyeCam, centerCam, tiltCam;

// Camera follows mouse movements on screen
void setup() {
  size(600, 600, P3D);
  img = loadImage("rug.jpg");
  shell = new Shell(img, 30, 50);
  
  eyeCam = new PVector(width/2, height/2, (height/2) / tan(PI/6));
  centerCam = new PVector(width/2, height/2, 0);
  tiltCam = new PVector(0, 1, 0);
}

void draw() {
  background(0);
  
  // Set up camera based on mouse
  eyeCam.x = mouseX;
  eyeCam.y = mouseY;
  camera(eyeCam.x, eyeCam.y, eyeCam.z, centerCam.x, centerCam.y, centerCam.z, tiltCam.x, tiltCam.y, tiltCam.z);
  
  // Display the shell in center of screen
  shell.display(centerCam);
}
