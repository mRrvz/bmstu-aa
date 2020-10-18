#include "multiplication.h"

void print_matrix(int matrix[N][M]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            printf("%d ", matrix[i][j]);
        }

        printf("\n");
    }
}

void null_matrix(int matrix[N][M]) {
    for (int i = 0; i < N; i++) {
        memset(matrix[i], 0, sizeof(matrix[i]));
    }
}

void parallel_multiplication1(int m1[N][M], int m2[M][K], int res[N][K]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < K; j++) {
            for (int k = 0; k < M; k++) {
                res[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }
}

void parallel_multiplication2(int m1[N][M], int m2[M][K], int res[N][K]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < K; j++) {
            for (int k = 0; k < M; k++) {
                res[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }
}
