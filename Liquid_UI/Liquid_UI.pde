import processing.net.*;
import papaya.*;

Server myServer;

int numRow = 8;
int numCol = 1;
int numPixel = numRow * numCol;

// data
float[] gdata = new float[numPixel];

// color
ColorMap cm = new ColorMap();

// frame per second counter
int fpsCounter = 0;
String fpsIndicator = "";
int fps = 0;

// count program running time
long lastTime = -1;

// for mapping data values from 255 to maxV
float maxV = 4095;
float maxPeriod = 100;

// for saving measurements
Table table;
float measurements [] = new float [8];
float measurementsDraw[] = new float [8];
float prevMeasurements[] = new float [8];
float gradient[] = new float [8];

// for liquid identification 
float thresholds [] = {0.1, 0.5, 0.7};
String liquids [] = {"Tea", "Juice", "Coffee"};
String  display = "";
float level = 0;
int frameCounter = 0;

// liquid in cup
float liquid_cup = 0;

// for liquid detection
float minSlope = Float.MAX_VALUE;

// update cup
String stateStr = "Nothing";

// simulation mode
boolean simulation = true;


void setup() {
  fullScreen();
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  
  //white background
  background(255);
  
  // start time count
  lastTime = millis();
  
  //Simulation
  if(simulation) {
    frameRate(5);
    table = loadTable("measurements_dr_pepper_01.csv", "header");  
  }
  else {
    table = new Table();
    for(int i = 0; i < 8; i++){
      table.addColumn("position_" + i);
    }
  }
}

void draw() {
  background(255);
  
  // grid lines
  stroke(0);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  
  // simulation
  if(simulation) {
    TableRow row = table.getRow(frameCounter);
    for(int i = 0; i < 8; i++){
      gdata[i] = row.getFloat("position_" + i);
    }
  }
  else {
    Client thisClient = myServer.available();
    if (thisClient != null) {
      calculateFPS();
      
      String whatClientSaid = thisClient.readString();
      if (whatClientSaid != null) {
        processData(whatClientSaid);
      } 
    }
  }
  
  // draw pixels
  float size = (height/2)/numRow;
  for (int j = 0; j < numRow; j++){
    for(int i = 0; i < numCol; i++){
      float colorVal = gdata[i*numRow + j];
      int[] rgb = cm.getColor((float) ((maxV-colorVal)/maxV));
      fill(rgb[0], rgb[1], rgb[2]);
      noStroke();
      rect(i*size, j*size, size-3, size-3);
      //break; //show only the first row (since we only have one diode)
    }
    //break;
  }
  
  // load measurements
  for(int i = 0; i < 8; i++){
   measurements[i] = gdata[i];
   measurementsDraw[i] = map(gdata[i], 4096, 0, 0, height-20);
  }
  
  minSlope = Float.MAX_VALUE;
  // draw bar chart
  for(int i = 1; i < 8; i++){
    stroke(255);
    strokeWeight(5);
    fill(0);
    rect(i*60 + 100, measurementsDraw[i] + height/2, -60, measurementsDraw[i-1] - measurementsDraw[i] + height/2);
    
    float slope = gdata[i] - gdata[i-1];
    
    if(slope < minSlope){
      minSlope = slope;
    }
  }
  
  //Liquid detection algorithm
  if(fpsCounter > 0 || simulation){
    float difference = computeDistance(prevMeasurements, measurements, 8); // Euclidean distance between frames
    if(difference > 0) { //
      frameCounter++; //count valid frames
      
      if(!simulation) {
        TableRow newRow = table.addRow();
        for(int i = 0; i < 8; i++){
           newRow.setFloat("position_"+i, measurements[i]); 
        }
      }
      
      // simulation mode data display
      float maximum = -1;
      float secondMaximum = -1;
      int indexMaximum = -1;
      int indexSecond = -1;
      for(int i = 0; i < numRow - 1; i++) {
        gradient[i] = abs(measurements[i + 1] - measurements[i]);
        if(gradient[i] > maximum){
          secondMaximum = maximum;
          indexSecond = indexMaximum;
          maximum = gradient[i];
          indexMaximum = i;
        } 
        else if(gradient[i] > secondMaximum) {
          secondMaximum = gradient[i];
          indexSecond = i;
        }
      }
      level = indexMaximum + 1; //the higher pixel of maximum gradient 
      int indexBefore = indexMaximum;
      int indexAfter = indexSecond;
      if(indexBefore > indexAfter) {
        indexBefore = indexSecond;
        indexAfter = indexMaximum;
      }
      float beforeAvg = 0;
      float afterAvg = 0;
      int count = 0;
      for(int i = 0; i < indexBefore + 1; i++) {
        beforeAvg += measurements[i];
        count++;
      }
      beforeAvg /= count;
      count = 0;
      for(int i = indexAfter + 1; i < numRow; i++) {
        afterAvg += measurements[i];
        count++;
      }
      afterAvg /= count;
      float activation = abs(afterAvg - beforeAvg) / beforeAvg;
      int index = -1;
      String liquid = "";
      for(int i = 0; i < thresholds.length; i++){
        if(activation > thresholds[i]){
          liquid = liquids[i];
          stateStr = liquid;
          index = i;
        }
      }
      println(activation);
      if(index > -1 && level < 8) {//Has liquid
        // show how much and what kind of liquid detected
        String levelVolume = (int)(8-level) * 100 + "ml";
        display = liquid + " Level: " + levelVolume;
        
        // show liquid level beside pixels
        noStroke();
        rect(size, level*size, size-3, 3);
        fill(0);
        textSize(25);
        text("Liquid Level", size * 2 + 10, level * size + 10);
      }
      else
        display = "No liquid detected";
    }
  }
  // show liquid dection
  textSize(25);
  text(display, width/2 + 20, 40);
  textSize(40);
  text(stateStr + " Detected", width/2 + 275, height/2 + 270);

  // draw cup
  fill(255); //white
  stroke(0);
  strokeWeight(3);
  rect(width/2 + 300, 100, 325, 400);
  // draw cup handle
  fill(255);
  strokeWeight(3);
  arc(width/2 + 628, 300, 200, 250, PI+HALF_PI, TWO_PI+HALF_PI, OPEN);
  arc(width/2 + 628, 299, 150, 180, PI+HALF_PI, TWO_PI+HALF_PI, OPEN);
  
  // display liquid level
  if (stateStr == "Coffee") {
    fill(139,69,19);
  } else if (stateStr == "Tea") {
    fill(85,107,47);
  } else {
    fill(255,165,0);
  }
  // draw liquid in cup
  stroke(0);
  strokeWeight(3);
  liquid_cup = 400 - level * (400/8);
  rect(width/2 + 300, 500, 325, -liquid_cup); 
}

