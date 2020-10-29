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
#define MB 10485760 

typedef struct {
    size_t a;
    size_t b;
    size_t c;
    size_t d;
} check_t;

#define check_t int

void get_by_pos(FILE *const f, const int pos, char *getter)
{
    fseek(f, pos * MB, SEEK_SET);
    fread(getter, MB, 1, f);
}

void put_by_pos(FILE *const f, const int pos, char *putter)
{
    fseek(f, pos * MB, SEEK_SET);
    fwrite(putter, MB, 1, f);
}

void bubble_sort(FILE *f, int size, char *ptr1, char *ptr2) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {

            get_by_pos(f, j, ptr1);
            get_by_pos(f, j + 1, ptr2);
            /*printf("%d %d\n", ptr1[0], ptr2[0]);*/

            if (ptr1[0] > ptr2[0]) {
                put_by_pos(f, j, ptr2);
                put_by_pos(f, j + 1, ptr1);
            }
        }
    }
}

void my_qsort(FILE *f, int start, int stop, char *cur_el, char *mid)
{
    if (start >= stop)
    {
        return;
    }

    int left = start;
    int right = stop;

    /*check_t mid = arr[left];*/
    get_by_pos(f, (right + left) /2, mid);
    /*check_t mid = arr[(right + left) / 2];*/
    /*int mid = get_number_by_pos(cur_file, (left + right) / 2);*/

    while (left <= right)
    {
        get_by_pos(f, left, cur_el);
        /*cur_el = arr[left];*/
        //cur_el = get_number_by_pos(cur_file, left);
        while (cur_el[0] < mid[0])
        {
            left += 1;
            get_by_pos(f, left, cur_el);
            /*cur_el = get_number_by_pos(cur_file, left);*/
        }

        /*cur_el = get_number_by_pos(cur_file, right);*/
        /*cur_el = arr[right];*/
        get_by_pos(f, right, cur_el);

        while (cur_el[0] > mid[0])
        {
            right -= 1;
            /*cur_el = arr[right];*/
            get_by_pos(f, right, cur_el);
            /*cur_el = get_number_by_pos(cur_file, right);*/
        }

        if (left <= right)
        {
            get_by_pos(f, right, cur_el);
            get_by_pos(f, left, mid);

            put_by_pos(f, right, mid);
            put_by_pos(f, left, cur_el);

            /*SWAP(check_t, arr[right], arr[left]);*/
            /*swap(cur_file, right, left);*/
            left += 1;
            right -= 1;
        }
    }

    my_qsort(f, start, right, cur_el, mid);
    my_qsort(f, left, stop, cur_el, mid);
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

FILE *create_array(int size) {
    FILE *f = fopen("temp.bin", "wb+");
    char *ptr = malloc(sizeof(char) * MB);

    for (int i = 0; i < size; i++) {
        ptr[0] = size - i;
        fseek(f, i * MB, SEEK_SET);
        fwrite(ptr, MB, 1, f);
    }

    free(ptr);
    rewind(f);
    return f;
}

void print_binary(FILE *f, int size) {
    char *ptr = malloc(sizeof(char) * MB);

    for (int i = 0; i < size; i++) {
        get_by_pos(f, i, ptr);
        printf("%d ", ptr[0]);
    }

    printf("\n");

    rewind(f);
}


int main() {
    /*int a[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };*/

    FILE *f = create_array(10);

    char *ptr1 = malloc(sizeof(char) * MB);
    char *ptr2 = malloc(sizeof(char) * MB);

    /*print_binary(f, 10);*/

    uint32_t t1 = tick();
    my_qsort(f, 0, N - 1, ptr1, ptr2);
    uint32_t t2 = tick();

    fprintf(stdout, "QSORT: %d (тиков)\n", t2 - t1);
    fclose(f);

    /*print_binary(f, 10);*/

    f = create_array(10);

    t1 = tick();
    bubble_sort(f, 10, ptr1, ptr2);
    t2 = tick();

    /*print_array(c, N);*/
    
    /*print_binary(f, 10);*/

    fprintf(stdout, "BSORT: %d (тиков)\n", t2 - t1);

    free(ptr1);
    free(ptr2);
    fclose(f);


    /*print_array(b, N);*/

    return 0;
}
