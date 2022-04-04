public class Tree {
  PShape tree;
  float radius;
  Tree(float radius) {
    this.radius = radius;
    tree = createShape();
    tree.setFill(color(1, 68, 35));
    float angle = 0;
    float angleIncrement = TWO_PI / 20;
    tree.beginShape(QUAD_STRIP);
    for (int i = 0; i < 20 + 1; ++i) {
      tree.vertex(0, 0, 0);
      tree.vertex(radius*cos(angle), radius * 3, radius*sin(angle));
      angle += angleIncrement;
    }
    tree.endShape();
  }
  
  void display(PVector cam) {
    pushMatrix();
    shapeMode(CORNER);
    translate(cam.x, cam.y - radius, cam.z);
    shape(tree);
    popMatrix();
  }
  
  
}
