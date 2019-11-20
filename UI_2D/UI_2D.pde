import processing.net.*;

Server myServer;

// pixels
int numRow = 8;
int numCol = 8;
int numTouchPoints = 5;
int numPixel = numRow * numCol;
int numAllData = numPixel + numTouchPoints*2;

int actualNumPixel = 64;

// data storage
float[] gdata = new float[numAllData];
float[][] touchPoints = new float[numTouchPoints][2];
float[][] touchPointsArray = new float[5][2];

// color
ColorMap cm = new ColorMap();

// for frames per second
int fpsCounter = 0;
String fpsIndicator = "";
int frameCounter = 0;

// for time count
long lastTime = -1;

// maximum value
float maxV = 256.0;

// for saving measurements
Table table;
float background = maxV;

// simulation mode
boolean simulation = true;


void setup() {
  fullScreen(); // screen size
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  background(255); // white background
  lastTime = millis(); // start time count
  
  //Simulation
  if(simulation) {
    frameRate(60);
    table = loadTable("measurements.csv", "header");  
  }
  else {
    table = new Table();
    for(int i = 0; i < numAllData; i++){
      table.addColumn("position_" + i);
    }
  }
}

void draw() {
  background(255); // white
  
  // simulation
  if(simulation) {
    TableRow row = table.getRow(frameCounter);
    for(int i = 0; i < numAllData; i++){
      gdata[i] = row.getFloat("position_" + i);
    }
  }
  else {
    Client thisClient = myServer.available();
    if (thisClient != null) {
      
      calculateFPS(); // calculate fps
      
      String whatClientSaid = thisClient.readString();
      if (whatClientSaid != null) {
        processData(whatClientSaid);
      } 
    }
    // store data
    TableRow newRow = table.addRow();
    for(int i = 0; i < numAllData; i++){
       newRow.setFloat("position_"+i, gdata[i]); 
    }
  }
  // color pixels
  float size = width/2/numRow;
  for (int j = 0; j < numRow; j++){
    for(int i = 0; i < numCol; i++){
      float measurement = gdata[(numCol - 1 - i)*numRow + j];
      float colorVal = measurement;
      float remap = (background-colorVal)/background;
      if(remap < 0)
        remap = 0;
      int[] rgb = cm.getColor(remap);
      fill(rgb[0], rgb[1], rgb[2]);
      noStroke();
      rect(i*size, 100+j*size, size-3, size-3);
      //break; //show only the first row (since we only have one diode)
    }
    //break;
  }
  // load touch points data
  for(int i = 0; i < numTouchPoints; i++){ 
    touchPoints[i][0] = gdata[actualNumPixel + i * 2];
    touchPoints[i][1] = gdata[actualNumPixel + i * 2 + 1];
  }
  
  // load current touch point and 4 previous touch point values into array
  float maxValue = 224.0;
  int k = frameCounter % 5;
  for(int i = 4; i < 5; i++){ 
    if(touchPoints[i][0] < 255 && touchPoints[i][1] < 255 && touchPoints[i][0] > 0 && touchPoints[i][1] > 0 ) { 
      touchPointsArray[k][0] = touchPoints[i][0];
      touchPointsArray[k][1] = touchPoints[i][1];
    }
  }
  
  // draw circles for touch points
  for (int i = 0; i < touchPointsArray.length; i++) {
    fill(0, 0, 0, 100-i*15);
    noStroke();
    circle(15 + width/2 + (maxValue - touchPointsArray[k][1]) * (width/2) / maxValue, 85 + touchPointsArray[k][0] * (width/2) / maxValue, 30);
    k--;
    if (k < 0) {k+=5;}
  }
  
  // increment frame counter
  frameCounter++;
}

// calculate frames per second
void calculateFPS(){
  long currentTime = millis();
  if(currentTime - lastTime > 1000){
    lastTime = currentTime;
    fpsIndicator = "" + fpsCounter;
    fpsCounter = 0;
  }else{
    fpsCounter++;
  }
}

// process data
void processData(String resultString){
  String[] data = split(resultString, " ");

  if(data.length != numAllData) return;
  
  for(int i = 0; i < data.length; i++){
    gdata[i] = Float.parseFloat(data[i]);
  }
  reorg(gdata);
}

// reorganize data
void reorg(float[] gdata){
  
  float[] tdata = new float[8];
  for(int i = 0; i < 8; i++){
    tdata[i] = gdata[i];
  }
  
  gdata[7] = tdata[7];
  gdata[6] = tdata[6];
  gdata[5] = tdata[5];
  gdata[4] = tdata[4];
  gdata[3] = tdata[3];
  gdata[2] = tdata[2];
  gdata[1] = tdata[1];
  gdata[0] = tdata[0];
}
  
void keyPressed(){
  // save data
  if (key == 's'){
    //TableRow newRow = table.addRow();
    //for(int i = 0; i < 8; i++){
    //   newRow.setFloat("position_"+i, gdata[i]); 
    //   print(gdata[i]);
    //   print(' ');
    //}
    //println();
    saveTable(table, "data/measurements.csv");
    println("measurements saved into data/measurements.csv");
  }
  // print color value
  if (key == 'p'){
    for (int j = 0; j < numRow; j++){
      for(int i = 0; i < numCol; i++){
        float colorVal = gdata[(numCol - 1 - i)*numRow + j];
        print(colorVal);
        print(" ");
      }
    }
    println();
  }
  
  // calculate maximum and average data values
  if (key == 'b'){
    float avg = 0;
    float max = 0;
    for(int i = 0; i < actualNumPixel; i++){
      avg += gdata[i];
      if(max < gdata[i])
        max = gdata[i];
    }
    avg /= actualNumPixel;
    println(max);
    background = max;
  }
}
