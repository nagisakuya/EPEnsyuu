float[] pos_x = new float[900];
float[] pos_y = new float[900];
float[] speed_x = new float[900];
float[] speed_y = new float[900];

void setup() {
  for (int i=0; i<900; i++) {
    pos_x[i] = (i/30)*30;
    pos_y[i] = (i%30)*30;
  }
  size(900, 900);
  noStroke();
  fill(0);
}

void draw() {
  background(255);
  for (int i=0; i<900; i++) {
    if (mousePressed == true) {
      float dist = sqrt(pow(mouseX-pos_x[i], 2)+pow(mouseY-pos_y[i], 2));
      speed_x[i]+=(mouseX-pos_x[i])/dist;
      speed_y[i]+=(mouseY-pos_y[i])/dist;
    }
    pos_x[i]=pos_x[i]+speed_x[i];
    pos_y[i]=pos_y[i]+speed_y[i];
    speed_x[i] = speed_x[i] * 0.97;
    speed_y[i] = speed_y[i] * 0.97;
    ellipse(pos_x[i], pos_y[i], 5, 5);
  }
}
