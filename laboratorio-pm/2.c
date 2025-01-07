#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define X 3

MPI_Status status;

int seek(int *vec, int size) {
  int counter = 0;

  for (int i = 0; i < size; i++) {
    counter += (vec[i] == X);
  }

  return counter;
}

int main(int argc, char **argv) {

  if (argc < 2)
    return -1;

  int N = atoi(argv[1]);
  int vec[N];
  int total = 0;

  int rank, size;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  int elements = N / size;

  // Master proccess
  if (rank == 0) {
    srand(time(NULL));
    for (int i = 0; i < N; i++)
      vec[i] = rand() % 10 + 1;

    for (int i = 1; i < size; i++) {
      int qty = (i == size - 1) ? elements + N % size : elements;
      MPI_Send(&qty, 1, MPI_INT, i, 1, MPI_COMM_WORLD);
      MPI_Send(&vec[i * elements], qty, MPI_INT, i, 1, MPI_COMM_WORLD);
    }

    total += seek(vec, elements);

    for (int i = 1; i < size; i++) {
      int counter;
      MPI_Recv(&counter, 1, MPI_INT, i, 1, MPI_COMM_WORLD, &status);
      total += counter;
    }

    for (int i = 0; i < N; i++)
      printf(" %d", vec[i]);

    printf("\nNumber: %d\nTotal: %d\n", X, total);
  }

  // Workers
  if (rank > 0) {
    MPI_Recv(&elements, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, &status);
    int local[elements];
    MPI_Recv(&local, elements, MPI_INT, 0, 1, MPI_COMM_WORLD, &status);

    int counter = seek(local, elements);

    MPI_Send(&counter, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
  }

  MPI_Finalize();

  return 0;
}
