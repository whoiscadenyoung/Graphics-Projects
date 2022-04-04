PVector center, position;
PImage skyTexture, rugTexture, landTexture;
Sky sky;
Rug rug;
Tree tree, tree2;
Land land;
Car car;
PVector eyeCam, centerCam, tiltCam, rugCam;
ArrayList<PVector> increments;

// Playing with stuff
float radius;
float pitch;
float x, y, z;
float rugAngle;
float angle;

void setup() {
  size(800, 800, P3D);
  
  // Size of world, angle of rug
  radius = 4000;
  rugAngle = 0;
  
  // Loat in textures
  skyTexture = loadImage("sky.jpg");
  rugTexture = loadImage("rug.jpg");
  landTexture = loadImage("land.jpg");
  
  // Load in objects; each object uses a combination of shape, texture, fill, etc
  // You can check out all these objects in their respective files
  sky = new Sky(skyTexture, radius);
  rug = new Rug(rugTexture);
  land = new Land(landTexture, radius);
  tree = new Tree(80);
  tree2 = new Tree(40);
  car = new Car();
  
  // Create vectors for the camera and angle of the world
  eyeCam = new PVector(width/2, height/2 - 100, (height/2) / tan(PI/6));
  centerCam = new PVector(width/2, height/2 - 100, 0);
  tiltCam = new PVector(0, 1, 0);
  angle = 0;
  
  // Create vectors for center of screen, rug, position of world
  center = new PVector(width/2, height/2, 0);
  rugCam = new PVector(width/2, height/2, 0);
  position = new PVector(width/2, height/2 + 200, 0);
  
  // Create an array of random positions to draw trees at
  increments = new ArrayList<PVector>();
  for (float x = -radius; x < radius; x += random(100, 500)) {
    for (float z = -radius; z < radius; z += random(100, 500)) {
      if (abs(x) > 100 && abs(z) > 100) increments.add(new PVector(x, random(0,50), z));
    }
  }
  
  pushMatrix();
}

void draw() {
  // Pan by moving eye and scene center: camera(mouseX, height/2, (height/2) / tan(PI/6), mouseX, height/2, 0, 0, 1, 0);
  // Rotate around by moving eye: camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  // Eye position: width/2, height/2, (height/2) / tan(PI/6)
  // Scene center: width/2, height/2, 0
  // Upwards axis, 0, 1, 0
  
  // Popping here is intended to keep the camera in the same position with every draw
  popMatrix();
  // What to do when a mouse button is pressed; left is roll, right is tilt
  if (mousePressed) {
    if (mouseButton == LEFT) eyeCam = new PVector(mouseX, min(450, mouseY), eyeCam.z);
    if (mouseButton == RIGHT) {
      rugAngle = map(mouseX, 0, width, -PI/8, PI/8);
      tiltCam = new PVector(map(mouseX, 0, width, 0.5, -0.5), tiltCam.y, tiltCam.z);
    }
    println(mouseX, mouseY);
  }
  
  // What to do when a key is pressed
  if (keyPressed) {
    if (key == 'w') {
      // position.z += 5;
      centerCam.z -= 5;
      eyeCam.z -= 5;
      rugCam.z -= 5;
    }
    if (key == 's') {
      //position.z -= 5;
      centerCam.z += 5;
      eyeCam.z += 5;
      rugCam.z += 5;
    }
    if (key == 'a') angle -= 0.01;
    if (key == 'd') angle += 0.01;
    println(position);
  }
  
  // Set the perspective to narrow the field of view, set the camera based on vectors
  float fov = PI/6;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
  camera(eyeCam.x, eyeCam.y, eyeCam.z, centerCam.x, centerCam.y, centerCam.z, tiltCam.x, tiltCam.y, tiltCam.z);
  
  pushMatrix();
  // Rotate the world to reflect the key movements
  translate(position.x, position.y, position.z);
  rotateY(angle);
  translate(-position.x, -position.y, -position.z);
  
  // Draw the elements based on the position; previously I moved the position with every transformation
  sky.display(position);
  land.display(position);
  car.display(position);
  // This draws trees from the random increments array
  for (PVector increment : increments) {
    if (increment.y < 25) tree.display(new PVector(increment.x + position.x, position.y, increment.z + position.z));
    else tree2.display(new PVector(increment.x + position.x, position.y, increment.z + position.z));
  }
  popMatrix();
  // Display the rug and if it's tilting or not
  rug.display(rugCam, rugAngle);
    
  pushMatrix();
}
