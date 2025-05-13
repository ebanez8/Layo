import g4p_controls.*;
ArrayList<Furniture> furnitureList = new ArrayList<Furniture>();


void setup(){
  createGUI();
  size(800, 800);
  background(255);
  
  
 
}
void draw() {
  background(255);

  for (Furniture f : furnitureList) {
    fill(f.col);
    f.drawFurniture();
  }
}
