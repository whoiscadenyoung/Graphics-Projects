import java.util.*;

PVector eyeCam, centerCam, tiltCam;
HashSet<Character> keys;
float qw, as, ty, gh, op;

// Movements: 
// Arm follows mouse movement
// Q/W rotate shoulder joint, A/S rotate shoulder twist, 
// T/Y rotate angle between upper and lower arm, G/H lower arm twist, 
// O/P bend the last joint up and down 

void setup() {
  size(600, 600, P3D);
  
  // Create the hash set
  keys = new HashSet();
  
  eyeCam = new PVector(width/2, height/2, (height/2) / tan(PI/6));
  centerCam = new PVector(width/2, height/2, 0);
  tiltCam = new PVector(0, 1, 0);
  
  // Initialize the angles;
  qw = 0;
  as = 0;
  ty = 0;
  gh = 0;
  op = 0;
}

void draw() {
  background(0);
  
  // Add the mouse-based rotation
  eyeCam.x = mouseX;
  eyeCam.y = mouseY;
  camera(eyeCam.x, eyeCam.y, eyeCam.z, centerCam.x, centerCam.y, centerCam.z, tiltCam.x, tiltCam.y, tiltCam.z);
  
  // These checks are grouped/nested so you can't cancel out your own movements
  // However you can do multiple at the same time of different joints/bones
  if (keys.contains('q') || keys.contains('w')) {
    if (keys.contains('q')) {
      qw += 0.02;
    } else {
      qw -= 0.02;
    }
  }
  if (keys.contains('a') || keys.contains('s')) {
    if (keys.contains('a')) {
      as -= 0.02;
    } else {
      as += 0.02;
    }
  } 
  if (keys.contains('t') || keys.contains('y')) {
  if (keys.contains('t')) {
      ty += 0.02;
    } else {
      ty -= 0.02;
    }
  }
  if (keys.contains('g') || keys.contains('h')) {
  if (keys.contains('g')) {
      gh += 0.02;
    } else {
      gh -= 0.02;
    }
  }
  if (keys.contains('o') || keys.contains('p')) {
  if (keys.contains('o')) {
      op += 0.02;
    } else {
      op -= 0.02;
    }
  }
  
  // Set up the scene
  lights();
  noStroke();
  translate(centerCam.x, centerCam.y, centerCam.z);
  
  // Shoulder Joint Q/W
  rotateZ(qw);
  sphere(15);
  
  // Upper arm A/S
  translate(75, 0, 0);
  rotateX(as);
  box(150, 15, 15);
  
  // Elbow joint T/Y
  translate(75, 0, 0);
  rotateZ(ty);
  sphere(12);
  
  // Lower arm G/H
  translate(40, 0, 0);
  rotateX(gh);
  box(80, 12, 12);
  
  // Wrist joint O/P
  translate(40, 0, 0);
  rotateZ(op);
  sphere(10);
  
  // Wrist segment (no controls)
  translate(25, 0, 0);
  box(50, 10, 10);
}

// I add any key pressed as it's easier and the set is short (only so many possible keys)
void keyPressed() {
  keys.add(key);
}

void keyReleased() {
  keys.remove(key);
}
