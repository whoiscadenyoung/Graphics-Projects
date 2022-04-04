// Imports for the toxic library
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;

PImage img;
Shape shape;
PVector rotAxis;
float xangle;
float vangle;
float angle;

void setup() {
  size(600,600, P3D);
  img = loadImage("brushedgold.jpg");
  shape = new Shape(80, 40, 40, img);
  
  angle = 0;
  rotAxis = new PVector(0, 400, 100);
}

void draw() {
  background(0);
    
  translate(width/2,height/2,0);
  //rotateY(map(mouseX, 0,width, 0,2*PI));
  //rotateX(-PI/2 + vangle);
  //rotateZ(-xangle);
  
  // Rotates around the axis
  rotateAroundAxisAgain(rotAxis, angle);
  
  noStroke();
  textureMode(NORMAL);
  
  // Displays the complex shape (ring and gem)
  shape.display();
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    xangle += float(pmouseX-mouseX)/width;
    vangle += float(pmouseY-mouseY)/height; 
    
    // I recreate the axis each time the mouse is dragged.
    rotAxis = new PVector(rotAxis.x + mouseX-pmouseX, rotAxis.y + mouseY-pmouseY, rotAxis.z);
    float diff = mouseX - pmouseX;
    angle += diff/width;
  }
}

// Code below was used in your example files for rotation around an arbitrary axis
void rotateAroundAxis(PVector axis, float theta) {
  PVector w = axis.get();
  w.normalize();
  PVector t = w.get();
  if (abs(w.x) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.x = 1;
  } else if (abs(w.y) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.y = 1;
  } else if (abs(w.z) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.z = 1;
  }
  PVector u = w.cross(t);
  u.normalize();
  PVector v = w.cross(u);
  applyMatrix(u.x, v.x, w.x, 0, 
  u.y, v.y, w.y, 0, 
  u.z, v.z, w.z, 0, 
  0.0, 0.0, 0.0, 1);
  rotateZ(theta);
  applyMatrix(u.x, u.y, u.z, 0, 
  v.x, v.y, v.z, 0, 
  w.x, w.y, w.z, 0, 
  0.0, 0.0, 0.0, 1);
}

void rotateAroundAxisAgain(PVector axis, float theta) {
  PVector n = axis.get();
  n.normalize();

  if(n.x == 0 && n.z == 0) {
    if(n.y > 0) theta = -theta;
    rotateY(theta);
    return;
  }
  
  float phi = asin(n.x / sqrt(n.x*n.x + n.z*n.z));
  if(n.z < 0) phi = PI - phi;

  n = new PVector(n.x*cos(phi) - n.z*sin(phi), n.y, n.x*sin(phi) + n.z*cos(phi));

  float gamma = acos(n.dot(new PVector(0, 0, -1)));
  if (axis.y < 0) gamma = acos(n.dot(new PVector(0, 0, 1)));

  rotateY(phi);
  rotateX(gamma);
  if(n.y > 0) theta = -theta;
  rotateZ(theta);
  rotateX(-gamma);
  rotateY(-phi);
}
