public class Rug {
  PShape rug;
  Rug(PImage img) {
    rug = createShape(RECT, 0, 0, 300, 300);
    rug.setTexture(img);
    rug.setStroke(color(0, 0));
  }
  void display(PVector cam, float rugAngle) {
    pushMatrix();
    translate(cam.x, cam.y, cam.z);
    rotateX(PI/2);
    rotateY(rugAngle);
    rotateZ(PI/2);
    shapeMode(CENTER);
    shape(rug);
    popMatrix();
  }
}
