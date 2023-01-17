// Load packages
import processing.net.*;
import java.util.Arrays;

// Constants
final int PORT = 8080;

// Declare
Server server;
TextBox nameBox;
Button readyButton;
ArrayList<Player> players;
int state;



void setup() {
  fullScreen();
  textAlign(CENTER);
  textSize(64);
  
  nameBox = new TextBox(width / 4 - width / 6, round(height / 1.8), width / 3, height / 12);
  readyButton = new Button(width / 4 - width / 10, round(height / 1.5), width / 5, height / 12, "START!");
  players = new ArrayList<Player>();
  state = 0;
  
  players.add(new Player());
  
  // Start server
  server = new Server(this, PORT);
}



void draw() {
  background(69);
  textAlign(CENTER);
  
  if (state == 0) {
    players.get(0).name = nameBox.text;
    line(width / 2, 0, width / 2, height);
    text(players.size() > 1 ? str(players.size()) + " players connected" : "1 player connected", width / 4, height / 2);
    readyButton.draw();
    nameBox.draw();
    
    textAlign(LEFT);
    for (int i = 0; i < players.size(); i++) {
      final Player player = players.get(i);
      text(player.name, width / 1.8, height / 11 * (i + 1));
      text(player.ready ? "READY" : "...", width / 1.2, height / 11 * (i + 1));
    }
      
    // Update ready/name list
    Client player = server.available();
    if (player != null) {
      // Recieved message from client
      final byte[] rbytes = player.readBytes();
      
      // Compare message to connected clients
      for (int i = 1; i < players.size(); i++) {
        Player p = players.get(i);
        
        // Comparison
        if (p.getClient().ip().equals(player.ip())) {
          // Player already connected
          if (int(rbytes[0]) == 1) {
            // Update ready status
            p.ready = boolean(rbytes[1]);
            // Update name
            p.name = new String(Arrays.copyOfRange(rbytes, 2, rbytes.length));
            
            // If the name is too long, force it to be shortened
            if (p.name.length() > 20) {
              p.name = p.name.substring(0, 20);
            }
          }
          // returns only for a player already connected
          return;
        }
      }
      
      // Accept new player
      byte[] bytes = new byte[1];
      bytes[0] = byte(players.size());
      player.write(bytes);
      players.add(new Player(player));
    }
  }
}



void keyPressed() {
  if (state == 0) {
    nameBox.getUserInput();
  }
}



void mouseClicked() {
  if (state == 0) {
    if (readyButton.hovering()) {
      readyButton.toggle = !readyButton.toggle;
      state = 1;
    }
  }
}
