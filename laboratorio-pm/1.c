#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

  if (argc < 2)
    return -1;

  int N = atoi(argv[1]);

  int rank, size;
  int vec[N][N], res[N][N];
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  int rows = N / size;
  int start, end;

  start = rank * rows;
  end = (rank == size - 1) ? N : (rank + 1) * rows;

  int res_local[end - start][N];

  if (rank == 0) {
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        vec[i][j] = rand() % 10 + 1;
  }

  MPI_Bcast(&vec, N * N, MPI_INT, 0, MPI_COMM_WORLD);

  printf("PROCESS %d\n", rank);
  for (int i = start; i < end; i++) {
    for (int j = 0; j < N; j++) {
      res_local[i - start][j] = 0;
      for (int k = 0; k < N; k++) {
        res_local[i - start][j] += vec[i][k] * vec[k][j];
      }
    }
  }

  int *sendcounts = NULL;
  int *displs = NULL;

  if (rank == 0) {
    sendcounts = (int *)malloc(size * sizeof(int));
    displs = (int *)malloc(size * sizeof(int));

    int offset = 0;
    for (int i = 0; i < size; i++) {
      int rows_i = (i == size - 1) ? rows + N % size : rows;
      sendcounts[i] = rows_i * N;
      displs[i] = offset;
      offset += sendcounts[i];
    }
  }

  MPI_Gatherv(&res_local, (end - start) * N, MPI_INT, &res, sendcounts, displs,
              MPI_INT, 0, MPI_COMM_WORLD);

  MPI_Finalize();

  return 0;
}
