class Player {
  // Declare
  PVector pos;
  String name;
  boolean ready;
  Client client;
  
  // Constructer for server
  Player() {
    pos = new PVector(width / 2, height);
    ready = false;
  }
  
  // Constructer for clients
  Player(Client c) {
    pos = new PVector(width / 2, height);
    ready = false;
    client = c;
  }
  
  // Getters
  PVector getPos() {
    return pos;
  }
  
  Client getClient() {
    return client;
  }
}
