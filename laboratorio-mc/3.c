#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int **vec, **res;

void allocate_memory(int size, int ***vec) {
  *vec = (int **)malloc(size * sizeof(int *));
  for (int i = 0; i < size; i++) {
    (*vec)[i] = (int *)malloc(size * sizeof(int));
  }
}

void initialize_matrix(int size, int **vec) {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++)
      vec[i][j] = rand() % 30 + 1;
  }
}

typedef struct {
  int start_row;
  int end_row;
  int size;
} thread_data;

void *multiply_rows(void *arg) {
  thread_data *data = (thread_data *)arg;

  for (int i = data->start_row; i < data->end_row; i++) {
    for (int j = 0; j < data->size; j++) {
      int partial_sum = 0;
      for (int k = 0; k < data->size; k++) {
        partial_sum += vec[i][k] * vec[k][j];
      }
      res[i][j] = partial_sum;
    }
  }

  return 0;
}

void print_matrix(int size, int **vec) {
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
  int num_threads = atoi(argv[2]);

  int rows_per_thread = N / num_threads;
  pthread_t threads[N];
  thread_data data[num_threads];

  allocate_memory(N, &vec);
  allocate_memory(N, &res);
  initialize_matrix(N, vec);

  for (int i = 0; i < num_threads; i++) {

    data[i].start_row = i * rows_per_thread;
    data[i].end_row = (i + 1) * rows_per_thread;
    data[i].size = N;

    if (i == num_threads - 1)
      data[i].end_row = N;

    pthread_create(&threads[i], NULL, multiply_rows, &data[i]);
  }

  for (int i = 0; i < num_threads; i++)
    pthread_join(threads[i], NULL);

  print_matrix(N, res);

  return 0;
}
