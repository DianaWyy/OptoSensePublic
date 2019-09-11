import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 1;
int numPixel = numRow * numCol;

float[] gdata = new float[numPixel];
ColorMap cm = new ColorMap();
int fpsCounter = 0;
String fpsIndicator = "";
long lastTime = -1;
float maxV = 4095;

// for saving measurements
Table table;
float measurements [] = new float [8];
float measurementsDraw[] = new float [8];

// for liquid detection
float minSlope = Float.MAX_VALUE;

// update cup
String stateStr = "Nothing";

void setup() {
  fullScreen();
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  
  //white background
  background(255);
  lastTime = millis();
  
  table = new Table();
  for(int i = 0; i < 8; i++){
    table.addColumn("position_" + i);
  }
}

void draw() {
  background(255);
  
  // grid lines
  stroke(0);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  
  Client thisClient = myServer.available();

      if (thisClient != null) {
        
        calculateFPS();
        
        String whatClientSaid = thisClient.readString();
        if (whatClientSaid != null) {
          processData(whatClientSaid);
        } 
      }
      
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
      
      // show FPS
      fill(0);
      textSize(20);
      text("FPS: "+fpsIndicator, 20, height/2 + 30);
   
      
      for(int i = 0; i < 8; i++){
        measurementsDraw[i] = map(gdata[i], 4096, 0, 0, height-20);
      }
      
      minSlope = Float.MAX_VALUE;
      
      for(int i = 1; i < 8; i++){
        stroke(0);
        strokeWeight(5);
        line(i*60 + 100, measurementsDraw[i], (i-1)*60 + 100, measurementsDraw[i-1]);
        
        float slope = gdata[i] - gdata[i-1];
        
        if(slope < minSlope){
          minSlope = slope;
        }
      }
      
      textSize(20);
      text("Min Slope: "+minSlope, width/2 - 200, height/2 + 30);
      
      
      // liquid percentage
      textSize(25);
      text("0%", width/2 + 250, 500);
      textSize(40);
      text(stateStr + " Detected", width/2 + 275, height/2 + 200);
      // cup
      fill(255); //white
      stroke(0);
      strokeWeight(3);
      rect(width/2 + 300, 100, 325, 400);
      // handle
      fill(255);
      strokeWeight(3);
      arc(width/2 + 628, 300, 200, 250, PI+HALF_PI, TWO_PI+HALF_PI, OPEN);
      arc(width/2 + 628, 299, 150, 180, PI+HALF_PI, TWO_PI+HALF_PI, OPEN);
      
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
  
      if(data.length != numPixel) return;
      
      for(int i = 0; i < data.length; i++){
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
  
  gdata[7] = tdata[4];
   gdata[6] = tdata[5];
    gdata[5] = tdata[6];
     gdata[4] = tdata[7];
  gdata[3] = tdata[0];
   gdata[2] = tdata[1];
    gdata[1] = tdata[2];
     gdata[0] = tdata[3];
}
  
void keyPressed(){
  
  if (key == 's'){
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
  
}
