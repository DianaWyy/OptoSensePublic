/* Yang Zhang
 * yang.zhang@cs.cmu.edu
 * 08/2019
 * */

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import machinelearning.classification.DataInstance;
import machinelearning.classification.OptoSenseClassifier;
import processing.core.PApplet;
import processing.net.Client;
import processing.net.Server;

public class GripClassification extends PApplet {
	
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
	
	
	// for display ML results
	String label;
	
	// for visualization and ML
	Float slopes[] = new Float[7]; // 7 slopes in total
	float curMeasurements[] = new float[8]; 


	// for machine learning
	String[] classNames = {"No Grip", "A", "B", "C", "D"};
	OptoSenseClassifier classifier;
	
	boolean demoMode = false;
	
	boolean isCaptureInstance = false;
	boolean verbose = true;
	
	int curTrainingClass = 0;
	
	
	Map<String, List<DataInstance>> trainingData = new HashMap<>();
	{for (String className : classNames){
		trainingData.put(className, new ArrayList<DataInstance>());
	}}
	
	DataInstance captureInstance (String label){
		DataInstance res = new DataInstance();
		res.date = new Date();
		res.label = label;
		res.measurements = curMeasurements.clone();
		return res;
	}
	
	public static void main(String[] args) {
		PApplet.main(new String[] { "--location=0,0", GripClassification.class.getName() });
	}
	
	public void settings(){
		size(1000,700);
	}
	
	public void setup(){
		frameRate(60);
		background(0);
		textAlign(LEFT, TOP);
		
		// Starts a myServer on port 2337
		myServer = new Server(this, 2337); 
		
		lastTime = millis();
	}
	
	public void draw(){
		
		
		Client thisClient = myServer.available();
		if (thisClient != null) {
	        
	        calculateFPS();
	        
	        String whatClientSaid = thisClient.readString();
	        if (whatClientSaid != null) {
	          processData(whatClientSaid);
	        } 
	        
	        
	        background(0);
	        
	        // data collection, classification based on draw clock
			   if(classifier != null){ 
				   // testing mode
				   label = classifier.classify(captureInstance(null));
				   printClassifiedObject(label);

			   }else{ 
				   // training mode
				   if(isCaptureInstance) {
						trainingData.get(classNames[curTrainingClass]).add(captureInstance(classNames[curTrainingClass]));
				   }
				   
				   printTrainingObject(); 
			   }
	        
	        
	    }else { // not draw anything if there is no new coming data
	    	return;
	    }
		
		
		float size = 88;
	      
	      for (int j = 0; j < numRow; j++){
	        for(int i = 0; i < numCol; i++){
	            float colorVal = gdata[i*numRow + j];
	            int[] rgb = cm.getColor((float) ((maxV-colorVal)/maxV));
	            fill(rgb[0], rgb[1], rgb[2]);
	            noStroke();
	            rect(i*size, j*size, size-3, size-3);
	        }
	      }
	      
	      float gdataDraw[] = new float [8];
	      
	      for(int i = 0; i < 8; i++){ // map 0-4095 to 255-0 for rendering
	    	  gdataDraw[i] = map(gdata[i], 4096, 0, 0, height/2);
	        }
	      
	      for(int i = 1; i < 8; i++){
	          stroke(255);
	          strokeWeight(5);
	          line(i*60 + 450, gdataDraw[i] + height/2, (i-1)*60 + 450, gdataDraw[i-1] + height/2);
	          
	          float slope = gdata[i] - gdata[i-1];
	          slopes[i-1] = slope; // calculate slopes
	       }
	      
	
	      for(int i = 0; i < curMeasurements.length; i++) {
	    	  curMeasurements[i] = gdata[i];
	      }
	      
				// titles
				fill(255);
				textSize(40);
				textAlign(LEFT, TOP);
				text("Grip Detection", 100, 10);
				
				textAlign(LEFT, CENTER);
				textSize(20);
			    text("Frame rate: " + fpsIndicator, 480,30);
			    
			    if(classifier == null){
			    	text("Mode: Training",720,30);
			    }else{
			    	text("Mode: Test",720,30);
			    }
			    
			    // for verbose mode
			    if(verbose){
			    	noStroke();
			    	
			    	textSize(12);
			    	String text = 
							"v: toggle this display\n" +
							"Up/Down: select ground truth\n" +	    	
							"space: toggle training instance capture\n" +
							"del: delete last training instance for this class\n" +
							"t: train classifier and switch to testing mode\n" +
			    	  		"t: return to training mode\n";
							
					text(text, 650, 250);
					
			    }
			    
			   
		}

	
	private void printClassifiedObject(String detectedLabel)
	{

		for(int i = 0; i < classNames.length; i++){

			String label = classNames[i];
			textSize(40);
			
			if(label.equals(detectedLabel))
				fill(0,255,0);
			else
				fill(255);
			text(label, 100,140+i*55);
		}
	}
	
