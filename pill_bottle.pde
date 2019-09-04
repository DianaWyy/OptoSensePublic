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
int rawThreshold = 60;

// for saving measurements
Table table;
float measurements [] = new float [8];

// Image initialize
PImage img_closed;
PImage img_opened;

// flash counter
int flashCount = 0;

// pill taken times
int pillCount = 0;
float currDerivative = 0;
float formerDerivative = 0;
int derivativeThreshold = 60;
//boolean latency = true;


void setup() {
  //size(1680, 1000);
  fullScreen();
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  
  // white background
  background(255);
  operationTime = millis();
  
  // image
  img_closed = loadImage("bottle_close.jpg");
  img_opened = loadImage("bottle_open.jpg");
  
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
  fill(0);
  textSize(22);
  text("Threshold: "+ rawThreshold, width/2 - 175, height/2 + 400);
  
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
  if (counter > 15) {
    int c = flashCount / 45;
    if (c % 2 == 0) {
      fill(255, 0, 0, 127);
      noStroke();
      rect(width/2 + 2, height/2 + 2, width/2 - 2, height/2 - 2);
    } else {
      fill(255);
      noStroke();
      rect(width/2 + 2, height/2 + 2, width/2 - 2, height/2 - 2);
    }
    fill(0);
    textSize(32);
    text("Please close the pill bottle.", 1100, 825);
  } else {
    fill(255);
    noStroke();
    rect(width/2 + 2, height/2 + 2, width/2 - 2, height/2 - 2);
  }
  
  // pill taken times
  fill(0);
  textSize(30);
  text("Pill Taken: " + pillCount + " times", width/2 + 20, height/2 + 35);
  if (currDerivative > derivativeThreshold && formerDerivative < derivativeThreshold) {
        pillCount++;
  }
  
  // image display
  if (currValueDraw > (255 - rawThreshold)) {
      image(img_closed, width/2 + 225, 125, 250, 375);
      counter = 0;
      fill(0);
      textSize(50);
      text("Pill Bottle Closed", 1075, 700);
  }else {
      image(img_opened, width/2 + 2, 0, width / 2 - 2, height/2 - 2);
      calculateSeconds();
      fill(0);
      textSize(50);
      text("Pill Bottle Opened", 1075, 700);
      text(counter + "s", 1225, 775);
  } 
  
  // drawing rolling buffer for intensity
  noStroke();
  fill(255);
  rect(0, yOffset, width/2 - 2, 300);
  for(int i=1; i<w; i++) {
        fill(0);
        rect(i, yOffset + 255, 1, yValues[i] - 255);
  }
  fill(0);
  textSize(22);
  text("Raw measurement:", 10, yOffset - 20);
  // text(currValueDraw, 10, yOffset + 70);
  
  // draw threshold
  stroke(255, 200, 0);
  strokeWeight(1);
  line(0, -rawThreshold + yOffset + 255, width/2, -rawThreshold + yOffset + 255);
  
  formerDerivative = currDerivative;
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
  if(key == CODED){
   if(keyCode == UP){
     rawThreshold+= 5;
   }else if (keyCode == DOWN){
     rawThreshold -= 5;
   }
  }
  
  // press 0, 1, ..., 7 to save 8 measurements to a csv file
  else if( key>= '0' && key <= '7'){ 
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
      
      currDerivative = gdata[4] - currValue;
      currValue = gdata[4];
}
