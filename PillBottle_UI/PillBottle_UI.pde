import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 1;
int numPixel = numRow * numCol;

// data
float[] gdata = new float[numPixel];
float currDerivative = 0;
float currValue = 0;

// color for pixel
ColorMap cm = new ColorMap();

// counters
long operationTime = 0;
int counter = 0;
  
// for rolling graph
float inByte;
int[] yValues;
int[] yDerivatives;
int w;

// for thresholds
int rawThreshold = 35;

// for saving measurements
Table table;
float measurements [] = new float [8];

// Image initialize
PImage img_closed;
PImage img_opened;

// show tick
boolean showTick = false;


void setup() {
  // screen size
  fullScreen();
  
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  
  // white background
  background(255);
  
  // start time count
  operationTime = millis();
  
  // image
  img_closed = loadImage("bottleClose.png");
  img_opened = loadImage("bottleOpen.png");
  
  // for rolling graph
  w = width/2 - 10;
  strokeWeight(3);
  yValues = new int[w];
  yDerivatives = new int[w];
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
      
  // white background
  background(255);
  
  // draw grid lines
  stroke(0);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  
  // 0D pixel
  int[] rgb = cm.getColor((float) ((currValue)/4096.0));
  fill(rgb[0], rgb[1], rgb[2]);
  noStroke();
  rect(370, 200, 100, 100);
  
  // for rolling raw measurements
  float yOffset = height/2 + 50;
  int currValueDraw = (int) (4096 - currValue);
  
  currValueDraw = (int)map(currValueDraw, 0, 4096, 0, 255);
  
  // moving rolling buffer
  for(int i = 1; i < w; i++) {
        yValues[i-1] = yValues[i];
  }
  yValues[w-1] = currValueDraw;
  
  // detect lid open/close
  if (currValueDraw > (255 - rawThreshold)) {
    image(img_closed, width/2 + 330, 75, 169, 397);
    textSize(60);
    fill(0);
    text("Lid", 1145, 785);
    fill(255,0,0);
    text("Close", 1250, 785);
  }else {
    image(img_opened, width/2 + 330, 75, 169, 398.5);
    textSize(60);
    fill(0);
    text("Lid", 1145, 785);
    fill(50,205,50);
    text("Open", 1250, 785);
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
  
  // show raw measurement
  fill(0);
  textSize(35);
  text("Raw measurement:", 10, yOffset - 13);
  
  // draw threshold
  stroke(255, 200, 0);
  strokeWeight(1);
  line(0, 3 * (-rawThreshold) + yOffset + 255, width/2, 3 * (-rawThreshold) + yOffset + 255);
}


void calculateSeconds() {
  long currentTime = millis();
  if(currentTime - operationTime > 100){
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
  
  // save data
  } else if (key == 's'){
    TableRow newRow = table.addRow();
    for(int i = 0; i < 8; i++){
       newRow.setFloat("position_"+i, measurements[i]); 
    }
    saveTable(table, "data/measurements.csv");
    println("measurements saved into data/measurements.csv");
  
  // reset
  } else if (key == 'r'){
    reset();
    println("Reset");
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

// reset
void reset() {
  for(int i = 0; i < 8; i++){
    measurements[i] = 0;
  }
  
  operationTime = millis();
  
  // for rolling graph
  w = width/2 - 10;
  strokeWeight(3);
  yValues = new int[w];
  yDerivatives = new int[w];
  smooth();
  // tick
  showTick = false;
  //counter
  counter = 0;
  //table
  table = new Table();
  for(int i = 0; i < 8; i++){
    table.addColumn("position_" + i);
  }
}
