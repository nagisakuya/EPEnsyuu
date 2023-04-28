import java.util.List;
final color WHITE = color(255, 255, 255);
final color BLACK = color(0, 0, 0);
class Particle {
  PVector pos = new PVector();
  PVector speed = new PVector();
  color co;
  Particle(float x, float y, color _co) {
    pos.set(x, y);
    speed.set(0, 0);
    co = _co;
  }
  void gravity(PVector to) {
    speed.add(to.copy().sub(pos).div(to.dist(pos)*5));
  }
  void antigravity(PVector from) {
    speed.sub(from.copy().sub(pos).div(from.dist(pos)*5));
  }
  void decelerate() {
    speed.mult(0.99);
  }
  void draw() {
    float red = (sin(PI*(((float)frameCount*9/2000+((200-pos.x)*(200-pos.x)+(200-pos.y)*(200-pos.y))/40000)))+1)/2;
    float green = (sin(PI*(((float)frameCount*13/2000+(pos.x+400-pos.y)/400)))+1)/2;
    float blue = (sin(PI*((float)frameCount*7/2000+(pos.x+pos.y)/400))+1)/2;
    red = (1-red*red)*255;
    green = (1-green*green)*255;
    blue = (1-blue*blue)*255;
    noStroke();
    fill(red,green,blue);
    circle(pos.x, pos.y,3);
    pos.add(speed);
    decelerate();
  }
}

List<Particle> particles = new ArrayList<Particle>();
final int ParticlesSize = 50;
final int ParticlesCount = ParticlesSize * ParticlesSize;


void setup() {
  for (int i = 0; i<ParticlesCount; i++) {
    particles.add(new Particle(i/ParticlesSize * 8, i%ParticlesSize *8, BLACK));
  }
  size(400, 400);
}

void draw() {
  background(BLACK);
  for (int i = 0; i<ParticlesCount; i++) {
    if (mousePressed == true && mouseButton == LEFT) {
      particles.get(i).gravity(new PVector(mouseX, mouseY));
    }
    if (mousePressed == true && mouseButton == RIGHT) {
      particles.get(i).antigravity(new PVector(mouseX, mouseY));
    }
    particles.get(i).draw();
  }
}
