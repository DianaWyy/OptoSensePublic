import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 8;
int numTouchPoints = 5;
int numPixel = numRow * numCol;
int numAllData = numPixel + numTouchPoints*2;

int actualNumPixel = 64;

float[] gdata = new float[numAllData];
ColorMap cm = new ColorMap();
int fpsCounter = 0;
String fpsIndicator = "";
long lastTime = -1;
float maxV = 256.0;

// for saving measurements
Table table;
float background = maxV;

boolean simulation = false;

int frameCounter = 0;

float[][] touchPoints = new float[numTouchPoints][2];
float[][] touchPointsArray = new float[5][2];

int index;
String[] strs = {"Swipe Up", "Swipe Down", "Swipe Left", "Swipe Right"};
PImage arrowUp;
PImage arrowDown;
PImage arrowLeft;
PImage arrowRight;
PImage[] imgs = new PImage[4];

void setup() {
  fullScreen();
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  background(255);
  lastTime = millis();
  
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
  
  if(simulation) {
    TableRow row = table.getRow(frameCounter);
    for(int i = 0; i < numAllData; i++){
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
    TableRow newRow = table.addRow();
    for(int i = 0; i < numAllData; i++){
       newRow.setFloat("position_"+i, gdata[i]); 
    }
  }
  float size = width/2/numRow;
    for (int j = 0; j < numRow; j++){
    for(int i = 0; i < numCol; i++){
        float measurement = gdata[(numCol - 1 - i)*numRow + j];
        //float colorVal = map(measurement, 4096, 0, 0, height-20);
        float colorVal = measurement;
        //println(j + " " + i + " " + colorVal);
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
  
  index = 1;
  fill(0);
  textSize(60);
  text(strs[index], width/2 + 280, 175);
  
  if (index < 2) {image(imgs[index], width/2 + 325, 300, 231, 550);}
    else {image(imgs[index], width/2 + 200, 400, 550, 231);}
}

void calculateFPS(){
  // calculate frames per second
  long currentTime = millis();
  if(currentTime - lastTime > 1000){
    lastTime = currentTime;
    fpsIndicator = "" + fpsCounter;
    fpsCounter = 0;
  }else{
    fpsCounter++;
  }
}

void processData(String resultString){
  String[] data = split(resultString, " ");
  
      if(data.length != numAllData) return;
      
      for(int i = 0; i < data.length; i++){
        //println(i + " " + data[i]);
        gdata[i] = Float.parseFloat(data[i]);
        //println(gdata[i]);
      }
      reorg(gdata);
      
}
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