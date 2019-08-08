import processing.net.*;

Server myServer;

int numRow = 8;
int numCol = 8;
int numPixel = numRow * numCol;

float[] gdata = new float[numPixel];

void setup() {
  size(200, 200);
  // Starts a myServer on port 2337
  myServer = new Server(this, 2337); 
  background(255);
}

void draw() {
  background(255);
  
  Client thisClient = myServer.available();
     
      if (thisClient != null) {
        String whatClientSaid = thisClient.readString();
        if (whatClientSaid != null) {
          processData(whatClientSaid);
        } 
      }
      
      float size = 20;
      
      for(int i = 0; i < numCol; i++){
        for (int j = 0; j < numRow; j++){
          float colorVal = gdata[i*numRow + j];
          fill(colorVal);
          rect(i*size, j*size, size-3, size-3);
          
        }
      }
  
}

void processData(String resultString){
  String[] data = split(resultString, " ");
  
      if(data.length != numPixel) return;
      
      for(int i = 0; i < data.length; i++){
        gdata[i] = Float.parseFloat(data[i]);
      }
}
