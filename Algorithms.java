import java.util.Arrays;
import java.util.Deque;

public class Algorithms {
     static final int INIT = -1;
     static final int MASK = -2;
     static final int WSHED = 0;
     static final int NUM_COL = 8;
     static final int NUM_ROW = 8;
     static final int MAX_TOUCHPOINTS = 6;
     static final int TAU = 20;
     static final int MAX_VAL = 65535;

     // regular array sorting
     public int[] sort_into_array(int[][] input) {
         int[] result = new int[NUM_ROW * NUM_COL];
         for (int i = 0; i < NUM_ROW; i++) {
            for (int j = 0; j < NUM_COL; j++) {
                result[i * NUM_COL + j] = input[i][j];
            }
         }
         Arrays.sort(result);
         return result;
     }

     // part of watershed algorithm
    public void labelling(Deque q, int i, int j, int ii, int jj, int curdist, int[][] lab, int[][] dist) {
        if (dist[ii][jj] < curdist && (lab[ii][jj] > 0 || lab[ii][jj] == WSHED)) {
            if (lab[ii][jj] > 0) {
                if (lab[i][j] == MASK || lab[i][j] == WSHED)
                    lab[i][j] = lab[ii][jj];
                else if (lab[i][j] != lab[ii][jj])
                    lab[i][j] = WSHED;
            } else if(lab[i][j] == MASK)
                lab[i][j] = WSHED;
        } else if(lab[ii][jj] == MASK && dist[ii][jj] == 0) {
            dist[ii][jj] = curdist + 1;
            int[] tmp = {ii, jj};
            q.addLast(tmp);
        }
    }

