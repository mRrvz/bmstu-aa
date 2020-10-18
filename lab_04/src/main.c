#include <stdio.h>
#include "multiplication.h"

int main() {
    int m1[N][M] = {
        { 2, -2, 3 },
        { 0, 2, 6 },
        { 5, 1, 0 },
    };

    int m2[M][K] = {
        { 0, 2, 5 },
        { 4, -1, 7 },
        { 1, -2, 0 }
    };

    int res[N][K];

    null_matrix(res);
    parallel_multiplication1(m1, m2, res);
    print_matrix(res);
    
    return 0;
}
