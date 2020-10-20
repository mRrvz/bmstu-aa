#include <stdio.h>
#include <stdlib.h>

#define N 100000
#define SWAP(t, a, b) do { t c = a; a = b; b = c; } while (0);

typedef struct {
    size_t a;
    size_t b;
    size_t c;
    size_t d;
} check_t;

void bubble_sort(check_t arr[], int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (arr[j].a > arr[j + 1].a) {
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

    check_t mid = arr[right];
    /*int mid = get_number_by_pos(cur_file, (left + right) / 2);*/

    while (left <= right)
    {
        cur_el = arr[left];
        //cur_el = get_number_by_pos(cur_file, left);
        while (cur_el.a < mid.a)
        {
            left += 1;
            cur_el = arr[left];
            /*cur_el = get_number_by_pos(cur_file, left);*/
        }

        /*cur_el = get_number_by_pos(cur_file, right);*/
        cur_el = arr[right];
        while (cur_el.a > mid.a)
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
        fprintf(stdout, "%ld ", a[i].a);
    }

    printf("\n");
}

void fill_array(check_t a[], int size) {
    for (int i = 0; i < size; i++) {
        a[i].a = i + 1;
        a[i].b = i + 1;
        a[i].c = i + 1;
        a[i].d = i + 1;
    }
}


int main() {
    int a[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

    check_t *b = malloc(sizeof(check_t) * N);
    fill_array(b, N);

    /*print_array(b, N);*/
    my_qsort(b, 0, N - 1);
    bubble_sort(b, N);
    /*print_array(b, N);*/



    return 0;
}
