# Variables
CC = gcc
CFLAGS = -fopenmp -Wall -O2
TARGET ?= build
SRC ?= 2.c
N ?= 756
T ?= 4

# Compilar el programa
all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

# Ejecutar el programa con argumentos
run: $(TARGET)
	@echo "Ejecutando con N=$(N) y T=$(T)"
	./$(TARGET) $(N) $(T)

all-run: all run

# Limpiar los archivos generados
clean:
	$(RM) $(TARGET)

.PHONY: all clean run
