//Lyapunov fractal を描画します！
//描画にちょっと時間がかかるよ
//毎回違うのが描画されるよ！
boolean[] base = new boolean[(int)random(5,10)];

float Lyapunov(boolean[] base, float a, float b) {
  int N = 100;
  float x = 0.5;
  float sum = 0;
  for (int i = 0; i<N; i++) {
    float r = base[i % base.length] ? a : b;
    x = r*x*(1-x);
    r = base[(i + 1) % base.length] ? a : b;
    sum += log(abs(r * (1 - 2 * x)));
  }
  return sum/N;
}

void setup() {
  size(800,800);
  for (int i = 0; i<base.length; i++) {
    if ((int)random(0, 2) == 1) {
      base[i] = true;
      print("A");
    } else {
      base[i] = false;
      print("B");
    }
  }
  println();
  background(255);
  float max=Float.MIN_VALUE;
  float result[][] = new float[width][height];
  for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      float lyapunov = Lyapunov(base,2.0+((float)x/width)*2,2.0+((float)y/height)*2);
      if(lyapunov>max) max = lyapunov;
      result[x][y]=lyapunov;
    }
  }
  for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      stroke(128+(result[x][y]/max)*128,0,0);
      point(x,y);
    }
  }
}
