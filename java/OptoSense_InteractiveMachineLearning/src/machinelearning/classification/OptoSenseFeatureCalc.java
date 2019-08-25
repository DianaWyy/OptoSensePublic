package machinelearning.classification;

import java.io.Serializable;
import java.util.List;

// extend abstract class to add more features if needed
public class OptoSenseFeatureCalc extends FeatureCalcBase implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8667392485783922740L;

	public OptoSenseFeatureCalc(List<String> classLabels, int nFeatures) {
		super(classLabels, nFeatures);
	}
	
	private static void addRawMeasurements(String prefix, float[] v, ValueAdder out) {
		for(int i=0; i<v.length; i++) {
			out.add(prefix + i, v[i]);
		}
	}

	@Override
	protected void calcFeatures(DataInstance data, ValueAdder out) {
		// if filter and derive more features, add them here
		addRawMeasurements("measurements", data.measurements, out);
	}
}
