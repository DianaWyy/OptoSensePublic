package machinelearning.classification;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import weka.classifiers.functions.SMO;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Normalize;

public class OptoSenseClassifier implements Serializable{

	private static final long serialVersionUID = 1L;
	OptoSenseFeatureCalc featureCalc = null;
    SMO classifier = null;
    Attribute classattr;
    Filter filter = new Normalize();

    public OptoSenseClassifier() {
    	
    }

    public void train(Map<String, List<DataInstance>> instances) {
    	
    	// generate instances based on the collected a hashmap of DataInstances  	
    	// pass on labels
    	featureCalc = new OptoSenseFeatureCalc(new ArrayList<>(instances.keySet()));
    	
    	// pass on data
    	 List<DataInstance> trainingData = new ArrayList<>();
         for(List<DataInstance> v : instances.values()) {
             trainingData.addAll(v);
         }
         
         // prepare Classifier and Training dataset
     
         Instances dataset = featureCalc.calcFeatures(trainingData);
         
    	// call build classifier
         classifier = new SMO();
         
         try {
        	/* 
			classifier.setOptions(weka.core.Utils.splitOptions("-C 1.0 -L 0.0010 "
			         + "-P 1.0E-12 -N 0 -V -1 -W 1 "
			         + "-K \"weka.classifiers.functions.supportVector.RBFKernel "
			         + "-C 0 -G 0.3\""));
			         */
			         
        	classifier.setOptions(weka.core.Utils.splitOptions("-C 1.0 -L 0.0010 "
			         + "-P 1.0E-12 -N 0 -V -1 -W 1 "
			         + "-K \"weka.classifiers.functions.supportVector.PolyKernel "
			         + "-C 0 -E 1.0\""));
			
			classifier.buildClassifier(dataset);
			this.classattr = dataset.classAttribute();
			
			System.out.println("Training done!");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
    }

    public String classify(DataInstance data) {
        if(classifier == null || classattr == null) {
            return "Unknown";
        }
        
        Instance instance = featureCalc.calcFeatures(data);
        
        try {
            int result = (int) classifier.classifyInstance(instance);
            return classattr.value((int)result);
        } catch(Exception e) {
            e.printStackTrace();
            return "Error";
        }
    }
    
}
