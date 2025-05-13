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
  void move_to(float x2, float y2){}
  void resized(float widths, float heights){}
  void collides_with(Object Furniture){}
  void drawFurniture(){
    noStroke();
    rect(x,y,widths,heights);
  }
  //rotate(angle: int)
//move_to(x: float, y: float)
//resize(width: float, height: float)
//collides_with(other: Furniture) -> bool


}
