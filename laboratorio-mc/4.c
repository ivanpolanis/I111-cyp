#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>

#define X 2

int *vec;

void initialize_matrix(int *vec, int size) {
  for (int i = 0; i < size; i++)
    vec[i] = rand() % 9 + 1;
}

typedef struct {
  int start;
  int end;
} thread_data;

void *seek(void *arg) {
  thread_data *data = (thread_data *)arg;
  int sum = 0;

  for (int i = data->start; i < data->end; i++)
    if (vec[i] == X)
      sum++;

  pthread_exit((void *)(size_t)sum);
}

int main(int argc, char **argv) {
  if (argc < 3)
    return -1;

  int n = atoi(argv[1]);
  int num_threads = atoi(argv[2]);
  pthread_t threads[num_threads];
  thread_data data[num_threads];

  vec = (int *)malloc(n * sizeof(int));
  initialize_matrix(vec, n);

  int seek_size = n / num_threads;

  for (int i = 0; i < num_threads; i++) {
    data[i].start = i * seek_size;
    data[i].end = (i + 1) * seek_size;

    if (i == num_threads - 1)
      data[i].end = n;

    pthread_create(&threads[i], NULL, seek, &data[i]);
  }

  int total = 0;

  for (int i = 0; i < num_threads; i++) {
    void *ret;
    pthread_join(threads[i], &ret);
    total += (int)(size_t)ret;
  }

  // for (int i = 0; i < n; i++) {
  //   printf(" %d", vec[i]);
  // }

  printf("\n%d\n", total);

  return 0;
}
