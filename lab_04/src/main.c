#include <stdio.h>

#include "threads.h"

#define INVALID_ARGS 2
/*
 * 1 - file flag
 * 2 - type 
 * 3 - threads cnt
 */

int main(int argc, char *argv[]) {
    if (argc < 3) {
        return INVALID_ARGS;
    }

    args_t *args = create_args(N, M, K, atoi(argv[1]));
    if (!args) {
        return ALLOCATE_ERROR;
    }

    int type = atoi(argv[2]);

    if (3 == type) {

        uint64_t start = tick();
        base_multiplication(args);
        uint64_t end = tick();

        fprintf(stdout, "Время исполнения %lu (тиков)\n", end - start);

    } else {
        uint64_t start = tick();

        if (start_threading(args, atoi(argv[3]), type)) {
            return ALLOCATE_ERROR;
        }
    
        uint64_t end = tick();

        fprintf(stdout, "Время исполнения %lu (тиков)\nКоличество потоков: %s\n", end - start, argv[3]);
    }

    /*#ifdef __DEBUG__*/
    if (atoi(argv[1])) {
        print_matrix(args->res);
    }
    /*#endif*/

    return OK;
}
