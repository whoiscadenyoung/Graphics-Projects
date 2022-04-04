public class Car {
  PShape car, car2;
  PShape wheel;
  Car() {
    car = createShape(BOX, 150, 30, 100);
    car2 = createShape(BOX, 80, 20, 100);
    car.setFill(color(100, 10, 10));
    car2.setFill(color(100, 10, 10));
    wheel = createShape();
    wheel.setFill(color(0));
    wheel.beginShape(QUADS);
    float uStep = 2*PI/20;
    float vStep = PI/20;
    float radius = 40;
    for(float u=0; u<2*PI; u += uStep) {
      for(float v=0; v<radius; v += vStep) {
        createRingVertex(u, v, radius / 2);
        createRingVertex(u, v+vStep, radius / 2);
        createRingVertex(u+uStep, v+vStep, radius / 2);
        createRingVertex(u+uStep, v, radius / 2);
      }
    }
    wheel.endShape();
  }
  
  void createRingVertex(float u, float v, float r) {
    PVector pt = new PVector(r * sin(u), r*cos(u), v);
    PVector norm = pt.copy().normalize();
    normal(norm.x, norm.y, norm.z);
    wheel.vertex(pt.x, pt.y, pt.z, map(u, 0,2*PI, 0,1), map(v, -PI/2,PI/2, 0,1));
  }
  void display(PVector cam) {
    pushMatrix();
    shapeMode(CORNER);
    translate(cam.x, cam.y - 30, cam.z);
    shape(car);
    translate(0, -20, 0);
    shape(car2);
    translate(-40, 30, -65);
    shape(wheel);
    translate(0, 0, 95);
    shape(wheel);
    translate(80, 0, 0);
    shape(wheel);
    translate(0, 0, -100);
    shape(wheel);
    popMatrix();
  }
}
