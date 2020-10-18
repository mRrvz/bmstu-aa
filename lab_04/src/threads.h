#ifndef __MY_THREADS_H__
#define __MY_THREADS_H__

#include <pthread.h>
#include <stdlib.h>

#include "multiplication.h"
#include "thread_structs.h"
#include "timer.h"

#define OK 0
#define ALLOCATE_ERROR 1

int start_threading(args_t *args, const int cnt_threads, const int type);

#endif
