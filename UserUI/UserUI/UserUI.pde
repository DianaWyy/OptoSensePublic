import ddf.minim.AudioSample;
import ddf.minim.Minim;
import processing.net.*;

Minim minim; 
AudioSample kick;

//long operationTime = 0;
int count = 0;
int index;

String[] strs = {"Swipe Up", "Swipe Down", "Swipe Left", "Swipe Right"};
boolean[] occured = {false, false, false, false};
int rand;
//boolean changed = false;

PImage arrowUp;
PImage arrowDown;
PImage arrowLeft;
PImage arrowRight;
PImage[] imgs = new PImage[4];

void setup() {
  //size(1680, 1000);
  fullScreen();
  
  // white background
  background(255);
  //operationTime = millis();
  
  minim = new Minim(this); 
  kick = minim.loadSample("beep.mp3", 512);
  
  rand = int(random(strs.length));
  occured[rand] = true;
  index = 1;
  
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
  background(255);
  //calculateSeconds();
  //if (count < 0) {
  //  fill(0);
  //  textSize(80);
  //  text("Testing Start", width/2 - 225, height/2);
  //} else {
    fill(0);
    textSize(80);
    text(index + ". " + strs[rand], width/2 - 250, height/2 - 300);
    if (rand < 2) {image(imgs[rand], width/2 - 130, 325, 231, 550);}
    else {image(imgs[rand], width/2 - 225, height/2 - 100, 550, 231);}
    
    if (index == 21) {
      exit();
    }
    
    //if (count % 5 == 0 && !changed) {
    //  fill(255);
    //  noStroke();
    //  rect(width/2 - 200, height/2 - 100, 400, 400);
    //  rand = int(random(strs.length));
    //  index++;
    //  kick.trigger(); // play beep sound
    //  //fill(0);
    //  //textSize(80);
    //  //text(index + ". " + strs[rand], width/2 - 225, height/2);
    //  changed = true;
    //}
    //if (count % 5 == 1) {changed = false;}
    //if (count == 105) {exit();}
  //}
}
  
//void calculateSeconds() {
//  long currentTime = millis();
//  if(currentTime - operationTime > 1000){
//    operationTime = currentTime;
//    count ++;
//  }
//}

void keyPressed(){
  if (keyPressed) {
    if(key == ' '){
      fill(255);
      noStroke();
      rect(width/2 - 200, height/2 - 100, 400, 400);
      index++;
      count++;
      kick.trigger(); // play beep sound
      if (count == 5) {
        while (occured[rand] == true) {
          rand = int(random(strs.length));
        }
        occured[rand] = true;
        count = 0;
      }
     }
  }
}
