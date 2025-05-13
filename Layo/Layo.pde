import g4p_controls.*;
float roomX = 800;
float roomY = 800;
ArrayList<Furniture> furnitureList = new ArrayList<Furniture>();



void setup(){
  createGUI();
  size(800, 800);
  background(255);
  
  
  
 
}
void draw() {
  background(255);
  Room room = new Room(roomX, roomY);
  room.drawRoom();
  for (Furniture f : furnitureList) {
    fill(f.col);
    f.drawFurniture();
  }
}
