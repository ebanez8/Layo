class Grid{
  float cellSize;
  boolean visible;
  
  Grid(float c, boolean v) {
    this.cellSize = c;
    this.visible = v;
  }
  
  void toggleVisibility() {}
  void drawGrid(){
    stroke(0);
    strokeWeight(0.1);
    for(int i = 1; i <= int(width/cellSize); i++) {
      line(i*cellSize, 0, i*cellSize, height);
    }
    for(int i = 1; i <= int(height/cellSize); i++) {
      line(0, i*cellSize, width, i*cellSize);
    }
  }
  
}
