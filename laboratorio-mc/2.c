#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

void init_matrix(int **matrix, int n) {
  int i, j;
#pragma omp parallel default(private) shared(matrix)
  {
    srand((int)(time(NULL)) ^ omp_get_thread_num());
#pragma omp for schedule(static)
    for (i = 0; i < n; i++) {
      for (j = 0; j < n; j++) {
        printf("thread: %d, i: %d", omp_get_thread_num(), i);
        matrix[i][j] = rand() % 31 + 1;
      }
    }
  }
}

void allocate_memory(int **matrix, int n) {
  for (int i = 0; i < n; i++) {
    matrix[i] = (int *)malloc(n * sizeof(int));
  }
}

int main(int argc, char **argv) {
  int n = atoi(argv[1]);
  int threads = atoi(argv[2]);

  int *res[n];
  int *a[n], *b[n];

  omp_set_num_threads(threads);

  allocate_memory(a, n);
  allocate_memory(b, n);
  allocate_memory(res, n);

  init_matrix(a, n);
  init_matrix(b, n);

#pragma omp parallel for shared(res) schedule(dynamic)
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        res[i][j] = a[i][k] * b[k][j];
      }
    }
  }
}