    // Main function of Vincent-Soille watershed algorithm described in Roerdink et al., Fundamenta Informaticae 2001
    public void watershed (int[][] input, int[][] lab, Deque q) {
        int[] FICTITIOUS = {-1, -1};
        int curlab = 0;
        int[][] dist = new int[NUM_ROW][NUM_COL];
        int[] hs = sort_into_array(input);
        int prev_h = -1;
        for (int n = 0; n < NUM_ROW * NUM_COL; n++) {
            int h = hs[n];
            if (prev_h == h)
                continue;
            else
                prev_h = h;
            for (int i = 0; i < NUM_ROW; i++) {
                for (int j = 0; j < NUM_COL; j++) {
                    if (input[i][j] == h){
                        lab[i][j] = MASK;
                        int flag = 0;
                        if (i > 0) {
                            int ii = i - 1;
                            if(lab[ii][j] > 0 || lab[ii][j] == WSHED)
                                flag = 1;
                        }
                        if (i < NUM_ROW - 1) {
                            int ii = i + 1;
                            if(lab[ii][j] > 0 || lab[ii][j] == WSHED)
                                flag = 1;
                        }
                        if (j > 0) {
                            int jj = j - 1;
                            if(lab[i][jj] > 0 || lab[i][jj] == WSHED)
                                flag = 1;
                        }
                        if (j < NUM_COL - 1) {
                            int jj = j + 1;
                            if(lab[i][jj] > 0 || lab[i][jj] == WSHED)
                                flag = 1;
                        }
                        if (flag == 1) {
                            dist[i][j] = 1;
                            int[] key = {i, j};
                            q.addLast(key);
                        }
                    }
                }
            }
            int curdist = 1;
            q.addLast(FICTITIOUS);
            while (!q.isEmpty()) {
                int[] p = (int[]) q.pop();
                if (p[0] == FICTITIOUS[0] && p[1] == FICTITIOUS[1]) {
                    if (q.isEmpty())
                        break;
                    else {
                        q.addLast(FICTITIOUS);
                        curdist += 1;
                        p = (int[]) q.pop();
                    }
                }
                int i = p[0];
                int j = p[1];

                if (i > 0) {
                    int ii = i - 1;
                    labelling(q, i, j, ii, j, curdist, lab, dist);
                }
                if (i < NUM_ROW - 1) {
                    int ii = i + 1;
                    labelling(q, i, j, ii, j, curdist, lab, dist);
                }
                if (j > 0) {
                    int jj = j - 1;
                    labelling(q, i, j, i, jj, curdist, lab, dist);
                }
                if (j < NUM_COL - 1) {
                    int jj = j + 1;
                    labelling(q, i, j, i, jj, curdist, lab, dist);
                }
            }
            for (int i = 0; i < NUM_ROW; i++) {
                for (int j = 0; j < NUM_COL; j++) {
                    if (input[i][j] == h) {
                        dist[i][j] = 0;
                        if (lab[i][j] == MASK) {
                            curlab = curlab + 1;
                            int[] tmp = {i, j};
                            q.addLast(tmp);
                            lab[i][j] = curlab;
                            while (!q.isEmpty()) {
                                int[] qq = (int[]) q.pop();
                                int ii = qq[0];
                                int jj = qq[1];
                                if (ii > 0) {
                                    int iii = ii - 1;
                                    if (lab[iii][jj] == MASK) {
                                        int[] tmp1 = {iii, jj};
                                        q.addLast(tmp1);
                                        lab[iii][jj] = curlab;
                                    }
                                }
                                if (ii < NUM_ROW - 1) {
                                    int iii = ii + 1;
                                    if (lab[iii][jj] == MASK) {
                                        int[] tmp1 = {iii, jj};
                                        q.addLast(tmp1);
                                        lab[iii][jj] = curlab;
                                    }
                                }
                                if (jj > 0) {
                                    int jjj = jj - 1;
                                    if (lab[ii][jjj] == MASK) {
                                        int[] tmp1 = {ii, jjj};
                                        q.addLast(tmp1);
                                        lab[ii][jjj] = curlab;
                                    }
                                }
                                if (jj < NUM_COL - 1) {
                                    int jjj = jj + 1;
                                    if (lab[ii][jjj] == MASK) {
                                        int[] tmp1 = {ii, jjj};
                                        q.addLast(tmp1);
                                        lab[ii][jjj] = curlab;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Extract centors with watershed and use weighted centroid for touch locations
    public void extract_centors(int[][] input, int[][] background, float[][] rst, int max_value, float threshold, Deque q) {
        int index = 0;
        int[][] input_reduced = new int[NUM_ROW][NUM_COL];
        for (int i = 0; i < NUM_ROW; i++) {
            for (int j = 0; j < NUM_COL; j++) {
                int reduced = input[i][j];
                int back = background[i][j];
                if ((float)reduced > (float)(back)*threshold)
                    input_reduced[i][j] = max_value;
                else
                    input_reduced[i][j] = reduced;
            }
        }
        float[] count = new float[MAX_TOUCHPOINTS];
        float[] count_pixel = new float[MAX_TOUCHPOINTS];
        float[] x_s = new float[MAX_TOUCHPOINTS];
        float[] y_s = new float[MAX_TOUCHPOINTS];
        int[][] label = new int[NUM_ROW][NUM_COL];

        watershed(input_reduced, label, q);
        for (int i = 0; i < NUM_ROW; i++) {
            for (int j = 0; j < NUM_COL; j++) {
                index = label[i][j];
                float signal = (float)(max_value - input_reduced[i][j]) / (float)max_value;
                signal = signal*signal;
                if (signal < 0)
                    signal = 0;
                if (index > 0) {
                    count[index] += signal;
                    x_s[index] += signal*(float)(i + 1);
                    y_s[index] += signal*(float)(j + 1);
                    count_pixel[index] += 1.0;
                }
            }
        }
    //    float dimension = (float)(NUM_ROW * NUM_COL);
    //    float mean = (float)addup / dimension;
    //    float level = mean * threshold / DIVISION;
    //    float level = 0.0; // greater than this level// greater than this level
        for (int i = 1; i < MAX_TOUCHPOINTS; i++) {
            float value = count[i] / count_pixel[i];
            if ( count[i] > 0) {
                float x = x_s[i] / count[i] - 1;
                float y = y_s[i] / count[i] - 1;
    //            rst[i][0] = y; // Reverse orders
    //            rst[i][1] = x; // Reverse orders
                rst[i][0] = x;
                rst[i][1] = y;
            }
        }
    }

    // inner class Point storing index, nearest touch point, and distance for each touch point
    private class Point {
         int index;
         int nearest;
         float distance;

         public Point(double[] data) {
             this.index = (int) data[0];
             this.nearest = (int) data[1];
             this.distance = (float) data[3];
         }

         public int compare_distance(double[] av, double[] bv) {
             Point a = new Point(av);
             Point b = new Point(bv);
             if (a.distance < b.distance) {
                 return -1;
             } else if (a.distance == b.distance) {
                 return 0;
             }
             return 1;
         }
    }

    // Extract nearest pairs, part of MDF algorithm
    public void pair(float[][] centors, float[][] new_centors, int[] pair_list, int[] pair_list_current, float[][] rst_centors, int count_paired, int count_prev, int count, float threshold) {
        double[][] data = {
            {0, -1, 10000.0},
            {1, -1, 10000.0},
            {2, -1, 10000.0},
            {3, -1, 10000.0},
            {4, -1, 10000.0},
            {5, -1, 10000.0}
        };
        Point[] nearest = new Point[data.length];
        for (int i = 0; i < data.length; i++) {
            nearest[i] = new Point(data[i]);
        }
        for (int i = 0; i < MAX_TOUCHPOINTS; i++) {// Produce a list of unparied previous touch with its closest unpaired current touch
            if (centors[i][0] != -1.0 || centors[i][1] != -1.0) {
                if (pair_list[i] == -1) {
                    for (int j = 1; j < MAX_TOUCHPOINTS; j++) {
                        if (pair_list_current[j] == -1){
                            float dis = (centors[i][0] - new_centors[j][0]) * (centors[i][0] - new_centors[j][0]) + (centors[i][1] - new_centors[j][1]) * (centors[i][1] - new_centors[j][1]);
                            if (nearest[i].distance > dis) {
                                nearest[i].distance = dis;
                                nearest[i].nearest = j;
                            }
                        }
                    }
                }
            }
        }
    //    for(int i = 0; i < MAX_TOUCHPOINTS; i += 1) {
    //        printf("%d, %d, %.2f \r\n", nearest[i].index, nearest[i].nearest, nearest[i].distance);
    //    }
        Arrays.sort(nearest);
    //    for(int i = 0; i < MAX_TOUCHPOINTS; i += 1) {
    //        printf("%d, %d, %.2f \r\n", nearest[i].index, nearest[i].nearest, nearest[i].distance);
    //    }
        for (int i = 0; i < MAX_TOUCHPOINTS; i++) {
            int current_pair = nearest[i].nearest;
            if (current_pair != -1){
                if (pair_list_current[current_pair] == -1 && nearest[i].distance < threshold) { // CURRENT touch is unpaired
                    pair_list_current[current_pair] = nearest[i].index;
                    pair_list[nearest[i].index] = current_pair;
                    rst_centors[nearest[i].index][0] = new_centors[current_pair][0];
                    rst_centors[nearest[i].index][1] = new_centors[current_pair][1];
                    count_paired += 1;

                    if (count_paired == count) { // all CURRENT touches are paired
    //                    free(nearest);
                        return;
                    } else if (count_paired == count_prev) { // all PREVIOUS touches are paired
                        for (int j = 1; j < MAX_TOUCHPOINTS; j++) {
                            if(pair_list_current[j] == -1) { // unpaired CURRENT touches
                                for (int k = 1; k < MAX_TOUCHPOINTS; k++) {
                                    if (rst_centors[k][0] == -1.0 && rst_centors[k][1] == -1.0) {
                                        rst_centors[k][0] = new_centors[j][0];
                                        rst_centors[k][1] = new_centors[j][1];
                                        break;
                                    }
                                }
                            }
                        }
    //                    free(nearest);
                        return;
                    } else{
    //                    free(nearest);
                        pair(centors, new_centors, pair_list, pair_list_current, rst_centors, count_paired, count_prev, count, threshold);
                    }
                }
            }
        }
    }

    // Tracking using minimum distance first (MDF) algorithm, described in Westerman et al., US Patent 7916126 B2
    public void track(float[][] centors, float[][] new_centors, float[][] rst, float threshold) {
        for (int i = 0; i < MAX_TOUCHPOINTS; i++) {
            rst[i][0] = -1;
            rst[i][1] = -1;
        }
        int[] pair_list = new int[MAX_TOUCHPOINTS]; // Stores paired PREVIOUS touches for the previous touch
        int[] pair_list_current = new int[MAX_TOUCHPOINTS]; // Stores paired PREVIOUS touches for the previous touch
        int count_paired = 0;
        int count_prev = 0;
        int count = 0;
        for (int i = 1; i < MAX_TOUCHPOINTS; i++)
            if(centors[i][0] != -1.0 || centors[i][1] != -1.0)
                count_prev += 1;
        if(count_prev == 0) {
            for (int i = 1; i < MAX_TOUCHPOINTS; i++) {
                rst[i][0] = new_centors[i][0];
                rst[i][1] = new_centors[i][1];
            }
            return;
        }
        for (int i = 1; i < MAX_TOUCHPOINTS; i++)
            if(new_centors[i][0] != -1.0 || new_centors[i][1] != -1.0)
                count += 1;
        if (count == 0)
            return;
        pair(centors, new_centors, pair_list, pair_list_current, rst, count_paired, count_prev, count, threshold);
    }

    // In-air swipe gesture detection using motion history image
    public void motion_history(int[][] input, int[][] background, int[][] MHI, int threshold, int m_adc_evt_counter) {
        int count = 0;
        for (int i = 0; i < NUM_ROW; i++) {
            for (int j = 0; j < NUM_COL; j++) {
                if (input[i][j] < background[i][j]/threshold){
                    if (MHI[i][j] == MAX_VAL)
                        MHI[i][j] = m_adc_evt_counter;
                }
                else if (MHI[i][j] < m_adc_evt_counter - TAU)
                    MHI[i][j] = 0;
    //            if(MHI[i][j] > 0 && MHI[i][j] < MAX_VAL)
    //                MHI[i][j] -= 1;
                if (MHI[i][j] == 0 || MHI[i][j] == MAX_VAL)
                    count += 1;
            }
        }
        if (count == NUM_ROW * NUM_COL){
            for (int i = 0; i < NUM_ROW; i++)
                for (int j = 0; j < NUM_COL; j++)
                    MHI[i][j] = MAX_VAL;
        }
    }

    // Simple MHI gradient calc in two directions
    public float gradient(int[][] input, int axis) { // axis = 0 horizontal, axis = 1 vertical
        float rst = 0;
        if (axis == 0){
            for (int i = 0; i < NUM_ROW; i++)
                for (int j = 0; j < NUM_COL - 1; j++)
                    rst += (float)(input[i][j + 1])/(float)MAX_VAL - (float)(input[i][j])/(float)MAX_VAL;
        } else{
            for(int i = 0; i < NUM_ROW - 1; i += 1)
                for(int j = 0; j < NUM_COL; j += 1)
                    rst += (float)(input[i + 1][j])/(float)MAX_VAL - (float)(input[i][j])/(float)MAX_VAL;
        }
        return rst;
    }
}
