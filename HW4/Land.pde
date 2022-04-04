public class Land {
  PShape land;
  Land(PImage img, float diam) {
    
    land = createShape();
    land.setTexture(img);
    land.setStroke(color(0, 0));
    
    land.beginShape();
    land.textureMode(NORMAL);
    float theta = TWO_PI / 60;
    for (int i=0; i< 60; i++) {
      float angle = theta * i;
      float x = cos(angle);
      float y = sin(angle);
      land.vertex(x * diam, y * diam, (x+1)/2, (y+1)/2);
    }
    land.endShape();
  }
  void display(PVector cam) {
    pushMatrix();
    translate(cam.x, cam.y, cam.z);
    rotateX(PI/2);
    shapeMode(CORNER);
    shape(land);
    popMatrix();
  }
}
