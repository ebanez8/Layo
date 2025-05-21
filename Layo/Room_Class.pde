class Room {
  float rwidth, rheight;
  ArrayList<Furniture> items; // might not need this
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
    fill(175);
    stroke(50);
    strokeWeight(5);
    rectMode(CORNER);
    rect((width-rwidth)/2, (height-rheight)/2, rwidth, rheight);
    
    if (showGrid) {
      drawGrid();
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
  void saveToFile(String filename) {

    PrintWriter output = createWriter("data/" + filename + ".txt");
    // Write room dimensions
  
    output.println(rwidth + "," + rheight);
  
  
    // Write furniture count
    output.println(items.size());
    // Write each furniture item
  
    for (Furniture f : items) {
      String type = "";
      if (f.img == imgTable) type = "Table";
  
      else if (f.img == imgTBed) type = "TBed";
  
      else if (f.img == imgChair) type = "Chair";
  
      else if (f.img == imgCouch) type = "Couch";
  
      else if (f.img == imgSBed) type = "SBed";
  
      output.println(type + "," + f.x + "," + f.y + "," + f.widths + "," + f.heights + "," + f.rotation);
  
    }
  
  
    output.close();
  }
  void loadFromFile(String filename) {

    String[] lines = loadStrings("data/" + filename + ".txt");
  
    if (lines == null || lines.length < 2) return;
  
    
  
    // Read room dimensions
  
    String[] roomDims = split(lines[0], ',');
  
    rwidth = float(roomDims[0]);
  
    rheight = float(roomDims[1]);
  
    
  
    // Clear existing furniture
  
    items.clear();
  
    
  
    // Read furniture count
  
    int count = int(lines[1]);
  
    
  
    // Read each furniture item
  
    for (int i = 0; i < count && i + 2 < lines.length; i++) {
  
      String[] parts = split(lines[i + 2], ',');
  
      if (parts.length < 6) continue;
  
      
  
      String type = parts[0];
  
      float x = float(parts[1]);
  
      float y = float(parts[2]);
  
      float w = float(parts[3]);
  
      float h = float(parts[4]);
  
      int rot = int(parts[5]);
  
      
  
      // Get image based on type
  
      PImage img = null;
  
      if (type.equals("Table")) img = imgTable;
  
      else if (type.equals("TBed")) img = imgTBed;
  
      else if (type.equals("Chair")) img = imgChair;
  
      else if (type.equals("Couch")) img = imgCouch;
  
      else if (type.equals("SBed")) img = imgSBed;
  
      
  
      if (img != null) {
  
        items.add(new Furniture(x, y, w, h, rot, false, img));
  
      }
  
    }
  
  }

}
