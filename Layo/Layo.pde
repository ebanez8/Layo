// TODO
LayoutManager layoutManager;
import g4p_controls.*;
import java.awt.Font;
boolean delete_bool = false;
boolean draw_g = true;
float roomX = 600;
float roomY = 600;
float roomArea;
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
boolean isFurnitureSelected = false;  
Furniture selectedFurniture = null;  // To store the selected furniture

void setup(){
  room = new Room(roomX, roomY);
  createGUI();
  layoutManager = new LayoutManager(room, tileSize);
  size(800, 800);
  background(255);
  cols = width / tileSize;
  rows = height / tileSize;
  occupied = new boolean [cols][rows];
}

void draw() {
  background(255);
  room.drawRoom();
  if (draw_g){grid.drawGrid();}
  
  for (Furniture f : furnitureList) {
    fill(f.col);
    f.drawFurniture();
  }
  for (Furniture f : furnitureList) {
    //check for collisions
    boolean hasCollision = false;
    for (Furniture other : furnitureList) {
      if (f != other && layoutManager.hasCollision(f, other)) {
        hasCollision = true;
        break;
      }
    }
    
    //set color based on collision
    if (hasCollision && f != selected) {
      fill(255, 0, 0, 200); 
    } else {
      fill(f.col);
    }
    f.drawFurniture();
  }
}

void keyPressed() {
  if (key == 'r' && selected != null) {
    selected.rotate();
  }
}

void mousePressed() {
  int gridX = mouseX / tileSize;
  int gridY = mouseY / tileSize;
  
  float snappedX = gridX * tileSize;
  float snappedY = gridY * tileSize;

  if (isFurnitureSelected) {
    float fw = selectedFurniture.widths;
    float fh = selectedFurniture.heights;
    
    if (isInsideRoom(snappedX, snappedY, fw, fh)) {
      selectedFurniture.x = snappedX;
      selectedFurniture.y = snappedY;
      furnitureList.add(selectedFurniture);  
      isFurnitureSelected = false;  
      
      float emptySpace = calculateEmptySpace();
      float emptyPercentage = (emptySpace / roomArea) * 100;
      
      if (emptyPercentage < 30) {  
        println("Too little empty space left in the room! Only " + nf(emptyPercentage, 0, 1) + "% remains.");
      }
      
      
    } else {
      println("Placement outside room — click another location in the room.");
    }
  }

  for (Furniture f : furnitureList) {
    if (f.isClicked(mouseX, mouseY)) {
      if (delete_bool == true){
        print("deleted");
        furnitureList.remove(f);
        delete_bool = false;
        break;
      }
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
    // Store original position before snapping
    float originalX = selected.x;
    float originalY = selected.y;
    
    int gridX = (int)(selected.x / tileSize);
    int gridY = (int)(selected.y / tileSize);
    
    // keeps furniture inside the room
    gridX = constrain(gridX, 0, cols - 1);
    gridY = constrain(gridY, 0, rows - 1);
    
    selected.x = gridX * tileSize;
    selected.y = gridY * tileSize;
    
    // Check for collisions after snapping to grid
    boolean hasCollision = false;
    for (Furniture f : furnitureList) {
      if (f != selected && layoutManager.hasCollision(selected, f)) {
        hasCollision = true;
        break;
      }
    }
    
    // If collision detected after release, move back to original position
    if (hasCollision) {
      selected.x = originalX;
      selected.y = originalY;
      println("Cannot place furniture: collision detected");
    }
  }
  
  selected = null;
}
// made a helper function to check if furniture is in room
boolean isInsideRoom(float x, float y, float w, float h) {
  float roomLeft = (width - room.rwidth) / 2;
  float roomTop = (height - room.rheight) / 2;
  float roomRight = roomLeft + room.rwidth;
  float roomBottom = roomTop + room.rheight;

  return x >= roomLeft && y >= roomTop && (x + w) <= roomRight && (y + h) <= roomBottom;
}

void checkOutsideRoom() {
  for (int i = 0; i < furnitureList.size(); i--) {
    Furniture f = furnitureList.get(i);
    if (!isInsideRoom(f.x, f.y, f.widths, f.heights)) {
      furnitureList.remove(i);
    }
  }
}

float calculateEmptySpace() {
  roomArea = (room.rwidth / tileSize) * (room.rheight / tileSize);
  float furnitureArea = 0;

  for (Furniture f : furnitureList) {
    furnitureArea += (f.widths / tileSize) * (f.heights / tileSize);
  }

  return roomArea - furnitureArea;
}
