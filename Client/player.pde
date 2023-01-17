class Player {
  // Declare
  PVector pos;
  String name;
  boolean ready;
  
  // Constructer
  Player() {
    pos = new PVector(width / 2, height);
    ready = false;
  }
  
  // Getters
  PVector getPos() {
    return pos;
  }
}
