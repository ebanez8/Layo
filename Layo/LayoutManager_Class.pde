class LayoutManager {
  Room room;
  float gridSize;

  LayoutManager(Room r, float gridSize) {
    this.room = r;
    this.gridSize = gridSize;
  }
  
  boolean hasCollision(Furniture a, Furniture b) {
    return !(a.x + a.widths <= b.x || a.x >= b.x + b.widths || a.y + a.heights <= b.y || a.y >= b.y + b.heights);
  }
  
  void snapToGrid(Furniture f) {
    f.x = round(f.x / gridSize) * gridSize;
    f.y = round(f.y / gridSize) * gridSize;
   
  }
}
