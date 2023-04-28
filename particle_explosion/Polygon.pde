class Polygon {
  Vector[] vertexs = new Vector[3];
  CVec col = new CVec(128,128,128);
  Polygon(Vector p0, Vector p1, Vector p2) {
    vertexs[0]=p0;
    vertexs[1]=p1;
    vertexs[2]=p2;
  }
  Polygon(Vector p0, Vector p1, Vector p2 , CVec c) {
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
  boolean IsCross(Vector A,Vector B) {
    Vector PA = A.diff(vertexs[0]);
    Vector PB = B.diff(vertexs[0]);
    return PA.inner(Normal()) * PB.inner(Normal()) <= 0 ;
  }
  float Distance(Vector vect) {
    return center().diff(vect).abs();
  }
  Polygon rotate(Vector center, Vector radian) {
    return new Polygon(vertexs[0].rotate(center, radian), vertexs[1].rotate(center, radian), vertexs[2].rotate(center, radian),col);
  }
  Polygon scale(Vector center, float scaler) {
    Vector[] temp = new Vector[3];
    for (int i=0; i<temp.length; i++) {
      temp[i] = vertexs[i].extention(center, scaler);
    }
    return new Polygon(temp[0], temp[1], temp[2]);
  }
  float angle(Vector vec) {
    float temp = Normal().angle(vec);
    if (temp < PI/2) return PI/2 - temp;
    else return temp - PI/2;
  }
  Polygon move(Vector vec) {
    return new Polygon(vertexs[0].add(vec), vertexs[1].add(vec), vertexs[2].add(vec));
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
  void SortByDist(Vector vec) {
    for (int counter = 0; counter<polygons.size(); counter++) {
      float max = Float.MIN_VALUE;
      int ite = 0;
      for (int i = counter; i<polygons.size(); i++) {
        if (polygons.get(i).Distance(vec)>max) {
          max = polygons.get(i).Distance(vec);
          ite = i;
        }
      }
      Polygon temp = polygons.get(counter);
      polygons.set(counter, polygons.get(ite));
      polygons.set(ite, temp);
    }
  }
}
