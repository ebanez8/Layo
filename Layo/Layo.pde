import g4p_controls.*;
import java.awt.Font;
boolean draw_g = true;
float roomX = 600;
float roomY = 600;
ArrayList<Furniture> furnitureList = new ArrayList<Furniture>();
Room room = new Room(roomX, roomY);
Grid grid = new Grid(50,true);

int cols, rows;
int tileSize = 50;
boolean[][] occupied;


void setup(){
  createGUI();
  size(800, 800);
  background(255);
  cols = width / tileSize;
  rows = height / tileSize;
  occupied = new boolean[cols][rows];
}


void draw() {
  background(255);
  Room room = new Room(roomX, roomY);
  room.drawRoom();
  if (draw_g){grid.drawGrid();}
  
  for (Furniture f : furnitureList) {
    fill(f.col);
    f.drawFurniture();
  }
}


void mousePressed() {
  int gridX = mouseX / tileSize;
  int gridY = mouseY / tileSize;

  if (gridX >= 0 && gridX < cols && gridY >= 0 && gridY < rows) {
    println("Mouse clicked on grid tile: [" + gridX + ", " + gridY + "]");
  }
}
