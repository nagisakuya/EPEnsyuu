class Camera extends Vector {
  Camera() {
    super(400, 400, 400);
  }
  Camera(Vector vec) {
    super(vec);
  }
}
class Light extends Vector {
  float attenuation;
  CVec col;
  Light(Vector vec, Vector c, float att) {
    super(vec);
    col = new CVec(c);
    attenuation = att;
    if (attenuation > 1) attenuation = 1;
    if (attenuation < 0) attenuation = 0;
  }
}
class CVec extends Vector {
  CVec(int r, int g, int b) {
    super(r, g, b);
    if (x>255) x = 255;
    if (y>255) y = 255;
    if (z>255) z = 255;
  }
  CVec(Vector vec) {
    super(vec.x, vec.y, vec.z);
    if (x>255) x = 255;
    if (y>255) y = 255;
    if (z>255) z = 255;
  }
  color get() {
    return color(x, y, z);
  }
}

class threeD {
  Polygons draw_queue = new Polygons();
  Camera camera = new Camera();
  boolean LightingFlag = false;
  ArrayList<Light> lights = new ArrayList<Light>();
  float calc_x(Vector vec) {
    return camera.x -((camera.x-vec.x)*camera.z/(camera.z-vec.z) );
  }
  float calc_y(Vector vec) {
    return camera.y -((camera.y-vec.y)*camera.z/(camera.z-vec.z) );
  }
  void rect(Vector p0, Vector p1, Vector p2, Vector p3 ) {
    quad(calc_x(p0), calc_y(p0), calc_x(p1), calc_y(p1), calc_x(p2), calc_y(p2), calc_x(p3), calc_y(p3));
  }
  void Triangle(Vector p0, Vector p1, Vector p2 ) {
    triangle(calc_x(p0), calc_y(p0), calc_x(p1), calc_y(p1), calc_x(p2), calc_y(p2));
  }
  void add(Polygon p) {
    draw_queue.add(p);
  }
  void add(Polygons p) {
    draw_queue.add(p);
  }
  void addLight(Light l) {
    lights.add(l);
  }
  void flush() {
    draw_queue = new Polygons();
    lights = new ArrayList<Light>();
  }
  void show() {
    draw_queue.SortByDist(camera);
    for (Polygon o : draw_queue.polygons) {
      if (!new Polygon(new Vector(400, 400, 380), new Vector(400, 401, 380), new Vector(401, 400, 380)).IsCross(new Vector(0, 0, 0), o.center())) {
        CVec col = new CVec(0, 0, 0);
        if (LightingFlag) {
          for (Light l : lights) {
            if (!o.IsCross(camera, l)) {
              col = new CVec(col.add(l.col.multi(
                sin(o.angle(l.diff(o.center()))) 
                / pow(1 + l.diff(o.center()).abs() * (l.attenuation), 2))));
            }
          }
          fill(col.get());
          stroke(col.get());
        } else {
          fill(o.col.get());
          stroke(o.col.get());
        }
        strokeJoin(BEVEL);
        strokeWeight(1.5);
        Triangle(o.vertexs[0], o.vertexs[1], o.vertexs[2]);
      }
    }
  }
  void draw() {
    background(0, 0.001);
    show();
    flush();
  }
}
