import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 8;
int numPixel = numRow * numCol;

float[] gdata = new float[numPixel];
ColorMap cm = new ColorMap();
int fpsCounter = 0;
String fpsIndicator = "";
long lastTime = -1;

// for rolling graph
int current;
float inByte;
int[] yValues;
int w;


void setup() {
  size(600, 600);
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  background(255);
  lastTime = millis();
  
  // for rolling graph
  w = width-10;
  strokeWeight(3);
  yValues = new int[w];
  smooth();
}

void draw() {
  
  
  Client thisClient = myServer.available();

      if (thisClient != null) {
        
        calculateFPS();
        
        String whatClientSaid = thisClient.readString();
        if (whatClientSaid != null) {
          processData(whatClientSaid);
        } 
      }
      
      background(255);
      
      float size = height/numRow;
      
      float colorVal = gdata[0];
      int[] rgb = cm.getColor((float) ((colorVal)/255.0));
      fill(rgb[0], rgb[1], rgb[2]);
      noStroke();
      rect(0,0, size-3, size-3);
      
      current = (int) (255 - gdata[0]);
      
      // show FPS
      fill(0);
      textSize(20);
      text("FPS: "+fpsIndicator, width - 100, 20);
      
      // for rolling graph
      for(int i = 1; i < w; i++) {
        yValues[i-1] = yValues[i];
      }
      
      yValues[w-1] = current;
      
      stroke(255, 200, 0);
      line(w, current, width, current);
      strokeWeight(1);
      line(0, current, width, current);
      strokeWeight(3);
      
      for(int i=1; i<w; i++) {
        stroke(0);
        point(i, yValues[i]);
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
      }
}
