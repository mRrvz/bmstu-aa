#include <stdio.h>

#include "threads.h"

#define INVALID_ARGS 2

int main(int argc, char *argv[]) {
    if (argc != 3) {
        return INVALID_ARGS;
    }

    args_t *args = create_args(N, M, K);
    if (!args) {
        return ALLOCATE_ERROR;
    }

    uint64_t start = tick();

    if (start_threading(args, atoi(argv[1]), atoi(argv[2]))) {
        return ALLOCATE_ERROR;
    }

    uint64_t end = tick();

    fprintf(stdout, "Время исполнения %lu (тиков)\nКоличество потоков: %s\n", end - start, argv[1]);

    #ifdef __DEBUG__
        print_matrix(args->res);
    #endif

    return 0;
}