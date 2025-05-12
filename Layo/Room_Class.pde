class Room {
  float width, height;
  ArrayList<Furniture> items;
  boolean showGrid;
  float zoom;

  Room(float w, float h) {
    width = w;
    height = h;
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
    width = newW;
    height = newH;
  }

  void toggleGrid() {
    showGrid = !showGrid;
  }

  void drawRoom() {
    pushMatrix();
    scale(zoom);
    fill(240);
    stroke(0);
    rect(0, 0, width, height);
    
    if (showGrid) {
      drawGrid();
    }
    for (Furniture f : items) {
      f.drawFurniture();
    }

    popMatrix();
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
