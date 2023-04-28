//調べたのを活かすところまでいけんかった

threeD engine = new threeD();

void setup() {
  size(800, 800);
  int step = 32;
    for (int r=0; r<256; r+= step) {
        for (int g=0; g<256; g+= step) {
            for (int b=0; b<256; b+= step) {
               particles.add(new particle(new Vector(400,400,0),new Vector((float)(128-r)/30,(float)(128-g)/30,(float)(128-b)/30),new CVec(r,g,b)));
            }
        }
    }
}

void draw() {
  for (particle p : particles) {
    p.draw();
  }
  engine.draw();
}

class particle {
  Vector pos;
  Vector speed;
  CVec col;
  particle(Vector p,Vector s, CVec c) {
    pos = p;
    speed = s;
    col = c;
  }
  void draw() {
    float shita = (noise(pos.x,pos.y,pos.z)-0.5) * PI * 6;
    float gamma = (noise(frameCount*0.01)-0.5) * PI * 6;
    pos = pos.add(speed).add(new Vector(sin(shita)*cos(gamma),sin(shita)*sin(gamma),cos(shita)).multi(5));;
    Polygon p = new Polygon(pos,pos.add(new Vector(0,1,0)),pos.add(new Vector(0.85,0.5,0)),col);

    engine.add(p.rotate(p.center(),new Vector(noise(pos.x),noise(pos.y),noise(pos.z))));
  }
}

ArrayList<particle> particles = new ArrayList<particle>();
