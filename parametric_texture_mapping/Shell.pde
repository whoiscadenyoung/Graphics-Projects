public class Shell {
  PImage img;
  int segments;
  float radius;
  
  // Construct shell based on segments to draw and the size
  Shell(PImage img, int segments, float radius) {
    this.img = img;
    this.segments = segments;
    this.radius = radius;
  }
  
  // Create vertex using the parametric formula; normalize it for textures
  void createVertex(float t, float s) {
    float x = radius * pow(4/float(3), s) * sin(t) * sin(t) * cos(s);
    float y = radius * pow(4/float(3), s) * sin(t) * sin(t) * sin(s);
    float z = radius * pow(4/float(3), s) * sin(t) * cos(t);
    PVector pt = new PVector(x, y, z);
    PVector norm = pt.copy().normalize();
    normal(norm.x, norm.y, norm.z);
    vertex(pt.x, pt.y, pt.z, map(t, 0,PI, 0,1), map(s, 0,2*PI, 0,1));
  }
  
  // Draw the shell. noStroke removed lines, translate moves to center,
  // Rotate flips it upright, shape uses t and s step like the formula
  void display(PVector position) {
    pushMatrix();
    noStroke();
    translate(position.x, position.y, position.z);
    rotateX(PI);
    textureMode(NORMAL);
    beginShape(QUADS);
    texture(img);
    float tStep = PI/segments;
    float sStep = 2*PI/segments;
    for(float t=0; t < PI; t += tStep) {
      for(float s=0; s < 2 * PI; s += sStep) {
        createVertex(t, s);
        createVertex(t, s + sStep);
        createVertex(t + tStep, s + sStep);
        createVertex(t + tStep, s);
      }
    }
    endShape();
    popMatrix();
  }
}
