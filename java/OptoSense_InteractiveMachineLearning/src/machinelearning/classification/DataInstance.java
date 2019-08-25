package machinelearning.classification;

import java.io.Serializable;
import java.util.Date;

/* A recorded instance of the training data. */
public class DataInstance implements Serializable {
	private static final long serialVersionUID = 7022847039018030761L;
	public String label;
	public Date date;
	public float[] measurements;
}
