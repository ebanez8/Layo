class Room {
  float rwidth, rheight;// room width and height
  ArrayList<Furniture> items; // might not need this
  boolean showGrid; // true or false showgrid

  Room(float w, float h) {
    rwidth = w;
    rheight = h;
    items = new ArrayList<Furniture>();
    showGrid = false;
  }

  void addFurniture(Furniture f) { // add furniture to arraylist
    items.add(f);
  }

  void clearFurniture() {
    items.clear();  // removes all furniture
  }

  void resize(float newW, float newH) {
    rwidth = newW;
    rheight = newH;//change to new values
  }

  void toggleGrid() { 
    showGrid = !showGrid; // turns to opposite
  }

  void drawRoom() {
    fill(175);
    stroke(50);
    strokeWeight(5);
    rectMode(CORNER);
    rect((width-rwidth)/2, (height-rheight)/2, rwidth, rheight);
    
    if (showGrid) {//if showgrid is true draw it
      drawGrid();
    }
  }

  void drawGrid() {//draw the grid
    stroke(200);
    for (int x = 0; x < width; x += 50) {// increments of 50 since cell size is 50, vertical
      line(x, 0, x, height);
    }
    for (int y = 0; y < height; y += 50) { // horizontal
      line(0, y, width, y);
    }
  }
  
  void saveToFile(String filename) {
    PrintWriter output = createWriter("data/" + filename + ".txt"); // creates new file with name filename, in the data folder
    // Write room dimensions
  
    output.println(rwidth + "," + rheight); // print itthe width and height on the firstline
  
    // Write furniture count
    output.println(items.size());
    // Write each furniture item
    for (Furniture f : items) {
      String type = "";
      if (f.img == imgTable) type = "Table"; // check what type of furniture it is by comparing img
  
      else if (f.img == imgTBed) type = "TBed";
  
      else if (f.img == imgChair) type = "Chair";
  
      else if (f.img == imgCouch) type = "Couch";
  
      else if (f.img == imgSBed) type = "SBed";
  
      output.println(type + "," + f.x + "," + f.y + "," + f.widths + "," + f.heights + "," + f.rotation);
      // format for when reading using type , x value ,y value, width, height and rotation
    }
  
  
    output.close(); // close
  }
  void loadFromFile(String filename) {

    String[] lines = loadStrings("data/" + filename + ".txt");// create array by loading from file
  
    if (lines == null || lines.length < 2) return;//if the file doesnt follow the format we dont open it
  
    // Read room dimensions
    String[] roomDims = split(lines[0], ',');//follows the format
  
    rwidth = float(roomDims[0]);//formats
  
    rheight = float(roomDims[1]);
  
    // Clear existing furniture
  
    items.clear();
    // Read furniture count
    int count = int(lines[1]);

    // Read each furniture item
    for (int i = 0; i < count && i + 2 < lines.length; i++) {
  
      String[] parts = split(lines[i + 2], ','); // split at ,
  
      String type = parts[0];
      float x = float(parts[1]); // follows the format for file  fetches all the things we need based on the format
      float y = float(parts[2]);
      float w = float(parts[3]);
      float h = float(parts[4]);
      int rot = int(parts[5]);
  
      // Get image based on type
  
      PImage img = null;
  
      if (type.equals("Table")){ img = imgTable;}// finds what type of furniture it is based off the img
  
      else if (type.equals("TBed")) img = imgTBed;
  
      else if (type.equals("Chair")) img = imgChair;
  
      else if (type.equals("Couch")) img = imgCouch;
  
      else if (type.equals("SBed")) img = imgSBed;
  
      if (img != null) {
  
        items.add(new Furniture(x, y, w, h, rot, false, img)); // adds to the items, and creates new furniture based off it ,if there is a img
  
      }
  
    }
  
  }

}