	private void printTrainingObject(){

		for(int i = 0; i < classNames.length; i++){
			int count = trainingData.get(classNames[i]).size();
			String label = classNames[i];
			textSize(40);
			if(i == curTrainingClass)
				fill(0,255,0);
			else
				fill(255);
			text(label  + " (" + count + " instance" + ((count == 1) ? "" : "s") + ")", 100,140+i*55);
		}
	}
	
	private void calculateFPS(){
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
	private void processData(String resultString){
		  String[] data = split(resultString, " ");
		  
		      if(data.length != numPixel) return;
		      
		      for(int i = 0; i < data.length; i++){
		        gdata[i] = Float.parseFloat(data[i]);
		        //println(gdata[i]);
		      }
		      reorg(gdata);
		      
		}

	private void reorg(float[] gdata){
		  
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


	
	public void keyPressed(){

			if(key == CODED){
				
				if(keyCode == DOWN){
					curTrainingClass = (curTrainingClass + 1) % classNames.length;	
				}
				
				else if(keyCode == UP) {
					curTrainingClass = (curTrainingClass + classNames.length - 1) % classNames.length;
				}
				
			}else{
				switch(key){
				case (' '):
					isCaptureInstance = !isCaptureInstance;
					break;
				case('v'):
					verbose = !verbose;
					break;
				case('d'):
					demoMode = !demoMode;
				case(DELETE):
				case(BACKSPACE):
					if(classifier == null){
						// Remove last training instance
						List<DataInstance> trainingList = trainingData.get(classNames[curTrainingClass]);
						if(trainingList.size() > 0) {
							trainingList.remove(trainingList.size() - 1);
						}
					}
					break;
				
				case ('t'):
					if(classifier == null){ // train
						if(isCaptureInstance != true){
							println("Start training ...");
							classifier = new OptoSenseClassifier(curMeasurements.length);
							classifier.train(trainingData);
						}
						
					}else{
						classifier = null; // for retrain
					}
					break;
				case ('s'):
					String filename = "grip_file.ser"; 
				
			        // Serialization  
			        try
			        {    
			            //Saving of object in a file 
			            FileOutputStream file = new FileOutputStream(filename); 
			            ObjectOutputStream out = new ObjectOutputStream(file); 
			              
			            // Method for serialization of object 
			            out.writeObject(classifier); 
			              
			            out.close(); 
			            file.close(); 
			              
			            System.out.println("Object has been serialized"); 
			  
			        } 
			          
			        catch(IOException ex) 
			        { 
			            System.out.println(ex); 
			        } 
			        
					break;
				case('l'):
					classifier = null; 
				
					filename = "grip_file.ser"; 
				  
			        // Deserialization 
			        try
			        {    
			            // Reading the object from a file 
			            FileInputStream file = new FileInputStream(filename); 
			            ObjectInputStream in = new ObjectInputStream(file); 
			              
			            // Method for deserialization of object 
			            classifier = (OptoSenseClassifier)in.readObject(); 
			              
			            in.close(); 
			            file.close(); 
			              
			            System.out.println("Object has been deserialized "); 

			        } 
			          
			        catch(IOException ex) 
			        { 
			        	ex.printStackTrace();
			        } 
			          
			        catch(ClassNotFoundException ex) 
			        { 
			            System.out.println("ClassNotFoundException is caught"); 
			        } 
					break;
					
				default:
					break;
				}
			}
		
	}

	
}
