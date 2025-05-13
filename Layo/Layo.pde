import g4p_controls.*;
float roomX = 600;
float roomY = 600;
ArrayList<Furniture> furnitureList = new ArrayList<Furniture>();



void setup(){
  createGUI();
  size(800, 800);
  background(255);
  
  
  
 
}
void draw() {
  background(255);
  Room room = new Room(roomX, roomY);
  Grid grid = new Grid(50,true);
  room.drawRoom();
  grid.drawGrid();
  for (Furniture f : furnitureList) {
    fill(f.col);
    f.drawFurniture();
  }
}
