class Tile {
  boolean hasBomb = false;
  boolean uncover = false;
  boolean flag = false;
  color col = color(#E8E1E1);
  int x, y, posX, posY, size;
  int value;
  Tile(int _x, int _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
    value = 0;
    posX = x*size;
    posY = y*size;
  }

  void display() {
    if(uncover) {
      col = color(#E8E1E1);
    } else {
      col = color(#767373);
    }
    if(flag) {
      col = color(255, 0, 0);
    }
    if(hasBomb && uncover) {
      col = color(#716ECE);
    }
    fill(col);
    stroke(#E8E8E8);
    rect(x*size, y*size, size, size);
    if (uncover) {
      textSize(12);
      fill(255, 0, 0);
      if(hasBomb) {
        println("YOU LOSE");
        
      } else {
        text(value, posX + size/2, posY + size/2);
      }
    }
  }

  void uncover() {
    uncover = true;
  }
}
