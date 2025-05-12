import g4p_controls.*;



 int CELL = 40;         // pixels per cell
 int COLS = 15;
 int ROWS = 10;
boolean[][] occupied;        // cell occupancy grid
ArrayList<Furniture> furnitureList;
Furniture selected;

void settings() {
  size(COLS * CELL + 2, ROWS * CELL + 2);
}

void setup() {
  createGUI();
  occupied = new boolean[COLS][ROWS];
  furnitureList = new ArrayList<Furniture>();
  selected = null;
  textSize(12);
}

void draw() {
  background(240);
  drawGrid();
  drawRoomOutline();
  for (Furniture f : furnitureList) {
    f.display();
  }
}

void drawGrid() {
  stroke(200);
  for (int i = 0; i <= COLS; i++) line(i*CELL+1, 1, i*CELL+1, ROWS*CELL+1);
  for (int j = 0; j <= ROWS; j++) line(1, j*CELL+1, COLS*CELL+1, j*CELL+1);
}

void drawRoomOutline() {
  stroke(0);
  noFill();
  rect(1, 1, COLS*CELL, ROWS*CELL);
}

void mousePressed() {
  selected = null;
  for (Furniture f : furnitureList) {
    if (f.contains(mouseX, mouseY)) {
      selected = f;
      f.pickOffset(mouseX, mouseY);
      break;
    }
  }
}

void mouseDragged() {
  if (selected != null) {
    // Calculate top-left corner based on mouse and stored offset
    int x0 = mouseX - selected.offX;
    int y0 = mouseY - selected.offY;
    int c = floor((x0 - 1) / CELL + 0.5);
    int r = floor((y0 - 1) / CELL + 0.5);
    selected.tryMove(c, r);
  }
}



void addFurniture(Furniture f, int mx, int my) {
  // center furniture under mouse
  int c = floor((mx - 1 - f.w*CELL/2) / CELL + 0.5);
  int r = floor((my - 1 - f.h*CELL/2) / CELL + 0.5);
  c = constrain(c, 0, COLS - f.w);
  r = constrain(r, 0, ROWS - f.h);
  if (f.place(c, r)) furnitureList.add(f);
}

void removeFurniture(Furniture f) {
  f.clearOccupancy();
  furnitureList.remove(f);
  selected = null;
}
