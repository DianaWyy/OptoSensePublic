//
//  Deque.h
//  OptoSense
//
//  Created by Dingtian Zhang on 5/4/19.
//  Copyright © 2019 Dingtian Zhang. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef Deque_h
#define Deque_h

// C implementation of De-queue using circular
// array


// Maximum size of array or Dequeue
#define MAX_DEQUE 100

// A structure to represent a Deque
typedef struct {
    uint16_t arr[MAX_DEQUE][2];
    uint16_t front;
    uint16_t rear;
    uint16_t size;
} Deque;

void Deque_init(Deque* self, uint16_t size)
{
    self->front = 1;
    self->rear = 0;
    self->size = 0;
}

// Checks whether Deque is full or not.
bool Deque_isFull(Deque* self)
{
    return (self->size == MAX_DEQUE);
}

// Checks whether Deque is empty or not.
bool Deque_isEmpty (Deque* self)
{
    return (self->size == 0);
}

// Inserts an element at front
void Deque_insertfront(Deque* self, uint16_t key[2])
{
    // check whether Deque if full or not
    if (Deque_isFull(self))
    {
        printf("Overflow\n");
        return;
    }
    
    self->size += 1;
    
    // front is at first position of queue
    if (self->front == 0)
        self->front = MAX_DEQUE - 1 ;
    
    else // decrement front end by '1'
        self->front = self->front-1;
    
    // insert current element into Deque
    self->arr[self->front][0] = key[0];
    self->arr[self->front][1] = key[1];
}

// function to inset element at rear end
// of Deque.
void Deque_insertrear(Deque* self, uint16_t key[2])
{
    if (Deque_isFull(self))
    {
        printf(" Overflow\n ");
        return;
    }
    
    self->size += 1;
    
    // rear is at last position of queue
    if (self->rear == MAX_DEQUE - 1)
        self->rear = 0;
    
    // increment rear end by '1'
    else
        self->rear = self->rear+1;
    
    // insert current element into Deque
    self->arr[self->rear][0] = key[0] ;
    self->arr[self->rear][1] = key[1] ;
}

// Deletes and returns element at front end of Deque
uint16_t* Deque_popfront(Deque* self)
{
    // check whether Deque is empty or not
    if (Deque_isEmpty(self))
    {
        printf("Queue Underflow\n");
        return NULL;
    }
    self->size -= 1;
    
    static uint16_t rst[2];
    rst[0] = self->arr[self->front][0];
    rst[1] = self->arr[self->front][1];
    
    if (self->front == MAX_DEQUE -1)
        self->front = 0;

    else // increment front by '1' to remove current
        // front value from Deque
        self->front = self->front + 1;
    
    return rst;
}

// Delete and returns element at rear end of Deque
uint16_t* Deque_poprear(Deque* self)
{
    if (Deque_isEmpty(self))
    {
        printf(" Underflow\n");
        return NULL;
    }
    self->size -= 1;
    
    static uint16_t rst[2];
    rst[0] = self->arr[self->rear][0];
    rst[1] = self->arr[self->rear][1];
    
    if (self->rear == 0)
        self->rear = MAX_DEQUE - 1;
    else
        self->rear = self->rear - 1;
    
    return rst;
}

// Returns front element of Deque
uint16_t* Deque_getFront(Deque* self)
{
    // check whether Deque is empty or not
    if (Deque_isEmpty(self))
    {
        printf(" Underflow\n");
        return NULL ;
    }
    return self->arr[self->front];
}

// function return rear element of Deque
uint16_t* Deque_getRear(Deque* self)
{
    // check whether Deque is empty or not
    if(Deque_isEmpty(self) || self->rear < 0)
    {
        printf(" Underflow\n");
        return NULL;
    }
    return self->arr[self->rear];
}

// function return length of the queue
uint16_t Deque_getSize(Deque* self)
{
    return self->size;
}


#endif /* Deque_h */
