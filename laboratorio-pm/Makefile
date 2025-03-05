# Variables
CC = mpicc
RUNNER = mpirun
FLAGS = -np
TARGET ?= build
SRC ?= 2.c
N ?= 200000
T ?= 6

# Compilar el programa
all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) -o $(TARGET) $(SRC)

# Ejecutar el programa con argumentos
run: $(TARGET)
	@echo "Ejecutando con N=$(N) y T=$(T)"
	$(RUNNER) $(FLAGS) $(T) ./$(TARGET) $(N) 

all-run: all run

# Limpiar los archivos generados
clean:
	$(RM) $(TARGET)

.PHONY: all clean run
