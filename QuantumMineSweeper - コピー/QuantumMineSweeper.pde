MineField mineField;

void setup(){
  size(600,700);
  mineField = new MineField(10,10,5);
}


void draw(){
  mineField.Draw();
}

void mousePressed(){
  mineField.ClickedEvent();
}
