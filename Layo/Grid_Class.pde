class Grid{
  float cellSize; // length and width of the cell (square)
  boolean visible; // whether you can see the gridlines or not
  
  Grid(float c, boolean v) {
    this.cellSize = c;
    this.visible = v;
  }
  
  void drawGrid(){
    stroke(0); // black
    strokeWeight(0.1); // width
    for(int i = 1; i <= int(width/cellSize); i++) { // width of screen divided by cellsize for number of cells in a column
      line(i*cellSize, 0, i*cellSize, height);// draw the lines vertically
    }
    for(int i = 1; i <= int(height/cellSize); i++) { // same but for column
      line(0, i*cellSize, width, i*cellSize); //draw horizontally
    }
  }  
}
