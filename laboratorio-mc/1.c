#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <threads.h>
#include <unistd.h>

int main(int argc, char **argv) {

  if (argc < 3)
    return -1;

  int N = atoi(argv[1]);
  int threads = atoi(argv[2]);
  omp_set_num_threads(threads);

  int vec[N];

#pragma omp parallel for
  for (int i = 0; i < N; i++) {
    vec[i] = rand() % 30 + 1;
  }

#pragma omp parallel for
  for (int i = 0; i < N; i++) {
    printf("%d\n", vec[i]);
    usleep(vec[i]);
  }

  return 0;
}
