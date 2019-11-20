import ddf.minim.AudioSample;
import ddf.minim.Minim;
import processing.net.*;

// display sound
Minim minim; 
AudioSample kick;

// swipes
int index;
String[] strs = {"Swipe Up", "Swipe Down", "Swipe Left", "Swipe Right"};
int rand;
// arrows
PImage arrowUp;
PImage arrowDown;
PImage arrowLeft;
PImage arrowRight;
PImage[] imgs = new PImage[4];
// for showing 5 same swipe commands consecutively
IntList indices;
int[] finalIndices;

void setup() {
  fullScreen(); // screen size
  
  // white background
  background(255);
  
  // load sound
  minim = new Minim(this); 
  kick = minim.loadSample("beep.mp3", 512);
  
  // load indices
  indices = new IntList();
  for(int i = 0; i < 5; i++){
    indices.append(0);
    indices.append(1);
    indices.append(2);
    indices.append(3);
  }
  indices.shuffle();
  println(indices);
  finalIndices = indices.array();
  index = 0;
  
  // load arrow images
  arrowUp = loadImage("arrowUp.png");
  arrowDown = loadImage("arrowDown.png");
  arrowLeft = loadImage("arrowLeft.png");
  arrowRight = loadImage("arrowRight.png");
  imgs[0] = arrowUp;
  imgs[1] = arrowDown;
  imgs[2] = arrowLeft;
  imgs[3] = arrowRight;
}

void draw() {
  background(255); // white
  if (index == 20) {
    exit(); // exit after 20 commands
  }
  
  // swipe text
  fill(0);
  textSize(80);
  text((index + 1) + ". " + strs[finalIndices[index]], width/2 - 250, height/2 - 300);
  
  // display image
  if (finalIndices[index] < 2) {image(imgs[finalIndices[index]], width/2 - 130, 325, 231, 550);}
  else {image(imgs[finalIndices[index]], width/2 - 225, height/2 - 100, 550, 231);}
}

// key pressed functions
void keyPressed(){
  if (keyPressed) {
    // press space to show next command
    if(key == ' '){
      fill(255);
      noStroke();
      rect(width/2 - 200, height/2 - 100, 400, 400);
      index++;
      kick.trigger(); // play beep sound
     }
  }
}
