import ddf.minim.AudioSample;
import ddf.minim.Minim;
import processing.net.*;
import java.awt.event.KeyEvent;

// beep cound
Minim minim; 
AudioSample kick;

// time count
long operationTime = 0;
int count = 0;

// for plus sign location change
boolean changed = false;

// pixels
int numRow = 8;
int numCol = 8;
int len = 600;

// commands
int index;
String[] strs = {"Bottom Left", "Bottom Right", "Center", "Top Left", "Top Right"};
IntList indices;
int[] finalIndices;
// plus image
PImage plus;

void setup() {
  size(600, 600); // screen size
  
  // white background
  background(255);
  
  // start time count
  operationTime = millis();
  
  // load beep sound
  minim = new Minim(this); 
  kick = minim.loadSample("beep.mp3", 512);
  
  // initialize IntLists
  indices = new IntList();
  for(int i = 0; i < 4; i++){
    indices.append(0);
    indices.append(1);
    indices.append(2);
    indices.append(3);
    indices.append(4);
  }
  indices.shuffle();
  println(indices);
  finalIndices = indices.array();
  index = 0;
  
  // load plus image
  plus = loadImage("plus.png");
}

void draw() {
  background(255); // white
  float size = width/numRow; // plus image size
  
  // command text display
  fill(0);
  textSize(40);
  text((index) + ". " + strs[finalIndices[index]], width/2 - 150, height/2 - 200);
  
  // image display
  if (finalIndices[index] == 0) {
    image(plus, len * 1 / 8, len* 7 / 8, size-3, size-3);
  }
  else if (finalIndices[index] == 1) {
    image(plus, len * 7 / 8, len* 7 / 8, size-3, size-3);
  }
  else if (finalIndices[index] == 2) {
    image(plus, len / 2, len / 2, size-3, size-3);
  }
  else if (finalIndices[index] == 3) {
    image(plus, len* 1 / 8, len* 1 / 8, size-3, size-3);
  }
  else if (finalIndices[index] == 4) {
    image(plus, len* 7 / 8, len* 1 / 8, size-3, size-3);
  }
  
  // count time
  calculateSeconds();
    if (count == 105) {exit();} // exit after 20 commands
    // change image location every 5 seconds
    if (count % 5 == 0 && changed == false) {
      fill(255);
      noStroke();
      rect(width/2 - 200, height/2 - 100, 400, 400); // update screen
      index++; 
      kick.trigger(); // play sound
      changed = true;
    }
    if (count % 5 == 1) {changed = false;} // for correct image change
}
  
// calculate seconds
void calculateSeconds() {
  long currentTime = millis();
  if(currentTime - operationTime > 1000){
    operationTime = currentTime;
    count ++;
  }
}

// key pressed function
void keyPressed(){
  if (keyPressed) {
    // press space to change plus image location
    if(key == ' '){
      fill(255);
      noStroke();
      rect(width/2 - 200, height/2 - 100, 400, 400);
      index++;
      kick.trigger(); // play beep sound
     }
  }
}
