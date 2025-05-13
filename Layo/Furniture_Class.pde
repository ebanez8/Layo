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
  void rotated(int rotation){}
  void drawFurniture(){
    noStroke();
    rect(x,y,widths,heights);
  }
  
  boolean isClicked(float mx, float my) {
    return (mx > x && mx < x + widths && my > y && my < y + heights);
  }
  
  void moveTo(float newX, float newY) {
    this.x = newX;
    this.y = newY;
  }
  
  

}
