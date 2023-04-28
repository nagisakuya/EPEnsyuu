class Vector {
  float x;
  float y;
  float z;
  Vector(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
  Vector() {
    this.x=0;
    this.y=0;
    this.z=0;
  }
  Vector(Vector vec) {
    this.x = vec.x;
    this.y = vec.y;
    this.z = vec.z;
  }
  Vector add(Vector vec) {
    return new Vector(x+vec.x, y+vec.y, z+vec.z);
  }
  Vector diff(Vector vec) {
    return new Vector(x-vec.x, y-vec.y, z-vec.z);
  }
  Vector divide(float i) {
    return new Vector(x/i, y/i, z/i);
  }
  Vector multi(float i) {
    return new Vector(x*i, y*i, z*i);
  }
  float abs() {
    return sqrt(x*x+y*y+z*z);
  }
  float inner(Vector vec) {
    return x*vec.x+y*vec.y+z*vec.z;
  }
  Vector cross(Vector vec) {
    return new Vector(y*vec.z-z*vec.y,z*vec.x-x*vec.z,x*vec.y-y*vec.x);
  }
  float angle(Vector vec) {
    return acos(inner(vec)/(abs()*vec.abs()));
  }
  Vector rotate(Vector center, Vector radian) {
    Vector temp = this.diff(center);
    temp = new Vector(temp.x, temp.y*cos(radian.x)+temp.z*sin(radian.x), -temp.y*sin(radian.x)+temp.z*cos(radian.x));
    temp = new Vector(temp.x*cos(radian.y)-temp.z*sin(radian.y), temp.y, temp.x*sin(radian.y)+temp.z*cos(radian.y));
    temp = new Vector(temp.x*cos(radian.z)-temp.y*sin(radian.z), temp.x*sin(radian.z)+temp.y*cos(radian.z), temp.z);
    return temp.add( center);
  }
  Vector rotate(Vector radian) {
    return rotate(new Vector(),radian);
  }
  Vector extention(Vector center,float scaler) {
    Vector temp = this.diff(center);
    temp = temp.multi(scaler);
    return temp.add(center);
  }
}

Vector VecSum(Vector[] vecs) {
  Vector temp = new Vector(0, 0, 0);
  for (Vector v : vecs) {
    temp = temp.add(v);
  }
  return temp;
}
