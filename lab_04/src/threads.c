#include "threads.h"

int start_threading(args_t *args, const int cnt_threads, const int type) {
    pthread_t *threads = malloc(cnt_threads * sizeof(pthread_t));

    if (!threads) {
        fprintf(stderr, "Ошибка при выделении памяти. Файл: %s\nСтрока: %d\n", __FILE__, __LINE__);
        return ALLOCATE_ERROR;
    }

    pthread_args_t *args_array = malloc(sizeof(pthread_args_t) * cnt_threads);

    if (!args_array) {
        free(threads);
        fprintf(stderr, "Ошибка при выделении памяти: %d\nФайл: %s\n", __LINE__, __FILE__);
        return ALLOCATE_ERROR;
    }

    if (type == 3 || type == 4) {
        transpose(args);
    }

    for (int i = 0; i < cnt_threads; i++) {
        args_array[i].mult_args = args;
        args_array[i].tid = i;
        args_array[i].size = N;
        args_array[i].cnt_threads = cnt_threads;

        switch (type) {
            case 1:
                pthread_create(&threads[i], NULL, parallel_multiplication1, &args_array[i]);
                break;
            case 2:
                pthread_create(&threads[i], NULL, parallel_multiplication2, &args_array[i]);
                break;
            case 3:
                pthread_create(&threads[i], NULL, transpose_parallel_multiplication1, &args_array[i]);
                break;
            case 4:
                pthread_create(&threads[i], NULL, transpose_parallel_multiplication2, &args_array[i]);
                break;
        }
    }

    for (int i = 0; i < cnt_threads; i++) {
        pthread_join(threads[i], NULL);
    }

    free(args_array);
    free(threads);

    return OK;
}
