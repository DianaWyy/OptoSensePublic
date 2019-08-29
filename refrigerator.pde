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
int rawThreshold = 200;

// for saving measurements
Table table;
float measurements [] = new float [8];

// Image initialize
PImage img_closed;
PImage img_opened;


void setup() {
  size(1680, 1000);
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  
  // white background
  background(255);
  operationTime = millis();
  
  // image
  img_closed = loadImage("refrigerator_closed.jpg");
  img_opened = loadImage("refrigerator_opened.jpg");
  
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
  
  // 0D pixel
  int[] rgb = cm.getColor((float) ((currValue)/4096.0));
  fill(rgb[0], rgb[1], rgb[2]);
  noStroke();
  rect(370, 200, 100, 100);

  // show raw measurements text
  fill(0);
  textSize(22);
  text("Threshold: "+ rawThreshold, width/2 - 200, 520);
  
  // for rolling raw measurements
  float yOffset = 550;
  int currValueDraw = (int) (4096 - currValue);
  
  currValueDraw = (int)map(currValueDraw, 0, 4096, 0, 255);
  
  // moving rolling buffer
  for(int i = 1; i < w; i++) {
        yValues[i-1] = yValues[i];
  }
  yValues[w-1] = currValueDraw;
  
  // counter for opened seconds
  if (counter > 30) {
    fill(255, 0, 0, 127);
    noStroke();
    rect(840, 500, 840, 500);
    fill(0);
    textSize(30);
    text("Please close the door.", 1100, 850);
  } else {
    fill(255);
    noStroke();
    rect(840, 500, 840, 500);
  }
  fill(0);
  textSize(50);
  text("Opened For", 1100, 650);
  text(counter + "s", 1100, 750);
  
  // image display
  if (currValueDraw < rawThreshold) {
      image(img_closed, 840, 0, 840, 500);
      counter = 0;
  }else {
      image(img_opened, 840, 0, 840, 500);
      calculateSeconds();
  } 
  
  // drawing rolling buffer for intensity
  noStroke();
  fill(255);
  rect(0, yOffset, width/2, height/2);
  strokeWeight(3);
  stroke(0);
  for(int i=1; i<w; i++) {
        line(i, yValues[i] + yOffset, i-1, yValues[i-1] + yOffset);
  }
  fill(0);
  textSize(22);
  text("Raw measurement:", 10, yOffset + 30);
  
  // draw threshold
  stroke(255, 200, 0);
  strokeWeight(1);
  line(0, -rawThreshold + yOffset + 300, width/2, -rawThreshold + yOffset + 300);
  
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
      
      currValue = gdata[4];
}
