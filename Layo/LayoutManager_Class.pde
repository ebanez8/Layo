class LayoutManager {
  Room room;
  float gridSize;

  LayoutManager(Room r, float gridSize) {
    this.room = r;
    this.gridSize = gridSize;
  }
  
  boolean hasCollision(Furniture a, Furniture b) {
    return !(a.x + a.width < b.x || a.x > b.x + b.width || a.y + a.height < b.y || a.y > b.y + b.height);
  }
  
  ArrayList<String> checkCollisions() {
    ArrayList<String> messages = new ArrayList<String>();
    for (int i = 0; i < room.items.size(); i++) {
      for (int j = i + 1; j < room.items.size(); j++) {
        Furniture a = room.items.get(i);
        Furniture b = room.items.get(j);
        if (hasCollision(a, b)) {
          messages.add("Collision between " + a.name + " and " + b.name);
        }
      }
    }
    return messages;
  }

  void snapToGrid(Furniture f) {
    f.x = round(f.x / gridSize) * gridSize;
    f.y = round(f.y / gridSize) * gridSize;
  }

  ArrayList<String> checkSpacing(float minDistance) {
    ArrayList<String> messages = new ArrayList<String>();
    for (int i = 0; i < room.items.size(); i++) {
      for (int j = i + 1; j < room.items.size(); j++) {
        Furniture a = room.items.get(i);
        Furniture b = room.items.get(j);
        float dx = (a.x + a.width / 2) - (b.x + b.width / 2);
        float dy = (a.y + a.height / 2) - (b.y + b.height / 2);
        float dist = dist(0, 0, dx, dy);
        if (dist < minDistance) {
          messages.add("Too little space between " + a.name + " and " + b.name);
        }
      }
    }
    return messages;
  }
  
  ArrayList<String> suggestImprovements() {
    ArrayList<String> suggestions = new ArrayList<String>();
    suggestions.addAll(checkCollisions());
    suggestions.addAll(checkSpacing(50));  // 50 pixels = ~minimum distance
    return suggestions;
  }
  
  
}