// calculate frames per second
void calculateFPS(){
  long currentTime = millis();
  if(currentTime - lastTime > 1000){
    lastTime = currentTime;
    fps = fpsCounter;
    fpsIndicator = "" + fpsCounter;
    fpsCounter = 0;
  }else{
    fpsCounter++;
  }
}

// load data
void processData(String resultString){
  String[] data = split(resultString, " ");

  if(data.length != numPixel) return;
  
  for(int i = 0; i < data.length; i++){
    gdata[i] = Float.parseFloat(data[i]);
    //println(gdata[i]);
  }
  reorg(gdata);
}

// reorganize data
void reorg(float[] gdata){
  
  float[] tdata = new float[8];
  for(int i = 0; i < 8; i++){
    tdata[i] = gdata[i];
  }
  
  gdata[7] = tdata[4];
  gdata[6] = tdata[5];
  gdata[5] = tdata[6];
  gdata[4] = tdata[7];
  gdata[3] = tdata[0];
  gdata[2] = tdata[1];
  gdata[1] = tdata[2];
  gdata[0] = tdata[3];
}
  
// key pressed functions 
void keyPressed(){
  // store data
  if (!simulation && key == 's'){
    TableRow newRow = table.addRow();
    for(int i = 0; i < 8; i++){
       newRow.setFloat("position_"+i, gdata[i]); 
       print(gdata[i]);
       print(' ');
    }
    println();
    saveTable(table, "data/measurements.csv");
    println("measurements saved into data/measurements.csv");
  }
  // reset
  if (key == 'r'){
    reset();
    println("Reset");
  }
}

// compute distance
float computeDistance(float[] inputPrev, float[] inputCur, int len) {
  float[][] data = new float[2][len];
  for(int i = 0; i < len; i++){
     data[0][i] = inputPrev[i];
     data[1][i] = inputCur[i];
  }
  float[][] distance = Distance.euclidean(data); 
  return distance[0][1];
}

// reset
void reset() {
  for(int i = 0; i < 8; i++){
    measurements[i] = 0;
    measurementsDraw[i] = 0;
    prevMeasurements[i] = 0;
    gradient[i] = 0;
  }
  display = "";
  level = 0;
  frameCounter = 0;
}
