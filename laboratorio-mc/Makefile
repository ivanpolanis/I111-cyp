# Variables
CC = gcc
# CFLAGS = -fopenmp -Wall -O2
CFLAGS = -pthread 
TARGET = build
SRC = 3.c
N ?= 16
T ?= 16

# Compilar el programa
all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

# Ejecutar el programa con argumentos
run: $(TARGET)
	@echo "Ejecutando con N=$(N) y T=$(T), SRC = $(SRC)"
	./$(TARGET) $(N) $(T)

all-run: all run

# Limpiar los archivos generados
clean:
	$(RM) $(TARGET)

.PHONY: all clean run all-run
