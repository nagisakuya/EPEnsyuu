import java.util.Collections;

class GridState {
  boolean mine;
  boolean flag = false;
  boolean opened = false;
  GridState(boolean mine) {
    this.mine = mine;
  }
  boolean Open() {
    if (opened) return false;
    opened = true;
    return true;
  }
  boolean FlipFlag() {
    if (opened) return false;
    flag = !flag;
    return true;
  }
}

enum GameState {
  going, 
    lose, 
    win
}

class MineField {
  int sizeX, sizeY;
  PVector gridSize = new PVector(30, 30);
  PVector position = new PVector(0, 0);
  ArrayList<GridState> field;
  GameState gameState = GameState.going;
  int mineCount;
  MineField(int x, int y, int b) {
    sizeX =x;
    sizeY =y;
    mineCount = b;
    GenerateField();
  };
  void GenerateField() {
    field = new ArrayList<GridState>(); 
    for (int i=0; i<mineCount; i++) {
      field.add(new GridState(true));
    }
    for (int i=mineCount; i<sizeX*sizeY; i++) {
      field.add(new GridState(false));
    }
  }
  void Shuffle(int x, int y) {
    if (mineCount == sizeX * sizeY) {
      return;
    }
    while (true) {
      Collections.shuffle(field);
      if (!GetState(x, y).mine) {
        break;
      }
    }
  }
  boolean Inside(int x, int y) {
    return !(x<0||x>=sizeX||y<0||y>=sizeY);
  }
  GridState GetState(int x, int y) {
    if (!Inside(x, y)) {
      return null;
    }
    return field.get(y*sizeX+x);
  }
  PVector GetPos(int x, int y) {
    return (new PVector(x*gridSize.x, y*gridSize.y)).add(position);
  }
  PVector GetCenterPos(int x, int y) {
    return GetPos(x, y).add(new PVector(gridSize.x/2, gridSize.y/2));
  }
  int AroundMineCount(int x, int y) {
    int counter = 0;
    for (int i=0; i<9; i++) {
      if (Inside(x-1+i/3, y-1+i%3) && GetState(x-1+i/3, y-1+i%3).mine) {
        counter++;
      }
    }
    return counter;
  }
  int AroundFlagCount(int x, int y) {
    int counter = 0;
    for (int i=0; i<9; i++) {
      if (Inside(x-1+i/3, y-1+i%3) && GetState(x-1+i/3, y-1+i%3).flag) {
        counter++;
      }
    }
    return counter;
  }
  int FlagCount() {
    int counter = 0;
    for (GridState o : field) {
      if (o.flag) {
        counter++;
      }
    }
    return counter;
  }
  int UnflagedMineCount() {
    return mineCount - FlagCount();
  }
  int OpenedCount() {
    int counter = 0;
    for (GridState o : field) {
      if (o.opened) {
        counter++;
      }
    }
    return counter;
  }
  boolean IsCleared() {
    for (GridState o : field) {
      if (!o.opened && !o.mine) {
        return false;
      }
    }
    return true;
  }
  void Open(int x, int y) {
    if (!Inside(x, y) || GetState(x, y).flag) {
      return;
    }
    if (OpenedCount() == 0) {
      Shuffle(x, y);
    }
    if ((GetState(x, y).opened && (AroundMineCount(x, y)-AroundFlagCount(x, y)<=0)) ||
      (GetState(x, y).Open() && AroundMineCount(x, y) == 0)) {
      OpenAround(x, y);
    }
    if (GetState(x, y).mine) {
      gameState = GameState.lose;
    }
    if (IsCleared()) {
      gameState = GameState.win;
    }
  }
  void OpenAround(int x, int y) {
    for (int i=0; i<9; i++) {
      if (Inside(x-1+i/3, y-1+i%3) && !GetState(x-1+i/3, y-1+i%3).opened)
        Open(x-1+i/3, y-1+i%3);
    }
  }
  void FlipFlag(int x, int y) {
    if (!Inside(x, y)) {
      return;
    }
    GetState(x, y).FlipFlag();
  }
  void Draw() {
    push();
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    textSize(gridSize.y/1.5);
    for (int x=0; x<sizeX; x++) {
      for (int y=0; y<sizeY; y++) {
        PVector pos = GetCenterPos(x, y);
        if (GetState(x, y).opened) {
          if (GetState(x, y).mine) {
            fill(255, 0, 0);
            rect(pos.x, pos.y, gridSize.x, gridSize.y);
          } else {
            fill(255);
            rect(pos.x, pos.y, gridSize.x, gridSize.y);
            int temp = AroundMineCount(x, y);
            if (temp !=0) {
              fill(0);
              text(temp, pos.x, pos.y);
            }
          }
        } else {
          if (GetState(x, y).flag) {
            fill(0, 0, 255);
          } else if (GetState(x, y).mine) {
            fill(100);
          } else {
            fill(100);
          }
          rect(pos.x, pos.y, gridSize.x, gridSize.y);
        }
      }
    }
    pop();
  }
  void ClickedEvent() {
    if (gameState == GameState.going) {
      int x = int((mouseX-position.x)/gridSize.x);
      int y = int((mouseY-position.y)/gridSize.y);
      if (mouseButton == LEFT) {
        Open(x, y);
      }
      if (mouseButton == RIGHT) {
        FlipFlag(x, y);
      }
    }
  }
}
