import ddf.minim.AudioSample;
import ddf.minim.Minim;
import processing.net.*;

Minim minim; 
AudioSample kick;

long operationTime = 0;
int count = -5;
int index;

int numRow = 8;
int numCol = 8;
int randI;
int randJ;
boolean changed = false;

PImage cross;

void setup() {
  //size(1680, 1000);
  fullScreen();
  
  // white background
  background(255);
  operationTime = millis();
  
  minim = new Minim(this); 
  kick = minim.loadSample("beep.mp3", 512);
  
  randI = int(random(numRow));
  randJ = int(random(numCol));
  
  cross = loadImage("cross.png");
  index = 0;
}

void draw() {
  background(255);
  float size = width/2/numRow;
  for (int j = 0; j < numRow; j++){
    for(int i = 0; i < numCol; i++){
      if (randI == i && randJ == j && count >= 0) {
        image(cross, randI * size, 100 + randJ * size, size-3, size-3);
      } else {
        fill(0);
        stroke(255);
        rect(i*size, 100+j*size, size-3, size-3);
      }
    }
  }
  calculateSeconds();
  if (count < 0) {
    fill(0);
    textSize(80);
    text("Testing Start", width/2 + 125, height/2);
  } else {
    fill(0);
    textSize(80);
    text(index + ". Touch Here", width/2 + 125, height/2);
    
    if (count % 5 == 0 && !changed) {
      fill(255);
      noStroke();
      rect(0,0,width,height);
      randI = int(random(numRow));
      randJ = int(random(numCol));
      index++;
      kick.trigger(); // play beep sound
      changed = true;
    }
    if (count % 5 == 1) {changed = false;}
    if (count == 105) {exit();}
  }
}
  
void calculateSeconds() {
  long currentTime = millis();
  if(currentTime - operationTime > 1000){
    operationTime = currentTime;
    count ++;
  }
}
