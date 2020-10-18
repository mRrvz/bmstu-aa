#include "multiplication.h"

void print_matrix(int **matrix) {
    fprintf(stdout, "Результат: ");

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            printf("%d ", matrix[i][j]);
        }

        printf("\n");
    }
}

void init_matrix(int **matrix) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            matrix[i][j] = 10; // random ?
        }
    }
}

int **create_matrix(int n, int m) {
    int **matrix = malloc(sizeof(int *) * n);

    if (!matrix) {
        fprintf(stderr, "Ошибка при выделении памяти. Файл: %s\nСтрока: %d\n", __FILE__, __LINE__);
        return NULL;
    }

    for (int i = 0; i < n; i++) {
        *(matrix + i) = malloc(sizeof(int) * m);

        if (!(*(matrix + i))) {
            fprintf(stderr, "Ошибка при выделении памяти. Файл: %s\nСтрока: %d\n", __FILE__, __LINE__);
            return NULL; // TODO: free
        }
    }

    #ifdef __DEBUG__
        print_matrix(matrix);
    #endif

    return matrix;
}

args_t *create_args(int n, int m, int k) {
    args_t *args = malloc(sizeof(args));
    if (!args) {
        return NULL;
    }

    if (!(args->m1 = create_matrix(n, m))) {
        return NULL; // TODO: free
    }

    init_matrix(args->m1);

    if (!(args->m2 = create_matrix(m, k))) {
        return NULL; // TODO: free
    }

    init_matrix(args->m2);

    if (!(args->res = create_matrix(n, k))) {
        return NULL; // TODO: free
    }

    return args;
}

void base_multiplication(args_t *args) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < K; j++) {
            args->res[i][j] = 0;
            for (int k = 0; k < M; k++) {
                args->res[i][j] += args->m1[i][k] * args->m2[k][j];
            }
        }
    }
}

void *parallel_multiplication1(void *args) {
    pthread_args_t *argsp = (args_t *)args;

    int row_start = argsp->tid * (argsp->size / argsp->cnt_threads);
    int row_end = (argsp->tid + 1) * (argsp->size / argsp->cnt_threads);

    #ifdef __DEBUG__
        fprintf(stderr, "\n ===== PMULT1: %d %d %d =======", argsp->tid, row_start, row_end);
    #endif

    for (int i = row_start; i < row_end; i++) {
        for (int j = 0; j < K; j++) {
            argsp->mult_args->res[i][j] = 0;

            for (int k = 0; k < M; k++) {
                argsp->mult_args->res[i][j] += argsp->mult_args->m1[i][k] * argsp->mult_args->m2[k][j];
            }
        }
    }

    return NULL;
}

void *parallel_multiplication2(void *args) {
    pthread_args_t *argsp = (args_t *)args;

    int col_start = argsp->tid * (argsp->size / argsp->cnt_threads);
    int col_end = (argsp->tid + 1) * (argsp->size / argsp->cnt_threads);

    #ifdef __DEBUG__
        fprintf(stderr, "\n ===== PMULT2: %d %d %d =======", argsp->tid, col_start, col_end);
    #endif

    for (int i = 0; i < N; i++) {
        for (int j = col_start; j < col_end; j++) {
            argsp->mult_args->res[i][j] = 0;

            for (int k = 0; k < M; k++) {
                argsp->mult_args->res[i][j] += argsp->mult_args->m1[i][k] * argsp->mult_args->m2[k][j];
            }
        }
    }

    return NULL;
}
