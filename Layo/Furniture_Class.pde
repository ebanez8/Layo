class Furniture {
  int w, h;   // size in cells
  int col, row;
  String name;
  int offX, offY; // offset from top-left to mouse

  Furniture(int w, int h, String name) {
    this.w = w; this.h = h; this.name = name;
  }

  // try placing at cell c,r
  boolean place(int c, int r) {
    if (!canOccupy(c, r)) return false;
    occupy(c, r);
    return true;
  }

  void clearOccupancy() {
    for (int i = col; i < col + w; i++)
      for (int j = row; j < row + h; j++)
        occupied[i][j] = false;
  }

  boolean canOccupy(int c, int r) {
    if (c < 0 || r < 0 || c + w > COLS || r + h > ROWS) return false;
    for (int i = c; i < c + w; i++)
      for (int j = r; j < r + h; j++)
        if (occupied[i][j] && !(i >= col && j >= row && i < col+w && j < row+h)) return false;
    return true;
  }

  void occupy(int c, int r) {
    clearOccupancy();
    for (int i = c; i < c + w; i++)
      for (int j = r; j < r + h; j++)
        occupied[i][j] = true;
    col = c; row = r;
  }

  void tryMove(int c, int r) {
    if (place(c, r)) return;
    // if fails, revert occupancy (place internally preserves old on fail)
  }

  void rotate() {
    clearOccupancy();
    int tmp = w; w = h; h = tmp;
    // try re-place at same origin or adjust
    if (!place(col, row)) {
      place(constrain(col, 0, COLS-w), constrain(row, 0, ROWS-h));
    }
  }

  void pickOffset(int mx, int my) {
    int x1 = col*CELL + 1;
    int y1 = row*CELL + 1;
    offX = mx - (x1 + (w*CELL)/2);
    offY = my - (y1 + (h*CELL)/2);
  }

  boolean contains(int mx, int my) {
    int x1 = col*CELL + 1;
    int y1 = row*CELL + 1;
    return mx >= x1 && my >= y1 && mx < x1 + w*CELL && my < y1 + h*CELL;
  }

  void display() {
    int x = col*CELL + 1;
    int y = row*CELL + 1;
    fill(180,200,240);
    noStroke(); rect(x, y, w*CELL, h*CELL);
    stroke(50); noFill(); rect(x, y, w*CELL, h*CELL);
    fill(0); textAlign(CENTER, CENTER);
    text(name, x + w*CELL/2, y + h*CELL/2);
  }
}
