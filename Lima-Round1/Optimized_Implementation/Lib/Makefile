CC = gcc
CFLAGS = -w -std=c11 -g -O3 -march=native

SRC = fft.c lima.c modp.c xof.c LimaAPI.c fft.h lima.h modp.h xof.h LimaAPI.h 

OBJ = fft.o lima.o modp.o xof.o LimaAPI.o

.PHONY: all

all: libLima.a
	@:

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $*.c 

libLima.a: $(OBJ) 
	$(AR) -crs libLima.a $(OBJ)

clean:
	@rm -f *.o libLima.a
