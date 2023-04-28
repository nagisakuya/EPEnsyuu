class Camera extends Vector {
  Vector angle;
  Vector xAxis, yAxis;
  Camera() {
    super(400, 400, 400);
    angle = new Vector(0, 0, -400);
    xAxis = new Vector(1, 0, 0);
    yAxis = new Vector(0, 1, 0);
  }
  Camera(Vector vec, Vector agl) {
    super(vec);
    angle = agl;
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
  Vector calc_pos(Vector vec) {
    Vector temp = vec.diff(camera);
    temp = temp.multi(camera.angle.abs()/temp.orthography(camera.angle).abs()).diff(camera.angle);
    return new Vector(temp.orthoSimilarity(camera.xAxis), temp.orthoSimilarity(camera.yAxis), 0);
  }
  void Triangle(Vector p0, Vector p1, Vector p2 ) {
    Vector temp = new Vector(width/2, height/2, 0);
    p0 = calc_pos(p0).add(temp);
    p1 = calc_pos(p1).add(temp);
    p2 = calc_pos(p2).add(temp);
    triangle(p0.x,p0.y,p1.x,p1.y,p2.x,p2.y);
   /*float[] Xs ={
      p0.x, 
      p1.x, 
      p2.x, 
    };
    float[] Ys ={
      p0.y, 
      p1.y, 
      p2.y, 
    };
    Xs = sort(Xs);
    Ys = sort(Ys);
    int Xmin = (int)Xs[0];
    int Xmax = (int)Xs[2];
    int Ymin = (int)Ys[0];
    int Ymax = (int)Ys[2];
    if (Xmin<0) Xmin = 0;
    if (Xmax>width) Xmax = width;
    if (Ymin<0) Ymin = 0;
    if (Ymax>height) Ymax = height;
    Vector inner = new Polygon(p0,p1,p2).center();
    for (int x = Xmin; x<=Xmax; x++) {
      for (int y = Ymin; y<=Ymax; y++) {
        if(){
          point(x,y);
        }
      }
    }*/
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
    //draw_queue.SortByDist(camera);
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
        Triangle(o.vertexs[0], o.vertexs[1], o.vertexs[2]); //<>//
      }
    }
  }
  void draw() {
    background(255);
    show();
    flush();
  }
}
