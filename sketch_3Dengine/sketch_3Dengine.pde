threeD engine = new threeD();

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {
  test_drawSquares();
}
void test_drawTetrahedron() {
  engine.addLight(new Light(new Vector(400, 400, 400), new CVec(255, 255, 255), 0));
  Vector[] vertex = {
    new Vector(1, 1, 1), 
    new Vector(-1, -1, 1), 
    new Vector(1, -1, -1), 
    new Vector(-1, 1, -1), 
  };
  Polygons Tetrahedron = new Polygons();
  Tetrahedron.add(new Polygon(vertex[0], vertex[1], vertex[2],new CVec(255,0,0)));
  Tetrahedron.add(new Polygon(vertex[3], vertex[1], vertex[2],new CVec(255,255,0)));
  Tetrahedron.add(new Polygon(vertex[0], vertex[3], vertex[2],new CVec(255,0,255)));
  Tetrahedron.add(new Polygon(vertex[0], vertex[1], vertex[3],new CVec(0,255,0)));
  Tetrahedron.scale(new Vector(0, 0, 0), 100);
  Tetrahedron.move(new Vector(mouseX, 400, 0));
  Tetrahedron.rotate(new Vector(400, 400, 0), new Vector(PI*(mouseY-400)/400, 0, 0));
  engine.add(Tetrahedron);
  engine.draw();
}

void test_drawSquares() {
  engine.LightingFlag = true;
  engine.addLight(new Light(new Vector(400, 200, 500), new Vector(255, 0, 0), 1e-4));
  engine.addLight(new Light(new Vector(200, 600, 500), new Vector(0, 255, 0), 1e-4));
  engine.addLight(new Light(new Vector(600, 600, 500), new Vector(0, 0, 255), 1e-4));
  int size_x = 50;
  int size_y = 50;
  for (int x=0; x<width/size_x; x++) {
    for (int y=0; y<height/size_y; y++) {
      Vector[] vertexs = {
        new Vector(x*size_x, y*size_y, 0), 
        new Vector((x+1)*size_x, y*size_y, 0), 
        new Vector((x+1)*size_x, (y+1)*size_y, 0), 
        new Vector(x*size_x, (y+1)*size_y, 0)
      };
      Polygons temp = new Polygons(vertexs);
      temp.rotate(new Vector((x+0.5)*size_x, (y+0.5)*size_y, 0), new Vector(PI*-(mouseY-400)/400,  PI*(mouseX-400)/400,0));
      //temp = temp.rotate(temp.center(), new Vector((noise(x,frameCount*0.01)-0.5)*PI, (noise(y,frameCount*0.01)-0.5)*PI,(noise(x,y,frameCount*0.01)-0.5)*PI));
      engine.add(temp);
      /*draw_queue.add(
       new RectObj(new Vector(x, y, -(400-mouseX)), 
       new Vector(x+size_x, y, -(400-mouseY)), 
       new Vector(x+size_x, y+size_y, 400-mouseX), 
       new Vector(x, y+size_y, 400-mouseY)));*/
    }
  }
  engine.draw();
}

void test_drawCube() {
  engine.LightingFlag = true;
  engine.addLight(new Light(new Vector(400, 200, 500), new Vector(255, 0, 0), 1e-4));
  engine.addLight(new Light(new Vector(200, 600, 500), new Vector(0, 255, 0), 1e-4));
  engine.addLight(new Light(new Vector(600, 600, 500), new Vector(0, 0, 255), 1e-4));
  Polygons cube = cube();
  cube.scale(new Vector(0, 0, 0), 100);
  cube.move(new Vector(mouseX, 400, 0));
  cube.rotate(new Vector(400, 400, 0), new Vector(PI*(mouseY-400)/400, 0, 0));
  engine.add(cube);
  engine.draw();
}
