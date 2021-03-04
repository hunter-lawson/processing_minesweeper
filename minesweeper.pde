int difficulty = 50;
int dimensionX = 20, dimensionY = 20;
Tile[][] tiles = new Tile[dimensionY][dimensionX];
PVector select;
int flagCount = 0;
void setup() {
  size(800, 800);
  startGame();
}

void draw() {
  background(0);
  displayTiles();
}

void displayTiles() {
  for (int i=1; i<dimensionY-1; i++) {
    for (int j=1; j<dimensionX-1; j++) {
      Tile t = tiles[i][j];
      if (mouseX > t.posX && mouseX<t.posX + t.size && mouseY>t.posY && mouseY<t.posY + t.size) {
        t.col = color(#AAA5A5);
        if (mousePressed && mouseButton == LEFT) {
          t.uncover();
          if (t.value == 0) {
            clearZeroes(j, i);
          }
        }
      } else {
        t.col = color(#E8E1E1);
      }
      select = new PVector(i, j);
      t.display();
    }
  }
}

void clearZeroes(int x, int y) {
  Tile t = tiles[y][x];
  if (x > 0 && y > 0 && x < dimensionX-1 && y < dimensionY-1) {
    for (int i=t.x-1; i<=t.x+1; i++) {
      for (int j=t.y-1; j<=t.y+1; j++) {
        Tile test = tiles[i][j];
        if (test.uncover == false && test.value == 0) {
          test.uncover = true;
          clearZeroes(j, i);
        }
        test.uncover = true;
      }
    }
  }
}

void startGame() {
  for (int i=0; i<tiles.length; i++) {
    for (int j=0; j<tiles[0].length; j++) {
      tiles[i][j] = new Tile(i, j, height/dimensionX);
    }
  }
  //create bombs
  if (difficulty < dimensionX*dimensionY) {
    for (int i=0; i<difficulty; i++) {
      int randX, randY;
      do {
        randX = int(random(dimensionX-2));
        randY = int(random(dimensionY-2));
      } while (tiles[randY+1][randX+1].hasBomb == true);
      tiles[randY+1][randX+1].hasBomb = true;
    }
  }
  //create bomb values
  for (int i=1; i<dimensionY-1; i++) {
    for (int j=1; j<dimensionX-1; j++) {
      Tile t = tiles[i][j];
      int bombCount = 0;
      for (int x=t.x-1; x<=t.x+1; x++) {
        for (int y=t.y-1; y<=t.y+1; y++) {
          if (tiles[x][y].hasBomb == true) {
            bombCount++;
          }
        }
      }
      t.value = bombCount;
    }
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    for (int i=1; i<dimensionY-1; i++) {
      for (int j=1; j<dimensionX-1; j++) {
        Tile t = tiles[i][j];
        if (mouseX > t.posX && mouseX<t.posX + t.size && mouseY>t.posY && mouseY<t.posY + t.size) {
          if (t.flag == false) {
            flagCount++;
            t.flag = true;
          } else {
            flagCount --;
            t.flag = false;
          }
        }
      }
    }
    println(flagCount + " / " + difficulty);
  }
}

void keyPressed() {
  if(key == ' ') {
    startGame();
  }
}
