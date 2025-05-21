class Furniture{
  float widths;// size of furniture
  float heights;
  float x; // starting draw point
  float y;
  int rotation; // degree of rotation
  boolean is_selected; // if selected
  PImage img; // image of furniture
  
  Furniture(float x1, float y1, float w, float h, int r, boolean isSel, PImage img){
    this.x = x1;
    this.y = y1;
    this.widths =w;
    this.heights = h;
    this.rotation = r;
    this.is_selected = isSel;
    this.img = img;
  }
  void rotateF() {
    // angle of rotation
    rotation = (rotation + 90) % 360;
    // find center to rotate on center axis
    float centerX = x + widths / 2;
    float centerY = y + heights / 2;
    // swap width and height
    float temp = widths;
    widths = heights;
    heights = temp;
    // new x and y to keep object centered
    x = centerX - widths / 2;
    y = centerY - heights / 2;
    // keep in room
    constrainToRoom(room);
  }
  
  void drawFurniture() {
    noFill(); // set outline to basic properties
    strokeWeight(0);
    pushMatrix(); // save transformation matrix
    translate(x + widths / 2, y + heights / 2); // move to object's center point
    rotate(radians(rotation)); // Rotate by specified degrees
    
    imageMode(CENTER); // draw image from center point
    if (rotation == 0 || rotation == 180 || rotation == 360) { // set rotation to basic size if 0, 180, 360
      image(img, 0, 0, widths, heights);
    } else { // rotate sideways  if 90, 270
      image(img, 0, 0, heights, widths);
    }
    
    if (draw_g) { // drawing grid
      stroke(0); // set line properties to new properties 
      strokeWeight(1.5);
      rectMode(CENTER); // draw rectangle from center point
      if (rotation == 0 || rotation == 180 || rotation == 360) { // set rotation to basic size if 0, 180, 360
        rect(0, 0, widths, heights);
      } else { // rotate sideways  if 90, 270
        rect(0, 0, heights, widths);
      }
      
    }
  
    popMatrix(); // restore transformation matrix
  }
  
  boolean isClicked(float mx, float my) { // check if mouse is over a furniture when clicked
    return (mx > x && mx < x + widths && my > y && my < y + heights);
  }
  
  void constrainToRoom(Room room) { // keeps furniture in room
    float roomX = (width - room.rwidth) / 2;
    float roomY = (height - room.rheight) / 2;

    // constrain left and top edges
    if (x < roomX) x = roomX;
    if (y < roomY) y = roomY;

    // constrain right and bottom edges
    if (x + widths > roomX + room.rwidth) x = roomX + room.rwidth - widths;
    if (y + heights > roomY + room.rheight) y = roomY + room.rheight - heights;
  }
  
  void moveTo(float newX, float newY) { // move furniture to wherever mouse has moved
    this.x = newX;
    this.y = newY;
    constrainToRoom(room); // keep in room
  }
  
  

}
