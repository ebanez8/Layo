class Furniture{
  float widths;
  float heights;
  float x;
  float y;
  int rotation;
  String colors;
  boolean is_selected;
  Furniture(float w, float h, float x1, float y1, int r, String s, boolean isSel){
    this.widths =w;
    this.heights = h;
    this.x = x1;
    this.y = y1;
    this.rotation = r;s
    this.colors = s;
    this.is_selected = isSel;
  }
  void rotated(int rotation){}
  void move_to(float x2, float y2){}
  void resized(float widths, float heights){}
  void collides_with(Object Furniture){}
  void drawFurniture(){
    
  }
  //rotate(angle: int)
//move_to(x: float, y: float)
//resize(width: float, height: float)
//collides_with(other: Furniture) -> bool


}
