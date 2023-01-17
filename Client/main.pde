// Load packages
import processing.net.*;
import java.util.Arrays;

// Constants
final int PORT = 8080;

// Declare
Client client;
TextBox nameBox;
Button readyButton;
ArrayList<Player> players;
int state;
int myID;



void setup() {
  fullScreen();
  textAlign(CENTER);
  textSize(64);
  
  nameBox = new TextBox(width / 4 - width / 6, round(height / 1.8), width / 3, height / 12);
  readyButton = new Button(width / 4 - width / 10, round(height / 1.5), width / 5, height / 12, "START!");
  players = new ArrayList<Player>();
  state = -1;
  
  // Start server
  client = new Client(this, "10.130.145.118", PORT);
  client.write("connected");
}



void draw() {
  background(69);
  textAlign(CENTER);
  
  if (state == -1) {
    // Waiting for connection
    text("Connecting to server", width / 2, height / 2);
    
    if (client.available() > 0) {
      byte[] rbytes = client.readBytes();
      myID = int(rbytes[0]);
      state = 0;
    }
    
  } else if (state == 0) {
    text("Name:", width / 4, height / 2);
    readyButton.draw();
    nameBox.draw();
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
