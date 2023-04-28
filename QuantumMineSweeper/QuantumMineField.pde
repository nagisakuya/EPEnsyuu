class QuantumGridState extends GridState { //<>//
  boolean observed = true;
  QuantumGridState(boolean mine) {
    super(mine);
  }
}

class Window {
  PVector position;
  PVector size;
  Window(PVector pos, PVector s) {
    position = pos;
    size = s;
  }
  boolean IsInside(PVector vec) {
    PVector temp = vec.copy().add(displayPos);
    return position.x <= temp.x && position.x+size.x >= temp.x &&
      position.y <= temp.y && position.y+size.y >= temp.y;
  }
  boolean IsInside(PVector pos, PVector s) {
    return IsInside(pos)||IsInside(pos.copy().add(s))  //<>//
      ||IsInside(pos.copy().add(new PVector(s.x, 0)))||IsInside(pos.copy().add(new PVector(0, s.y)));
  }
}

class QuantumMineField extends MineField {
  QuantumMineField(int x, int y, int b) {
    super(x, y, b);
  }
  void GenerateField() {
    field = new ArrayList<GridState>(); 
    for (int i=0; i<mineCount; i++) {
      field.add(new QuantumGridState(true));
    }
    for (int i=mineCount; i<sizeX*sizeY; i++) {
      field.add(new QuantumGridState(false));
    }
  }
  QuantumGridState GetState(int x, int y) {
    if (!Inside(x, y)) {
      return null;
    }
    return (QuantumGridState)field.get(y*sizeX+x);
  }
  QuantumGridState GetState(int i) {
    return (QuantumGridState)field.get(i);
  }
  boolean IsObserved(int x, int y) {
      for (int i=0; i<9; i++) {
        if (Inside(x-1+i/3, y-1+i%3) &&
        GetState(x-1+i/3, y-1+i%3).opened && display.IsInside(GetPos(x-1+i/3, y-1+i%3), gridSize)) 
          return true;
      }
      return false;
  }
  void UpdateObserved() {
    for (int x=0; x<sizeX; x++) {
      for (int y=0; y<sizeY; y++) {
        GetState(x, y).observed = IsObserved(x, y);
      }
    }
  }
  void MoveQuantumMine() {
    UpdateObserved();
    int unObservedCounter = 0;
    int unObservedMineCounter = 0;
    for (int i = 0; i<sizeX*sizeY; i++) {
      if (!GetState(i).observed && !GetState(i).opened) {
        unObservedCounter++;
        if (GetState(i).mine) {
          unObservedMineCounter++;
        }
      }
    }
    ArrayList<Boolean> temp = new ArrayList<Boolean>();
    for (int i=0; i<unObservedMineCounter; i++) {
      temp.add(true);
    }
    for (int i=unObservedMineCounter; i<unObservedCounter; i++) {
      temp.add(false);
    }
    Collections.shuffle(temp);
    for (int i = 0,c = 0; c<unObservedCounter;i++ ) {
      if (!GetState(i).observed && !GetState(i).opened) {
        GetState(i).mine = temp.get(c);
        c++;
      }
    }
  }
  void Draw() {
    MoveQuantumMine();
    super.Draw();
  }
}
