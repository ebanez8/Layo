class Furniture{
  float widths;
  float heights;
  float x;
  float y;
  int rotation;
  color col;
  boolean is_selected;

  Furniture(float x1, float y1, float w, float h, int r, color c, boolean isSel){
    this.x = x1;
    this.y = y1;
    this.widths =w;
    this.heights = h;
    this.rotation = r;
    this.col = c;
    this.is_selected = isSel;
  }
  void rotate() {
    float centerX = x + widths / 2;
    float centerY = y + heights / 2;
  
    // Swap widths and heights 
    float temp = widths;
    widths = heights;
    heights = temp;
  
    // Re-center after swap
    x = centerX - widths / 2;
    y = centerY - heights / 2;
  
    //Keep track of rotation angle (0, 90, 180, 270)
    rotation = (rotation + 90) % 360;
    constrainToRoom(room);
  }
  void drawFurniture(){
    noStroke();
    rect(x,y,widths,heights);
  }
  
  boolean isClicked(float mx, float my) {
    return (mx > x && mx < x + widths && my > y && my < y + heights);
  }
  
  void constrainToRoom(Room room) {
    float roomX = (width - room.rwidth) / 2;
    float roomY = (height - room.rheight) / 2;

    // Constrain left and top edges
    if (x < roomX) x = roomX;
    if (y < roomY) y = roomY;

    // Constrain right and bottom edges
    if (x + widths > roomX + room.rwidth) x = roomX + room.rwidth - widths;
    if (y + heights > roomY + room.rheight) y = roomY + room.rheight - heights;
  }
  void moveTo(float newX, float newY) {
    this.x = newX;
    this.y = newY;
    constrainToRoom(room);
  }
  
  

}
