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
    stroke(co);
    point(pos.x, pos.y);
    pos.add(speed);
    decelerate();
  }
}

List<Particle> particles = new ArrayList<Particle>();
final int ParticlesSize = 50;
final int ParticlesCount = ParticlesSize * ParticlesSize;


void setup() {
  for (int i = 0; i<ParticlesCount; i++) {
    particles.add(new Particle(i/ParticlesSize * 4, i%ParticlesSize *4, BLACK));
  }
  size(400, 400);
}

void draw() {
  background(WHITE);
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
