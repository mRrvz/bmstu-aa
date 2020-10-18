#include "threads.h"

int start_threading(args_t *args, const int cnt_threads, const int type) {
    pthread_t *threads = malloc(cnt_threads * sizeof(pthread_t));

    if (!threads) {
        fprintf(stderr, "Erorr while allocate thredas\n");
        return ALLOCATE_ERROR;
    }

    pthread_args_t *args_array = malloc(sizeof(pthread_args_t) * cnt_threads);

    if (!args_array) {
        free(threads);
        fprintf(stderr, "Erorr while allocate pthread arguments\n");
        return ALLOCATE_ERROR;
    }

    for (int i = 0; i < cnt_threads; i++) {
        args_array[i].mult_args = args;
        args_array[i].tid = i;
        args_array[i].size = N;
        args_array[i].cnt_threads = cnt_threads;

        if (type == 1) {
            pthread_create(&threads[i], NULL, parallel_multiplication1, &args_array[i]);
        } else {
            pthread_create(&threads[i], NULL, parallel_multiplication2, &args_array[i]);
        }
    }

    for (int i = 0; i < cnt_threads; i++) {
        pthread_join(threads[i], NULL);
    }

    free(args_array);
    free(threads);

    return OK;
}
