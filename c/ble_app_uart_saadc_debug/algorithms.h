//
//  algorithms.h
//  OptoSense
//
//  Created by Dingtian Zhang on 5/4/19.
//  Copyright © 2019 Dingtian Zhang. All rights reserved.
//

#include "deque.h"

#define INIT -1
#define MASK -2
#define WSHED 0

#define NUM_COL 8
#define NUM_ROW 8

#define MAX_TOUCHPOINTS 6

// Watershed algorithm
void labelling(Deque *q, uint16_t i, uint16_t j, uint16_t ii, uint16_t jj, uint16_t curdist, int lab[NUM_ROW][NUM_COL], uint16_t dist[NUM_ROW][NUM_COL]) {
    if(dist[ii][jj] < curdist && (lab[ii][jj] > 0 || lab[ii][jj] == WSHED)) {
        if(lab[ii][jj] > 0) {
            if(lab[i][j] == MASK || lab[i][j] == WSHED)
                lab[i][j] = lab[ii][jj];
            else if(lab[i][j] != lab[ii][jj])
                lab[i][j] = WSHED;
        }
        else if(lab[i][j] == MASK)
            lab[i][j] = WSHED;
    }
    else if(lab[ii][jj] == MASK && dist[ii][jj] == 0) {
        dist[ii][jj] = curdist + 1;
        uint16_t tmp[2] = {ii, jj};
        Deque_insertrear(q, tmp);
    }
}

//int comparator (const void * a, const void * b) {
//    return ( *(int*)a - *(int*)b );
//}

int comparator (uint16_t *num1, uint16_t *num2)
{
    if (*num1 < *num2) return -1;
    else if (*num1 == *num2) return 0;
    return 1;
}

uint16_t* sort_into_array (uint16_t input[NUM_ROW][NUM_COL]) {
    static uint16_t result[NUM_ROW * NUM_COL];
    for(uint16_t i = 0; i < NUM_ROW; i += 1) {
        for(uint16_t j = 0; j < NUM_COL; j += 1) {
            result[i * NUM_COL + j] = input[i][j];
        }
    }
    qsort(result, NUM_ROW * NUM_COL, sizeof(uint16_t), comparator);
    return result;
}

