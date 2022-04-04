public class Sky {
  PShape sky;
  Sky(PImage img, float radius) {
    noStroke();
    sphereDetail(60);
    
    sky = createShape(SPHERE, radius);
    sky.setTexture(img);
    // This is noStroke() before creating it maybe?
    sky.setStroke(color(0, 0));
  }
  
  void display(PVector cam) {
    pushMatrix();
    translate(cam.x, cam.y, cam.z);
    shapeMode(CORNER);
    shape(sky);
    popMatrix();
  }
}
