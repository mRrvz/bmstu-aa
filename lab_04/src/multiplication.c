#include <stdio.h>
#include <string.h>
#include <omp.h>
#include "multiplication.h"

double getSize() {
    int size = 50000;
    int matrix[size][size];
    double result = 0;

    for (int i = 0; i < size; i++) {
        memset(matrix[i], 1, sizeof(matrix[i]));
        #pragma omp parallel for
        for (int j = 0; j < size; j++) {
            result += matrix[i][j] * matrix[i][j] * matrix[i][j];
        }
    }

    return result;
}
