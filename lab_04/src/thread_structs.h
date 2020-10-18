#ifndef __THREAD_STRUCTS_H__
#define __THREAD_STRUCTS_H__

#include <stdint.h>

typedef struct {
    int **m1;
    int **m2;
    int **res;
} args_t;

typedef struct {
    args_t *mult_args;
    int tid;
    int size;
    int cnt_threads;
} pthread_args_t;

#endif
