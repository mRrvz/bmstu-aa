#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

uint64_t tick(void)
{
    uint32_t high, low;
    __asm__ __volatile__ (
        "rdtsc\n"
        "movl %%edx, %0\n"
        "movl %%eax, %1\n"
        : "=r" (high), "=r" (low)
        :: "%rax", "%rbx", "%rcx", "%rdx"
    );

    uint64_t ticks = ((uint64_t)high << 32) | low;

    return ticks;
}

int random_i(int r, int l){
    int rand_num = (rand() % (r - l + 1)) + l;
    return rand_num;
}

#define N 10
#define SWAP(t, a, b) do { t c = a; a = b; b = c; } while (0);

typedef struct {
    size_t a;
    size_t b;
    size_t c;
    size_t d;
} check_t;

#define check_t int

void bubble_sort(check_t arr[], int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                SWAP(check_t, arr[j], arr[j + 1]);
            }
        }
    }
}

void my_qsort(check_t arr[], int start, int stop)
{
    if (start >= stop)
    {
        return;
    }

    int left = start;
    int right = stop;
    check_t cur_el;

    /*check_t mid = arr[left];*/
    check_t mid = arr[(right + left) / 2];
    /*int mid = get_number_by_pos(cur_file, (left + right) / 2);*/

    while (left <= right)
    {
        cur_el = arr[left];
        //cur_el = get_number_by_pos(cur_file, left);
        while (cur_el < mid)
        {
            left += 1;
            cur_el = arr[left];
            /*cur_el = get_number_by_pos(cur_file, left);*/
        }

        /*cur_el = get_number_by_pos(cur_file, right);*/
        cur_el = arr[right];
        while (cur_el > mid)
        {
            right -= 1;
            cur_el = arr[right];
            /*cur_el = get_number_by_pos(cur_file, right);*/
        }

        if (left <= right)
        {
            SWAP(check_t, arr[right], arr[left]);
            /*swap(cur_file, right, left);*/
            left += 1;
            right -= 1;
        }
    }

    my_qsort(arr, start, right);
    my_qsort(arr, left, stop);
    //file_qsort(cur_file, start, right);
    //file_qsort(cur_file, left, stop);
}

void print_array(check_t a[], int size) {
    for (int i = 0; i < size; i++) {
        fprintf(stdout, "%d ", a[i]);
    }

    printf("\n");
}

void fill_array(check_t a[], check_t b[], int size) {
    for (int i = 0; i < size; i++) {
        /*a[i] = random_i(i, i + 100);*/
        a[i] = size - i;
        /*a[i].a = i + 1;*/
        /*a[i].b = i + 1;*/
        /*a[i].c = i + 1;*/
        /*a[i].d = i + 1;*/
        b[i] = a[i];
    }
}


int main() {
    /*int a[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };*/

    check_t *b = malloc(sizeof(check_t) * N);
    check_t *c = malloc(sizeof(check_t) * N);
    fill_array(b, c, N);

    print_array(b, N);

    uint32_t t1 = tick();
    my_qsort(b, 0, N - 1);
    uint32_t t2 = tick();

    print_array(b, N);
    print_array(c, N);

    fprintf(stdout, "QSORT: %d (тиков)", t2 - t1);

    t1 = tick();
    bubble_sort(c, N);
    t2 = tick();
    print_array(c, N);

    fprintf(stdout, " BSORT: %d (тиков)\n", t2 - t1);


    /*print_array(b, N);*/



    return 0;
}
