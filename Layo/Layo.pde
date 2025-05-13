import g4p_controls.*;
import java.awt.Font;
boolean draw_g = true;
float roomX = 600;
float roomY = 600;
Furniture selected = null;
float offsetX, offsetY;
ArrayList<Furniture> furnitureList = new ArrayList<Furniture>();
Room room = new Room(roomX, roomY);
Grid grid = new Grid(50,true);
boolean[][] occupied; 

void setup(){
  createGUI();
  size(800, 800);
  background(255);
  occupied = new boolean [800/50][800/50];
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
  selected = null;
}
