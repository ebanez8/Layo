class Furniture{
  float widths;
  float heights;
  float x;
  float y;
  int rotation;
  color col;
  boolean is_selected;
  PImage img;
  
  Furniture(float x1, float y1, float w, float h, int r, color c, boolean isSel, PImage img){
    this.x = x1;
    this.y = y1;
    this.widths =w;
    this.heights = h;
    this.rotation = r;
    this.col = c;
    this.is_selected = isSel;
    this.img = img;
  }
  void rotateF() {
    // Rotate angle
    rotation = (rotation + 90) % 360;
  
    // Compute center before changing size
    float centerX = x + widths / 2;
    float centerY = y + heights / 2;
  
    // Swap width and height
    float temp = widths;
    widths = heights;
    heights = temp;
  
    // Recalculate x, y to keep object centered
    x = centerX - widths / 2;
    y = centerY - heights / 2;
  }
  
  void drawFurniture() {
    stroke(0);
    strokeWeight(0);
    if (draw_g){strokeWeight(5);}
    pushMatrix();
    translate(x + widths / 2, y + heights / 2);
    rotate(radians(rotation));
    
    imageMode(CENTER);
    if (rotation == 0 || rotation == 180 || rotation == 360) {
      image(img, 0, 0, widths, heights);
    } else {
      image(img, 0, 0, heights, widths);
    }
    
    if (draw_g) {
      noFill();
      stroke(0);
      strokeWeight(1);
      rectMode(CENTER);
      if (rotation == 0 || rotation == 180 || rotation == 360) {
        rect(0, 0, widths, heights);
      } else {
        rect(0, 0, heights, widths);
      }
    }
  
    popMatrix();
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
