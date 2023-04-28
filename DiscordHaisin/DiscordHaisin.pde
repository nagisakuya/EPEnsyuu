ArrayList<Vec2> history = new ArrayList<Vec2>();

void setup(){
  size(1000,1000);
}

void draw(){
  background(0);
  history.add(new Vec2(mouseX,mouseY));
  for(int i=0;i<history.size();i++){
    if((history.size() - i)%5==1)
    circle(history.get(i).mult(pow(0.95,history.size()-i)),100*pow(0.95,history.size()-i));
  }
}
