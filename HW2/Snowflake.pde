class Snowflake {
  int degrees, level, stroke;
  String axiom;
  StringDict rules;
  String system;
  Boolean falling = true;
  float x, y;
  float rate;
  
  color lightblue = color(206, 228, 242);
  color darkblue = color(117, 163, 191);

  Snowflake(int _degrees, int _level, String _axiom, StringDict _rules, float _x, float _y) {
    degrees = _degrees;
    level = _level;
    stroke = level + 1;
    axiom = _axiom;
    rules = _rules;
    system = writeSystem(axiom, level);
    x = _x; y = _y;
    rate = (float)Math.random() * 4 + 1;
    println("Created snowflake of degrees: " + degrees + ", level: " + level + ", axiom: " + axiom + ", rules: " + rules);
    println("Generated system: " + system);
  }
  
  void setX(float _x) {x = _x;}
  
  void display(float len) {
    if (mouseX < x) x -= rate / 2;
    if (mouseX > x) x += rate / 2;
    if (falling) {
      if (y < height) y += rate;
      else {
        float randX = (float)Math.random();
        x = map(randX, 0, 1, 0, width);
        y = 0;
        rate = (float)Math.random() * 4 + 1;
      }
    }
    color current = lightblue;
    pushMatrix();
    translate(x, y);
    for(int i = 0; i < system.length(); i++) {
      char c = system.charAt(i);
      if (c == 'G') { 
        strokeWeight(2);
        stroke(current);
        line(0, 0, 0, -len); 
        translate(0, -len); 
      }
      if (c == '-') { 
        rotate(-PI / degrees); 
        current = lightblue;
      }
      if (c == '+') { 
        rotate(PI / degrees);
        current = darkblue;
      }
      if (c == '[') { pushMatrix(); }
      if (c == ']') { popMatrix(); }
    }
    popMatrix();
  }

  String applyRules(String axiom) {
    String start = "";
    for (int i = 0; i < axiom.length(); i++) {
      String character = String.valueOf(axiom.charAt(i));
      if (rules.hasKey(character)) {
        start += rules.get(character);
      } else {
        start += character;
      }
    }
    return start;
  }

  String writeSystem(String axiom, int n) {
    String iteration = axiom;
    for (int i = 0; i < n; i++) {
      iteration = applyRules(iteration);
    }
    return iteration;
  }
}
