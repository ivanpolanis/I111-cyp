#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

void print_matrix(int size, int (*vec)[size]) {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++)
      printf(" %d", vec[i][j]);
    printf("\n");
  }
}

int main(int argc, char **argv) {
  if (argc < 3)
    return -1;

  int N = atoi(argv[1]);
  int threads = atoi(argv[2]);
  omp_set_num_threads(threads);

  int vec[N][N];

#pragma omp parallel for
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++)
      vec[i][j] = rand() % 9 + 1;
  }

  int res[N][N];
// res = vec X vec
#pragma omp parallel for collapse(2)
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      int partial_sum = 0;
      for (int k = 0; k < N; k++) {
        partial_sum += vec[i][k] * vec[k][j];
      }
      res[i][j] = partial_sum;
    }
  }

  return 0;
}
