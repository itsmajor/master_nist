CC=gcc
CFLAGS=-O3 -march=native -Wall
OBJS=PQCgenKAT_kem.o encrypt.o fastrandombytes.o kem.o ntt.o pack.o rng.o sampler.o
PROGRAM=titanium

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) $(OBJS) -o $(PROGRAM) -lXKCP -lcrypto

clean:;
	rm -f *.o $(PROGRAM)

