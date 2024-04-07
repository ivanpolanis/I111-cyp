#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

void initialize_arr(int *arr, int len) {
  srand(16);
  for (int i = 0; i < len; i++) {
    arr[i] = rand() % 29 + 1;
  }
}

int main(int argc, char *argv[]) {
  int n = atoi(argv[1]);
  int threads = atoi(argv[2]);
  int array[n];
  initialize_arr(array, n);

  omp_set_num_threads(threads);
#pragma omp parallel for schedule(guided)
  for (int i = 0; i < n; i++) {
    sleep(array[i] / 10);
  }

  printf("Nashe");
}
