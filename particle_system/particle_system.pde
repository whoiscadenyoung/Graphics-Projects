PShader pointShade;
PImage car, bg;
float rot = 0;
float weight = 25;
ArrayList<PVector> pts;

// Right click and drag the mouse to tilt the map up and down
void setup() {
  size(750, 750, P3D);
  
  // Load in images to use
  bg = loadImage("roundabout.png");
  car = loadImage("car.png");
  
  // Set up shaders
  //pointShade = loadShader("ptfrag.glsl","ptvert.glsl");
  pointShade = loadShader("ptfragbb.glsl","ptvertbb.glsl");
  pointShade.set("weight", weight);
  pointShade.set("sprite", car);
  
  pts = new ArrayList<PVector>();
  for (int i = 1; i < 6; i++) {
    // Since the points are rotating around a center, these PVectors will be more containers than actual coordinates
    // R will be in x, theta will be in y, they will be converted on runtime, speed will be in the z
    float rand = random(1, 10);
    for (int n = 1; n < rand; n++) {
      pts.add(new PVector(125 + i * weight, 0, random(0.001, 0.008)));
    }
  }
}

void draw() {
  background(color(0));
  shader(pointShade, POINTS);
  
  // Add a rotation aspect to see the graphics
  translate(width/2,height/2);
  rotateX(rot);
  translate(-width/2,-height/2);
  
  // Draw the track to demonstrate how the points remain locked to the screen perspective
  imageMode(CENTER);
  image(bg, width/2, height/2);
  
  // Set the stroke for the points
  stroke(255);
  strokeCap(SQUARE);
  strokeWeight(weight);
  
  // Draw the points on the track to race around the roundabout
  for (PVector pt : pts) {
    float x = pt.x * cos(pt.y);
    float y = pt.x * sin(pt.y);
    float z = 10;
    pushMatrix();
    translate(width/2, height/2, 0);
    point(x, y, z);
    popMatrix();
    pt.y += pt.z;
  }
}

// To allow you to tilt and see the cars
void mouseDragged() {
  if(mouseButton == RIGHT) {
    rot += float(mouseY - pmouseY)/width;
  }
}
