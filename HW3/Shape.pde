class Shape {
  float r;
  int nSegs;
  PImage img;
  float R;
 
  Shape(float Radius, float radius, int numSegments, PImage pic) {
    nSegs = numSegments;
    r = radius;
    R = Radius;
    img = pic;
  }
  
  void display() {
    // Create lighting for the ring part
    // Specify color of light source for shininess
    lightSpecular(212,175,55);
    shininess(1);
    // Adds ambient light so entire shape is lit up somewhat
    ambientLight(212,175,55);
    ambient(198, 136, 86);
    pointLight(238,232,170, 0, width, 0);
    //emissive(170, 108, 57);

    // Draw the ring shape using quads for the surface, texture mapped onto that
    drawRing();
    
    // Change the lighting for the gem
    lightSpecular(67, 127, 249);
    ambientLight(112,209,244);
    ambient(67, 127, 249);
    //pointLight(112,209,244, 0, width, 0);
    drawGem();
    
    fill(255);
    stroke(255);
  }
  
  // createVertex function was modified so that it would draw a ring instead of a sphere
  void createRingVertex(float u, float v) {
    PVector pt = new PVector((R + r*cos(v)) * cos(u), (R + r*cos(v)) * sin(u), r*sin(v));
    PVector norm = pt.copy().normalize();
    normal(norm.x, norm.y, norm.z);
    vertex(pt.x, pt.y, pt.z, map(u, 0,2*PI, 0,1), map(v, -PI/2,PI/2, 0,1));
  }
  
  // Draws the ring shape
  void drawRing() {
    beginShape(QUADS);
    texture(img);
    float uStep = 2*PI/nSegs;
    float vStep = PI/nSegs;
    for(float u=0; u<2*PI; u += uStep) {
      for(float v=-PI/2; v<PI/2; v += vStep) {
        createRingVertex(u, v);
        createRingVertex(u, v+vStep);
        createRingVertex(u+uStep, v+vStep);
        createRingVertex(u+uStep, v);
      }
    }
    endShape();
  }
  
  // Draws the gem shape (two pyramids on top of each other)
  void drawGem() {
    float size = r / 3 * 2;
    float xySize = r;
    float zSize = size / 3;
    
    // Creating the vectors for the pyramid
    PVector a = new PVector(0, 0, 0);
    PVector b = new PVector(xySize, 0, -size);
    PVector c = new PVector(0, xySize, -size);
    PVector d = new PVector(-xySize, 0, -size);
    PVector e = new PVector(0, -xySize, -size);
    
    // The translation and rotation necessary to draw the gem
    translate(R + size, 0);
    
    // Drawing the gem
    pushMatrix();
    rotateX(PI/2);
    rotateY(3 *PI/2);
    
    beginShape(TRIANGLES);
    PVector ABCnorm = PVector.sub(c,a);
    ABCnorm = ABCnorm.cross(PVector.sub(b,a));
    ABCnorm.normalize();
    normal(ABCnorm.x,ABCnorm.y,ABCnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    
    PVector ACDnorm = PVector.sub(a,c);
    ACDnorm = ACDnorm.cross(PVector.sub(c,d));
    ACDnorm.normalize();
    normal(ACDnorm.x,ACDnorm.y,ACDnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(c.x,c.y,c.z);
    vertex(d.x,d.y,d.z);
    
    PVector ADEnorm = PVector.sub(a,d);
    ADEnorm = ADEnorm.cross(PVector.sub(d,e));
    ADEnorm.normalize();
    normal(ADEnorm.x,ADEnorm.y,ADEnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(d.x,d.y,d.z);
    vertex(e.x,e.y,e.z);
    
    PVector AEBnorm = PVector.sub(a,e);
    AEBnorm = AEBnorm.cross(PVector.sub(e,b));
    AEBnorm.normalize();
    normal(AEBnorm.x,AEBnorm.y,AEBnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(e.x,e.y,e.z);
    vertex(b.x,b.y,b.z);
    endShape();
    
    popMatrix();
    
    // Recreate the vectors for the second pyramind on top of the first
    a = new PVector(0, 0, 0);
    b = new PVector(xySize, 0, -zSize);
    c = new PVector(0, xySize, -zSize);
    d = new PVector(-xySize, 0, -zSize);
    e = new PVector(0, -xySize, -zSize);
    
    // Draw the second gem
    pushMatrix();
    translate(size + zSize, 0);
    rotateY(PI/2);
    
    beginShape(TRIANGLES);
    ABCnorm = PVector.sub(c,a);
    ABCnorm = ABCnorm.cross(PVector.sub(b,a));
    ABCnorm.normalize();
    normal(ABCnorm.x,ABCnorm.y,ABCnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    
    ACDnorm = PVector.sub(a,c);
    ACDnorm = ACDnorm.cross(PVector.sub(c,d));
    ACDnorm.normalize();
    normal(ACDnorm.x,ACDnorm.y,ACDnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(c.x,c.y,c.z);
    vertex(d.x,d.y,d.z);
    
    ADEnorm = PVector.sub(a,d);
    ADEnorm = ADEnorm.cross(PVector.sub(d,e));
    ADEnorm.normalize();
    normal(ADEnorm.x,ADEnorm.y,ADEnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(d.x,d.y,d.z);
    vertex(e.x,e.y,e.z);
    
    AEBnorm = PVector.sub(a,e);
    AEBnorm = AEBnorm.cross(PVector.sub(e,b));
    AEBnorm.normalize();
    normal(AEBnorm.x,AEBnorm.y,AEBnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(e.x,e.y,e.z);
    vertex(b.x,b.y,b.z);
    endShape();
    
    popMatrix();
    
    /*
    beginShape(TRIANGLES);
    vertex(-xySize, -xySize, -size);
    vertex(xySize, -xySize, -size);
    vertex(   0,    0,  size);
    
    vertex(xySize, -xySize, -size);
    vertex( xySize,xySize, -size);
    vertex(   0,    0,  size);
    
    vertex( xySize, xySize, -size);
    vertex(-xySize, xySize, -size);
    vertex(   0,   0,  size);
    
    vertex(-xySize,  xySize, -size);
    vertex(-xySize, -xySize, -size);
    vertex(   0,    0,  size);
    endShape(CLOSE);
    popMatrix();
    
    pushMatrix();
    translate(size + zSize, 0);
    rotateY(PI/2);
    beginShape(TRIANGLES);
    vertex(-xySize, -xySize, -zSize);
    vertex(xySize, -xySize, -zSize);
    vertex(   0,    0,  zSize);
    
    vertex(xySize, -xySize, -zSize);
    vertex( xySize,xySize, -zSize);
    vertex(   0,    0,  zSize);
    
    vertex( xySize, xySize, -zSize);
    vertex(-xySize, xySize, -zSize);
    vertex(   0,   0,  zSize);
    
    vertex(-xySize,  xySize, -zSize);
    vertex(-xySize, -xySize, -zSize);
    vertex(   0,    0,  zSize);
    endShape(CLOSE);
    popMatrix();
    */
  }
}
