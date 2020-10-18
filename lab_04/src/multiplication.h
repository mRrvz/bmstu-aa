#ifndef __PRINT_MATRIX__
#define __PRINT_MATRIX__

#include <stdio.h>
#include <string.h>
#include <pthread.h>

#define N 3
#define M N
#define K N

void print_matrix(int matrix[N][M]);

void null_matrix(int matrix[N][M]);

void parallel_multiplication1(int m1[N][M], int m2[M][K], int res[N][K]);

void parallel_multiplication2(int m1[N][M], int m2[M][K], int res[N][K]);

#endif
