import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 8;
int numPixel = numRow * numCol;

float[] gdata = new float[numPixel];
float currValue = 0;
float currDirivative = 0;

// for thresholds
int dirivativeThreshold = 10;

// Image display
PImage img_closed;
PImage img_opened;

//

void setup() {
  size(700, 700);
  myServer = new Server(this, 2337);
  background(237, 127, 56);
  img_closed = loadImage("refrigerator_closed.jpg");
  img_opened = loadImage("refrigerator_opened.jpg");
}

void draw() {
  
  Client thisClient = myServer.available();

      if (thisClient != null) {
        
        String whatClientSaid = thisClient.readString();
        if (whatClientSaid != null) {
          processData(whatClientSaid);
        } 
      }
      
      // dirivative detection
  if (currValue < dirivativeThreshold) {
      image(img_closed, 0, 0, 700, 700);
  }
  
  if (abs(currDirivative) > dirivativeThreshold ){
    if (currValue > dirivativeThreshold) {
      image(img_opened, 0, 0, 700, 700);
    } else {
      image(img_closed, 0, 0, 700, 700);
    }
  }
}


void processData(String resultString){
  String[] data = split(resultString, " ");
  
      if(data.length != numPixel) return;
      
      for(int i = 0; i < data.length; i++){
        gdata[i] = Float.parseFloat(data[i]);
      }
      
      currDirivative = gdata[4] - currValue;
      currValue = gdata[4];
}
