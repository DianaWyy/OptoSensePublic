import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 1;
int numPixel = numRow * numCol;

// data
float[] gdata = new float[numPixel];
float currValue = 0;

// color for pixel
ColorMap cm = new ColorMap();

// counters
long operationTime = 0;
int counter = 0;
  
// for rolling graph
float inByte;
int[] yValues;
int w;

// for thresholds
int rawThreshold = 35;

// for saving measurements
Table table;
float measurements [] = new float [8];

// Image initialize
PImage door_closed;
PImage door_opened;
PImage mail_closed;
PImage mail_opened;
PImage drawer_closed;
PImage drawer_opened;
PImage[] imgs = new PImage[6];
String obj;

// flash counter
int flashCount = 0;


void setup() {
  //size(1680, 1000);
  fullScreen();
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  
  // white background
  background(255);
  operationTime = millis();
  
  // image
  door_closed = loadImage("doorClose.jpg");
  door_opened = loadImage("doorOpen.jpg");
  mail_closed = loadImage("mailboxClose.png");
  mail_opened = loadImage("mailboxOpen.png");
  drawer_closed = loadImage("drawerClose.png");
  drawer_opened = loadImage("drawerOpen.png");
  
  imgs[0] = door_closed;
  imgs[1] = door_opened;
  imgs[2] = mail_closed;
  imgs[3] = mail_opened;
  imgs[4] = drawer_closed;
  imgs[5] = drawer_opened;
  // for rolling graph
  w = width/2 - 10;
  strokeWeight(3);
  yValues = new int[w];
  smooth();
  
  //table
  table = new Table();
  for(int i = 0; i < 8; i++){
    table.addColumn("position_" + i);
  }
}

void draw() {
  Client thisClient = myServer.available();

      if (thisClient != null) {
        String whatClientSaid = thisClient.readString();
        if (whatClientSaid != null) {
          processData(whatClientSaid);
        } 
      }
      
  background(255);
  
  flashCount++;
  
  stroke(0);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  
  // 0D pixel
  int[] rgb = cm.getColor((float) ((currValue)/4096.0));
  fill(rgb[0], rgb[1], rgb[2]);
  noStroke();
  rect(370, 200, 100, 100);

  // show raw measurements text
  //fill(0);
  //textSize(22);
  //text("Threshold: "+ rawThreshold, width/2 - 175, height/2 + 400);
  
  // for rolling raw measurements
  float yOffset = height/2 + 50;
  int currValueDraw = (int) (4096 - currValue);
  
  currValueDraw = (int)map(currValueDraw, 0, 4096, 0, 255);
  
  // moving rolling buffer
  for(int i = 1; i < w; i++) {
        yValues[i-1] = yValues[i];
  }
  yValues[w-1] = currValueDraw;
  
  // counter for opened seconds
  //if (counter > 30) {
  //  int c = flashCount / 45;
  //  if (c % 2 == 0) {
  //    fill(255, 0, 0, 127);
  //    noStroke();
  //    rect(width/2 + 2, height/2 + 2, width/2 - 2, height/2 - 2);
  //  } else {
  //    fill(255);
  //    noStroke();
  //    rect(width/2 + 2, height/2 + 2, width/2 - 2, height/2 - 2);
  //  }
  //  fill(0);
  //  textSize(50);
  //  text("Please Close The Door", 1000, 930);
  //} else {
  //  fill(255);
  //  noStroke();
  //  rect(width/2 + 2, height/2 + 2, width/2 - 2, height/2 - 2);
  //}
  
  obj = "mailbox";
  // image display
  if (currValueDraw > (255 - rawThreshold)) {
    if (obj == "door") {
        image(imgs[0], width/2 + 5, 0, 600, height/2 - 2);
    } else if (obj == "mailbox") {
        image(imgs[2], width/2 + 275, 75, 288, 414.5);
    } else {
        image(imgs[4], width/2 + 300, 150, 227.5, 293);
    }
      counter = 0;
      fill(0);
      textSize(60);
      text("Door", 1140, 800);
      fill(255,0,0);
      text("Close", 1300, 800);
  } else {
    if (obj == "door") {
      image(imgs[1], width/2 + 293, 0, 600, height/2 - 2);
    } else if (obj == "mailbox") {
        image(imgs[3], width/2 + 275, 75, 310.5, 412);
    } else {
        image(imgs[5], width/2 + 300, 150, 263.5, 294.5);
    }
      calculateSeconds();
      fill(255,0,0);
      fill(0);
      textSize(60);
      text("Door", 1140, 800);
      fill(50,205,50);
      text("Open", 1300, 800);
      //textSize(70);
      //text(counter + "s", 1200, 850);
  } 
  
  // drawing rolling buffer for intensity
  noStroke();
  fill(255);
  rect(0, yOffset, width/2 - 2, 300);
  for(int i=1; i<w; i++) {
        fill(0);
        int y = (yValues[i] - 255) * 2;
        if (y < -255) {
          y = -255;
        }
        rect(i, yOffset + 255, 1, y);
  }
  fill(0);
  textSize(35);
  text("Raw measurement:", 10, yOffset - 13);
  // text(currValueDraw, 10, yOffset + 70);
  
  // draw threshold
  stroke(255, 200, 0);
  strokeWeight(1);
  line(0, 3 * (-rawThreshold) + yOffset + 255, width/2, 3 * (-rawThreshold) + yOffset + 255);
  
}


void calculateSeconds() {
  long currentTime = millis();
  if(currentTime - operationTime > 1000){
    operationTime = currentTime;
    counter ++;
  }
}

void keyPressed(){
 // adjust threshold 
  //if(key == CODED){
  // if(keyCode == UP){
  //   rawThreshold+= 5;
  // }else if (keyCode == DOWN){
  //   rawThreshold -= 5;
  // }
  //}
  
  // press 0, 1, ..., 7 to save 8 measurements to a csv file
  if( key>= '0' && key <= '7'){ 
    int index = Integer.parseInt(key+"");
    measurements[index] = currValue;
    
    for(int i = 0; i < measurements.length; i++){
      print(measurements[i]);
      print(' ');
    }
    println();
    
  }else if (key == 's'){
    TableRow newRow = table.addRow();
    for(int i = 0; i < 8; i++){
       newRow.setFloat("position_"+i, measurements[i]); 
    }
    saveTable(table, "data/measurements.csv");
    println("measurements saved into data/measurements.csv");
  }
}
// Process data method
void processData(String resultString) {
  String[] data = split(resultString, " ");
  
      if(data.length != numPixel) return;
      
      for(int i = 0; i < data.length; i++){
        gdata[i] = Float.parseFloat(data[i]);
      }
      
      currValue = gdata[4];
}
