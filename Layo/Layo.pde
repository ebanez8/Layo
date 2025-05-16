import g4p_controls.*;
import java.awt.Font;
boolean draw_g = true;
float roomX = 600;
float roomY = 600;
float rotation = 0;
Furniture selected = null;
float offsetX, offsetY;
ArrayList<Furniture> furnitureList = new ArrayList<Furniture>();
Room room = new Room(roomX, roomY);
Grid grid = new Grid(25,true);
boolean[][] occupied; 
int cols, rows;
int tileSize = 25;
int gridX, gridY;

void setup(){
  createGUI();
  size(800, 800);
  background(255);
  cols = width / tileSize;
  rows = height / tileSize;
  occupied = new boolean [cols][rows];
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

void keyPressed() {
  if (key == 'r') {
    for (Furniture f : furnitureList) {
      if (selected == f) {
        float nWidth = f.widths;
        f.widths = -f.heights;
        f.heights = nWidth;
      }
    }
  }
}

void mousePressed() {
  int gridX = mouseX / tileSize;
  int gridY = mouseY / tileSize;
  
  if (gridX >= 0 && gridX < cols && gridY >= 0 && gridY < rows) {
    println("Mouse clicked on grid tile: [" + gridX + ", " + gridY + "]");
  }
  
  // Snapping furniture (its top left corner at the mouse x, y)
  float snappedX = gridX * tileSize;
  float snappedY = gridY * tileSize;

  if (isFurnitureSelected) {
    selectedFurniture.x = snappedX;
    selectedFurniture.y = snappedY;
    furnitureList.add(selectedFurniture);  
    isFurnitureSelected = false;  
  }

  for (Furniture f : furnitureList) {
    if (f.isClicked(mouseX, mouseY)) {
      selected = f;
      offsetX = mouseX - f.x;
      offsetY = mouseY - f.y;
      break;
    }
  }
}

void mouseDragged() {
  if (selected != null) {
    selected.moveTo(mouseX - offsetX, mouseY - offsetY);
  }
}

void mouseReleased() {
  if (selected != null) {
    int gridX = (int)(selected.x / tileSize);
    int gridY = (int)(selected.y / tileSize);
    
    // keeps furniture inside the room
    // STILL NEED TO FIX THIS TO FIT CONSTRAINS OF THEROOM
    //gridX = constrain(gridX, 0, cols - 1);
    //gridY = constrain(gridY, 0, rows - 1);
    selected.x = gridX * tileSize;
    selected.y = gridY * tileSize;
  }

  selected = null;
}
