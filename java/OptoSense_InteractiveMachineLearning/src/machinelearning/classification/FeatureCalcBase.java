package machinelearning.classification;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

public abstract class FeatureCalcBase implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3L;

	protected interface ValueAdder {
		void add(String name, double value);
	}

	Instances dataset;	
	List<String> classLabels;
	
	int nfeatures = 3; // TODO need to be the same length with curMeasurements in the main class
	boolean isFirstInstance = true;

	public FeatureCalcBase(List<String> classLabels) {
		this.classLabels = classLabels;
	}

	protected abstract void calcFeatures(DataInstance data, ValueAdder out);

	private Instance instanceFromArray(double[] valueArray, String label) {
		Instance instance = new DenseInstance(1.0, valueArray);

		instance.setDataset(dataset);
		if(label != null) {
			instance.setClassValue(label);
		} else {
			instance.setClassMissing();
		}

		return instance;
	}

	private Instance calcFirstInstance(DataInstance data) {
		final ArrayList<Attribute> attrs = new ArrayList<>();
		final ArrayList<Double> values = new ArrayList<>();
		
		
		for(int i = 0; i < nfeatures; i++){
			attrs.add(new Attribute("bin"+i, i));
			values.add((double) data.measurements[i]);
		}

		/* Build our dataset (instance header) */
		attrs.add(new Attribute("classlabel", classLabels, nfeatures));
		dataset = new Instances("dataset", attrs, 0);
		dataset.setClassIndex(nfeatures);
		
	
		
		/* Build the output instance */
		double[] valueArray = new double[nfeatures+1];
		for(int i=0; i<nfeatures; i++) {
			valueArray[i] = values.get(i);
		}
		
		return instanceFromArray(valueArray, data.label);
		
	}

	private Instance calcOtherInstance(DataInstance data) {
		final double[] valueArray = new double[nfeatures+1];

		/* Calculate features now that the number of features is known */
		for(int i = 0; i < nfeatures; i++){
			valueArray[i] = data.measurements[i];
		}
		
		return instanceFromArray(valueArray, data.label);
	}

	public Instance calcFeatures(DataInstance data) {
		if(isFirstInstance) {
			isFirstInstance = false;
			return calcFirstInstance(data);
			
		} else {
			return calcOtherInstance(data);
		}
	}

	public Instances calcFeatures(Collection<DataInstance> dataCollection) {
		Instances res = null;
		for(DataInstance data : dataCollection) {
			Instance inst = calcFeatures(data);
			
			if(res == null) {
				res = new Instances(dataset, dataCollection.size());
			}
			res.add(inst);
		}
		return res;
	}
}
