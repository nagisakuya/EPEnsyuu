class Polygon {
  Vector[] vertexs = new Vector[3];
  CVec col = new CVec(128, 128, 128);
  Polygon(Vector p0, Vector p1, Vector p2) {
    vertexs[0]=p0;
    vertexs[1]=p1;
    vertexs[2]=p2;
  }
  Polygon(Vector p0, Vector p1, Vector p2, CVec c) {
    vertexs[0]=p0;
    vertexs[1]=p1;
    vertexs[2]=p2;
    col = c;
  }
  Vector center() {
    return vertexs[0].add(vertexs[1]).add(vertexs[2]).divide(3);
  }
  Vector Normal() {
    return vertexs[1].diff(vertexs[0]).cross(vertexs[2].diff(vertexs[0]));
  }
  boolean IsCross(Vector A, Vector B) {
    Vector PA = A.diff(vertexs[0]);
    Vector PB = B.diff(vertexs[0]);
    return PA.inner(Normal()) * PB.inner(Normal()) <= 0 ;
  }
  float DistanceMin(Vector vect) {
    float min = vertexs[0].diff(vect).abs();
    for (int i = 1; i<vertexs.length; i++) {
      if (vertexs[i].diff(vect).abs()<min) {
        min =  vertexs[i].diff(vect).abs();
      }
    }
    return min;
  }
  void Draw() {
    engine.Triangle(vertexs[0], vertexs[1], vertexs[2]);
  }
  Polygon rotate(Vector center, Vector radian) {
    return new Polygon(vertexs[0].rotate(center, radian), vertexs[1].rotate(center, radian), vertexs[2].rotate(center, radian),col);
  }
  Polygon scale(Vector center, float scaler) {
    Vector[] temp = new Vector[3];
    for (int i=0; i<temp.length; i++) {
      temp[i] = vertexs[i].extention(center, scaler);
    }
    return new Polygon(temp[0], temp[1], temp[2],col);
  }
  float angle(Vector vec) {
    float temp = Normal().angle(vec);
    if (temp < PI/2) return PI/2 - temp;
    else return temp - PI/2;
  }
  boolean isFlont(Polygon p, Camera cam) {
    float[] temp1 = new float[3];
    float[] temp2 = new float[3];
    for (int i = 0; i<vertexs.length; i++) {
      temp1[i] = this.vertexs[i].diff(cam).orthoSimilarity(cam.angle);
      temp2[i] = p.vertexs[i].diff(cam).orthoSimilarity(cam.angle);
    }
    temp1 = sort(temp1);
    temp2 = sort(temp2);
    float boarder = 1e-1;
    if (abs(temp1[0]-temp2[0])>boarder) {
      return temp1[0]<temp2[0];
    } else  if (abs(temp1[1]-temp2[1])>boarder) {
      return temp1[1]<temp2[1];
    } else {
      return temp1[2]<temp2[2];
    }
  }
  Polygon move(Vector vec) {
    return new Polygon(vertexs[0].add(vec), vertexs[1].add(vec), vertexs[2].add(vec),col);
  }
}

class Polygons {
  ArrayList<Polygon> polygons= new ArrayList<Polygon>();
  Polygons(Vector[] vert) {
    for (int i = 0; i<vert.length-2; i++) {
      polygons.add(new Polygon(vert[0], vert[i+1], vert[i+2]));
    }
  }
  Polygons(ArrayList<Polygon> p) {
    polygons = p;
  }
  Polygons() {
  }
  void rotate(Vector center, Vector radian) {
    for (int i=0; i<polygons.size(); i++) {
      polygons.set(i, polygons.get(i).rotate(center, radian));
    }
  }
  void rotate(Vector radian) {
    for (int i=0; i<polygons.size(); i++) {
      polygons.set(i, polygons.get(i).rotate(new Vector(0, 0, 0), radian));
    }
  }
  void scale(Vector center, float scaler) {
    for (int i=0; i<polygons.size(); i++) {
      polygons.set(i, polygons.get(i).scale(center, scaler));
    }
  }
  void move(Vector vec) {
    for (int i=0; i<polygons.size(); i++) {
      polygons.set(i, polygons.get(i).move(vec));
    }
  }
  void add(Polygon p) {
    polygons.add(p);
  }
  void add(ArrayList<Polygon> p) {
    polygons.addAll(p);
  }
  void add(Polygons p) {
    polygons.addAll(p.polygons);
  }
  void SortByDist(Camera cam) {
    for (int counter = 0; counter<polygons.size(); counter++) {
      int ite = 0;
      for (int i = counter; i<polygons.size(); i++) {
        if (polygons.get(i).isFlont(polygons.get(ite),cam)) {
          ite = i;
        }
      }
      Polygon temp = polygons.get(counter);
      polygons.set(counter, polygons.get(ite));
      polygons.set(ite, temp);
    }
  }
}

final Polygons cube() {
  Vector[] vertexs = {
    new Vector(0, 0, 0), 
    new Vector(1, 0, 0), 
    new Vector(1, 1, 0), 
    new Vector(0, 1, 0)
  };
  Polygons surface = new Polygons(vertexs);
  surface.move(new Vector(-0.5, -0.5, 0.5));
  Polygons cube = new Polygons();
  cube.add(surface);
  surface.rotate(new Vector(PI/2, 0, 0));
  cube.add(surface);
  surface.rotate(new Vector(PI/2, 0, 0));
  cube.add(surface);
  surface.rotate(new Vector(PI/2, 0, 0));
  cube.add(surface);
  surface.rotate(new Vector(PI/2, PI/2, 0));
  cube.add(surface);
  surface.rotate(new Vector(0, PI, 0));
  cube.add(surface);
  return cube;
}
