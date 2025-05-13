class Room {
  float rwidth, rheight;
  ArrayList<Furniture> items;
  boolean showGrid;
  float zoom;

  Room(float w, float h) {
    rwidth = w;
    rheight = h;
    items = new ArrayList<Furniture>();
    showGrid = false;
    zoom = 1.0;
  }

  void addFurniture(Furniture f) {
    items.add(f);
  }

  void removeFurniture(Furniture f) {
    items.remove(f);
  }

  void clearFurniture() {
    items.clear();
  }

  void resize(float newW, float newH) {
    rwidth = newW;
    rheight = newH;
  }

  void toggleGrid() {
    showGrid = !showGrid;
  }

  void drawRoom() {
    fill(240);
    rect((width-rwidth)/2, (height-rheight)/2, rwidth, rheight);
    
    if (showGrid) {
      drawGrid();
    }
    for (Furniture f : items) {
      f.drawFurniture();
    }
  }

  void drawGrid() {
    stroke(200);
    for (int x = 0; x < width; x += 50) {
      line(x, 0, x, height);
    }
    for (int y = 0; y < height; y += 50) {
      line(0, y, width, y);
    }
  }
}
