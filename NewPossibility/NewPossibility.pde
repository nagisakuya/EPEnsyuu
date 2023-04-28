

void setup() {
  surface.setLocation(100, 400) ;
  surface.setResizable(true);
  size(160, 400);
  textFont(createFont("Meiryo", 30));
}

void draw() {
  background(0);
  pushMatrix();
  scale(width/160.0, 1);
  pushMatrix();
  scale(160.0/(txt.length()*400), 1);
  textSize(400);
  text(txt, 0, 350.0);
  popMatrix();

  pushMatrix();
  scale(160.0/(6.5*10), 1);
  textSize(10);
  text(txt2, 0, 420.0);
  popMatrix();

  popMatrix();
}












String txt = "ウィンドウ芸の新しい可能性を発見しました";
String txt2 = "宮下先生LOVE";
