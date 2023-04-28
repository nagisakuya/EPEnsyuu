MineField mineField;
import processing.awt.PSurfaceAWT;

final int TITLE_BAR_HIGHT = 32;

PVector displayPos = new PVector(0, 0);
void Update() {
  PSurfaceAWT.SmoothCanvas   canvas;
  canvas = (PSurfaceAWT.SmoothCanvas)getSurface().getNative();
  displayPos = new PVector(canvas.getFrame().getX(),canvas.getFrame().getY()+TITLE_BAR_HIGHT);
}

Window display;

void setup() {
  size(600, 700);
  mineField = new QuantumMineField(15, 15, 40);
   display = new Window(new PVector(0,0),new PVector(displayWidth,displayHeight));
}

void draw() {
  mineField.Draw();
  Update();
}

void mousePressed() {
  mineField.ClickedEvent();
}
