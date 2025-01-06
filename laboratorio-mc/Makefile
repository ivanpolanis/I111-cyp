# Variables
CC = gcc
#CFLAGS = -fopenmp -Wall -O2
CFLAGS = -pthread 
TARGET ?= build
SRC ?= 4.c
N ?= 2048
T ?= 2

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
