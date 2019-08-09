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

// for thresholds
int brightnessThreshold = 255/2;
int timeThreshold = 1000; // 1s

// for detection results
String stateString = "";

void setup() {
  size(700, 700);
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
      
      // light brightness detection
      
      if (gdata[0] > brightnessThreshold){
        stateString = "Light On";
      }else{
        stateString = "";
      }
      
      background(255);
      
      float size = height/numRow;
      
      float colorVal = gdata[0];
      int[] rgb = cm.getColor((float) ((colorVal)/255.0));
      fill(rgb[0], rgb[1], rgb[2]);
      noStroke();
      rect(0,0, size-3, size-3);
      
      
      
      // show FPS
      fill(0);
      textSize(20);
      textAlign(LEFT);
      text("FPS: "+fpsIndicator, width - 300, 20);
      text("Brightness Threshold: "+brightnessThreshold, width - 300, 40);
      text("Time Hysteresis: "+timeThreshold, width - 300, 60);
      
      // for rolling graph
      float yOffset = 100;
      current = (int) (255 - gdata[0] + yOffset);
      
      for(int i = 1; i < w; i++) {
        yValues[i-1] = yValues[i];
      }
      
      yValues[w-1] = current;
      
      stroke(255, 200, 0);
      line(w, current, width, current);
      strokeWeight(1);
      line(0, 255-brightnessThreshold+yOffset, width, 255-brightnessThreshold+yOffset);
      strokeWeight(3);
      
      for(int i=1; i<w; i++) {
        stroke(0);
        point(i, yValues[i]);
      }
      
      // show detection result
      textAlign(CENTER);
      textSize(80);
      text(stateString, width/2, height - 200);
}

void keyPressed(){
  if(key == CODED){
   if(keyCode == UP){
     brightnessThreshold += 5;
   }else if (keyCode == DOWN){
     brightnessThreshold -= 5;
   }
   
   if(keyCode == LEFT){
     timeThreshold -= 100;
   }else if (keyCode == RIGHT){
      timeThreshold += 100;
   }
   
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
