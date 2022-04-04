
int level;
int degrees;
String axiom;
Tree tree, tree2;
ArrayList<Snowflake> snowflakes;

void setup() {
  size(800,800);

  StringDict treeRules1 = new StringDict();
  treeRules1.set("X", "RF-[[X[-1]]+XB]+F[+FX[+0]]-XE");
  treeRules1.set("F", "FF");
  tree = new Tree(7, 5, "X", treeRules1);
  
  StringDict treeRules2 = new StringDict();
  treeRules2.set("X", "RF-[[X[-0]]+XB]+F[-FX]+F[-FX[+1]]+XE");
  treeRules2.set("F", "FF");
  tree2 = new Tree(7, 5, "X", treeRules2);
  
  StringDict snowRules = new StringDict();
  snowRules.set("G", "GG[--G][++G]");
  
  snowflakes = new ArrayList<Snowflake>();
  for (int i = 0; i < 10; i++) {
    float randX = (float)Math.random();
    float randY = (float)Math.random();
    snowflakes.add(new Snowflake(4, 4, "G+G+G+G+G+G+G+G", snowRules, map(randX, 0, 1, 0, width - 50), map(randY, 0, 1, 0, height)));
  }
}

void draw() {
  background(255);
  strokeCap(SQUARE);
  float len = height / pow(3, 4);
  tree.display(width / 4 * 3, height, len * 0.6);
  tree2.display(width / 3, height, len / 3 * 2);
  for (Snowflake snowflake : snowflakes) {
    snowflake.display(len / 6);
  }
}