void watershed (uint16_t input[NUM_ROW][NUM_COL], int lab[NUM_ROW][NUM_COL], Deque *q) {
    uint16_t FICTITIOUS[2] = {-1, -1};
    uint16_t curlab = 0;
    uint16_t dist[NUM_ROW][NUM_COL];
    memset(&dist, 0, sizeof(dist));
    uint16_t* hs = sort_into_array(input);
    uint16_t prev_h = -1;
    for(uint16_t n = 0; n < NUM_ROW * NUM_COL; n += 1) {
        uint16_t h = hs[n];
        if(prev_h == h)
            continue;
        else
            prev_h = h;
        //        printf("lab");
        //        printf(lab);
        for(uint16_t i = 0; i < NUM_ROW; i += 1) {
            for(uint16_t j = 0; j < NUM_COL; j += 1) {
                if(input[i][j] == h){
                    lab[i][j] = MASK;
                    uint16_t flag = 0;
                    if(i > 0) {
                        uint16_t ii = i - 1;
                        if(lab[ii][j] > 0 || lab[ii][j] == WSHED)
                            flag = 1;
                    }
                    if(i < NUM_ROW - 1) {
                        uint16_t ii = i + 1;
                        if(lab[ii][j] > 0 || lab[ii][j] == WSHED)
                            flag = 1;
                    }
                    if(j > 0) {
                        uint16_t jj = j - 1;
                        if(lab[i][jj] > 0 || lab[i][jj] == WSHED)
                            flag = 1;
                    }
                    if(j < NUM_COL - 1) {
                        uint16_t jj = j + 1;
                        if(lab[i][jj] > 0 || lab[i][jj] == WSHED)
                            flag = 1;
                    }
                    if(flag == 1) {
                        dist[i][j] = 1;
                        uint16_t key[2] = {i, j};
                        Deque_insertrear(q, key);
                    }
                }
            }
        }
        uint16_t curdist = 1;
        Deque_insertrear(q, FICTITIOUS);
        while(!Deque_isEmpty(q)) {
            uint16_t* p = Deque_popfront(q);
            if(p[0] == FICTITIOUS[0] && p[1] == FICTITIOUS[1]) {
                if(Deque_isEmpty(q))
                    break;
                else{
                    Deque_insertrear(q, FICTITIOUS);
                    curdist += 1;
                    p = Deque_popfront(q);
                }
            }
            uint16_t i = p[0];
            uint16_t j = p[1];
            
            if(i > 0) {
                uint16_t ii = i - 1;
                labelling(q, i, j, ii, j, curdist, lab, dist);
            }
            if(i < NUM_ROW - 1) {
                uint16_t ii = i + 1;
                labelling(q, i, j, ii, j, curdist, lab, dist);
            }
            if(j > 0) {
                uint16_t jj = j - 1;
                labelling(q, i, j, i, jj, curdist, lab, dist);
            }
            if(j < NUM_COL - 1) {
                uint16_t jj = j + 1;
                labelling(q, i, j, i, jj, curdist, lab, dist);
            }
        }
        for(uint16_t i = 0; i < NUM_ROW; i += 1) {
            for(uint16_t j = 0; j < NUM_COL; j += 1) {
                if(input[i][j] == h) {
                    dist[i][j] = 0;
                    if(lab[i][j] == MASK) {
                        curlab = curlab + 1;
                        uint16_t tmp[2] = {i, j};
                        Deque_insertrear(q, tmp);
                        lab[i][j] = curlab;
                        while(!Deque_isEmpty(q)) {
                            uint16_t* qq = Deque_popfront(q);
                            uint16_t ii = qq[0];
                            uint16_t jj = qq[1];
                            if(ii > 0) {
                                uint16_t iii = ii - 1;
                                if(lab[iii][jj] == MASK) {
                                    uint16_t tmp[2] = {iii, jj};
                                    Deque_insertrear(q, tmp);
                                    lab[iii][jj] = curlab;
                                }
                            }
                            if(ii < NUM_ROW - 1) {
                                uint16_t iii = ii + 1;
                                if(lab[iii][jj] == MASK) {
                                    uint16_t tmp[2] = {iii, jj};
                                    Deque_insertrear(q, tmp);
                                    lab[iii][jj] = curlab;
                                }
                            }
                            if(jj > 0) {
                                uint16_t jjj = jj - 1;
                                if(lab[ii][jjj] == MASK) {
                                    uint16_t tmp[2] = {ii, jjj};
                                    Deque_insertrear(q, tmp);
                                    lab[ii][jjj] = curlab;
                                }
                            }
                            if(jj < NUM_COL - 1) {
                                uint16_t jjj = jj + 1;
                                if(lab[ii][jjj] == MASK) {
                                    uint16_t tmp[2] = {ii, jjj};
                                    Deque_insertrear(q, tmp);
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


// Extract centors from watershed result as weighted centroid
void extract_centors(uint16_t input[NUM_ROW][NUM_COL], float rst[MAX_TOUCHPOINTS][2], uint16_t max_value, float threshold, Deque *q) {
    uint16_t input_reduced[NUM_ROW][NUM_COL];
    for(uint16_t i = 0; i < NUM_ROW; i += 1)
        for(uint16_t j = 0; j < NUM_COL; j += 1)
            input_reduced[i][j] = input[i][j]/10;
    float count[MAX_TOUCHPOINTS];
    memset(&count, 0, sizeof(count));
    float count_pixel[MAX_TOUCHPOINTS];
    memset(&count_pixel, 0, sizeof(count_pixel));
    uint16_t x_s[MAX_TOUCHPOINTS];
    memset(&x_s, 0, sizeof(x_s));
    uint16_t y_s[MAX_TOUCHPOINTS];
    memset(&y_s, 0, sizeof(y_s));
    static int label[NUM_ROW][NUM_COL];
    memset(&label, INIT, sizeof(label));
    
    uint16_t addup = 0;
    watershed(input_reduced, label, q);
    for(uint16_t i = 0; i < NUM_ROW; i += 1) {
        for(uint16_t j = 0; j < NUM_COL; j += 1) {
            uint16_t index = label[i][j];
            uint16_t signal = max_value - input[i][j];
            addup += signal;
            if(index > 0) {
                count[index] += (float)signal;
                x_s[index] += signal*i;
                y_s[index] += signal*j;
                count_pixel[index] += 1.0;
            }
        }
    }
    float dimension = (float)(NUM_ROW * NUM_COL);
    float mean = (float)addup / dimension;
    float level = mean * threshold; // greater than this level
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {
        float value = count[i] / count_pixel[i];
        if( count[i] > 0 && value > level) {
            float x = (float)x_s[i] / count[i];
            float y = (float)y_s[i] / count[i];
            rst[i][0] = y; // Reverse orders
            rst[i][1] = x; // Reverse orders
        }
    }
}

//// Extract touch location as local maxima
void extract_touch(uint16_t input[NUM_ROW][NUM_COL], float rst[MAX_TOUCHPOINTS][2], uint16_t max_value, float threshold, Deque *q) {
    uint16_t input_reduced[NUM_ROW][NUM_COL];
    for(uint16_t i = 0; i < NUM_ROW; i += 1)
        for(uint16_t j = 0; j < NUM_COL; j += 1)
            input_reduced[i][j] = input[i][j]/10;
    uint16_t maxima[MAX_TOUCHPOINTS];
    memset(&maxima, 0, sizeof(maxima));
    uint16_t x_s[MAX_TOUCHPOINTS];
    memset(&x_s, 0, sizeof(x_s));
    uint16_t y_s[MAX_TOUCHPOINTS];
    memset(&y_s, 0, sizeof(y_s));
    static int label[NUM_ROW][NUM_COL];
    memset(&label, INIT, sizeof(label));
    uint16_t addup = 0;
    watershed(input_reduced, label, q);
    for(uint16_t i = 0; i < NUM_ROW; i += 1) {
        for(uint16_t j = 0; j < NUM_COL; j += 1) {
            uint16_t index = label[i][j];
            uint16_t signal = max_value - input[i][j];
            addup += signal;
            if(index > 0) {
                if(maxima[index] < signal) {
                    maxima[index] = signal;
                    x_s[index] = i;
                    y_s[index] = j;
                }
            }
        }
    }
    float dimension = (float)(NUM_ROW * NUM_COL);
    float mean = (float)addup / dimension;
    float level = mean * threshold; // greater than this level
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {
        if( maxima[i] > level) {
            rst[i][0] = y_s[i]; // Reverse orders
            rst[i][1] = x_s[i]; // Reverse orders
        }
    }
//    uint16_t** label = watershed(input_inv);
//    for i in range(input.shape[0]):
//        for j in range(input.shape[1]):
//            index = (int)(label[i, j])
//            addup += input[i, j]
//            if index > 0 and index < 5:
//                if(maxima[index] < input[i, j]):
//                    x_s[index] = i
//                    y_s[index] = j
//                    maxima[index] = input[i, j]
//    rst = []
//    mean = addup / input.shape[0] / input.shape[1]
//    level = mean * threshold + mean ## greater than this level
//    for i in range(5):
//        if maxima[i] > level:
//            x = x_s[i]
//            y = y_s[i]
//            rst = rst + [[y, x]] ## Reverse orders
//    return np.array(rst)
}


// Struct storing index, nearest touch point, and distance for each touch point
typedef struct{
    uint16_t index;
    int nearest;
    float distance;
}point;

int compare_distance (point *a, point *b)
{
    if ((*a).distance < (*b).distance) return -1;
    else if ((*a).distance == (*b).distance) return 0;
    return 1;
}


// Extracting nearest pairs
void pair(float centors[MAX_TOUCHPOINTS][2], float new_centors[MAX_TOUCHPOINTS][2], point nearest[MAX_TOUCHPOINTS], int pair_list[MAX_TOUCHPOINTS], int pair_list_current[MAX_TOUCHPOINTS], float rst_centors[MAX_TOUCHPOINTS][2], uint16_t count_paired, uint16_t count_prev, uint16_t count) {
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {// Produce a list of unparied previous touch with its closest unpaired current touch
        if(centors[i][0] != -1.0 || centors[i][1] != -1.0) {
            if(pair_list[i] == -1) {
                for(uint16_t j = 0; j < MAX_TOUCHPOINTS; j += 1) {
                    if(pair_list_current[j] == -1){
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
//    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {
//        printf("%d, %d, %.2f \r\n", nearest[i].index, nearest[i].nearest, nearest[i].distance);
//    }
    qsort(nearest, MAX_TOUCHPOINTS, sizeof(point), compare_distance);
//    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {
//        printf("%d, %d, %.2f \r\n", nearest[i].index, nearest[i].nearest, nearest[i].distance);
//    }
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {
        int current_pair = nearest[i].nearest;
        if(current_pair != -1){
            if(pair_list_current[current_pair] == -1) { // CURRENT touch is unpaired
                pair_list_current[current_pair] = nearest[i].index;
                pair_list[nearest[i].index] = current_pair;
                rst_centors[nearest[i].index][0] = new_centors[current_pair][0];
                rst_centors[nearest[i].index][1] = new_centors[current_pair][1];
                count_paired += 1;
                if(count_paired == count) // all CURRENT touches are paired
                    return;
                else if(count_paired == count_prev) { // all PREVIOUS touches are paired
                    for(uint16_t j = 0; j < MAX_TOUCHPOINTS; j += 1) {
                        if(pair_list_current[j] == -1) { // unpaired CURRENT touches
                            for (uint16_t k = 0; k < MAX_TOUCHPOINTS; k += 1) {
                                if(rst_centors[k][0] == -1.0 && rst_centors[k][1] == -1.0) {
                                    rst_centors[k][0] = new_centors[j][0];
                                    rst_centors[k][1] = new_centors[j][1];
                                    break;
                                }
                            }
                        }
                    }
                    return;
                }
            }
            else
                pair(centors, new_centors, nearest, pair_list, pair_list_current, rst_centors, count_paired, count_prev, count);
        }
    }
}

// Tracking using minimum distance first (MDF) algorithm
void track(float centors[MAX_TOUCHPOINTS][2], float new_centors[MAX_TOUCHPOINTS][2], float rst[MAX_TOUCHPOINTS][2]) {
    point nearest[MAX_TOUCHPOINTS]; // Stores nearest CURRENT touches for the previous touch
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1){
        nearest[i].index = i;
        nearest[i].nearest = -1;
        nearest[i].distance = 10000.0;
    }
    int pair_list[MAX_TOUCHPOINTS]; // Stores paired PREVIOUS touches for the previous touch
    memset(&pair_list, -1, sizeof(pair_list));
    int pair_list_current[MAX_TOUCHPOINTS]; // Stores paired PREVIOUS touches for the previous touch
    memset(&pair_list_current, -1, sizeof(pair_list_current));
    uint16_t count_paired = 0;
    uint16_t count_prev = 0;
    uint16_t count = 0;
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1)
        if(centors[i][0] != -1.0 || centors[i][1] != -1.0)
            count_prev += 1;
    if(count_prev == 0) {
        for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1) {
            rst[i][0] = new_centors[i][0];
            rst[i][1] = new_centors[i][1];
        }
        return;
    }
    for(uint16_t i = 0; i < MAX_TOUCHPOINTS; i += 1)
        if(new_centors[i][0] != -1.0 || new_centors[i][1] != -1.0)
            count += 1;
    pair(centors, new_centors, nearest, pair_list, pair_list_current, rst, count_paired, count_prev, count);
}
