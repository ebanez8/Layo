// TODO
LayoutManager layoutManager;
import g4p_controls.*;
import java.awt.Font;
import java.util.Iterator;
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
PImage imgTable, imgTBed, imgChair, imgCouch, imgSBed, imgPlant, imgDrawer;
int screenshotNum = 1;

void setup(){
  room = new Room(roomX, roomY);
  createGUI();
  layoutManager = new LayoutManager(room, tileSize);
  size(800, 800);
  background(255);
  cols = width / tileSize;
  rows = height / tileSize;
  occupied = new boolean [cols][rows];
  imgTable = loadImage("Table.png");
  imgTBed = loadImage("TBed.png");
  imgChair = loadImage("Chair.png");
  imgCouch = loadImage("Couch.png");
  imgSBed = loadImage("SBed.png");
  imgPlant = loadImage("Plant.png");
  imgDrawer = loadImage("Drawer.png");
}

void draw() {
  background(255);
  room.drawRoom();
  if (draw_g){grid.drawGrid();}
  
  for (Furniture f : furnitureList) {
    f.drawFurniture();
  }
  
  for (Furniture f : furnitureList) {
    boolean hasCollision = false;
    for (Furniture other : furnitureList) {
      if (f != other && layoutManager.hasCollision(f, other)) {
        hasCollision = true;
        break;
      }
    }
  
    if (hasCollision && f != selected) {
      stroke(255, 0, 0);
      strokeWeight(3);
      noFill();
      rectMode(CORNER);
      rect(f.x, f.y, f.widths, f.heights);
    }
  }
}

void keyPressed() {
  if (key == 'r' && selected != null) {
    selected.rotateF();
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

  for (int i = furnitureList.size() - 1; i >= 0; i--) {
    Furniture f = furnitureList.get(i);
    if (f.isClicked(mouseX, mouseY)) {
      if (delete_bool == true){
        println("deleted");
        furnitureList.remove(i);
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
  Iterator<Furniture> it = furnitureList.iterator();
  while (it.hasNext()) {
    Furniture f = it.next();
    if (!isInsideRoom(f.x, f.y, f.widths, f.heights)) {
      println(f.widths);
      it.remove();  // safe way to remove during iteration
    }
  }
}

void checkOutsideRoom2() {
  int i = 0;
  while (i < furnitureList.size()) {
    Furniture f = furnitureList.get(i);
    if (!isInsideRoom(f.x, f.y, f.widths, f.heights)) {
      furnitureList.remove(i); // Don't increment i, because list shrinks
    } else {
      i++; // Only increment if we didn't remove
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

void saveLayout(String filename) {

  room.items = new ArrayList<Furniture>(furnitureList);

  room.saveToFile(filename);

}

// Load a layout

void loadLayout(String filename) {

  room.loadFromFile(filename);

  furnitureList = new ArrayList<Furniture>(room.items);

  roomX = room.rwidth;

  roomY = room.rheight;

  Room_X.setValue(roomX);

  Room_Y.setValue(roomY);

}
