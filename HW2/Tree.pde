class Tree {
  int level, stroke;
  float degrees;
  String axiom;
  StringDict rules;
  String system;
  
  color leaf = color(103,126,82);
  color branch = color(137,114,91);
  color berry = color(246,232,177);

  Tree(float _degrees, int _level, String _axiom, StringDict _rules) {
    degrees = _degrees;
    level = _level;
    stroke = level + 1;
    axiom = _axiom;
    rules = _rules;
    system = writeSystem(axiom, level);
    println("Created tree of degrees: " + degrees + ", level: " + level + ", axiom: " + axiom + ", rules: " + rules);
    println("Generated system: " + system);
  }
  
  void display(float x, float y, float len) {
    degrees = map(mouseX, 0, width, 6, 7);
    pushMatrix();
    translate(x, y);
    for(int i = 0; i < system.length(); i++) {
      strokeWeight(stroke);
      char c = system.charAt(i);
      if (c == 'F') { 
        fill(branch);
        stroke(branch);
        line(0, 0, 0, -len); 
        translate(0, -len); 
      }
      if (c == '0') {
        stroke(leaf);
        fill(leaf);
        bezier(0, 0, 0, -len / 2, 0, -len / 2, -len / 2, -len);
        translate(0, -len);
      }
      if (c == '1') {
        stroke(leaf);
        fill(leaf);
        bezier(0, 0, 0, -len / 2, 0, -len / 2, len / 2, -len);
        translate(0, -len);
      }
      if (c == 'B') {
        stroke(berry);
        fill(berry);
        circle(0,0,len / 3);
        translate(0, -len);
      }
      if (c == 'R') {
        stroke -= 1;
      }
      if (c == 'E') {
        stroke += 1;
      }
      if (c == '-') { 
        rotate(-PI / degrees); 
      }
      if (c == '+') { 
        rotate(PI / degrees);
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
