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



void setup() {
  size(600, 600);
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  background(255);
  lastTime = millis();
  
  table = new Table();
  for(int i = 0; i < 8; i++){
    table.addColumn("position_" + i);
  }
}

void draw() {
  background(255);
  
  Client thisClient = myServer.available();

      if (thisClient != null) {
        
        calculateFPS();
        
        String whatClientSaid = thisClient.readString();
        if (whatClientSaid != null) {
          processData(whatClientSaid);
        } 
      }
      
      float size = height/numRow;
      
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
      text("FPS: "+fpsIndicator, 20, 20);
   
      
      for(int i = 0; i < 8; i++){
        measurementsDraw[i] = map(gdata[i], 4096, 0, 0, height-20);
      }
      
      for(int i = 1; i < 8; i++){
        stroke(0);
        strokeWeight(5);
        line(i*60 + 100, measurementsDraw[i], (i-1)*60 + 100, measurementsDraw[i-1]);
      }
      
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
