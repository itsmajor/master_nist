LOCAL="/usr/local"

HEAD=$(wildcard include/*.h*)
SRC=$(wildcard src/*.c*)
OBJS=$(SRC:.c*=.o)

CC=g++
LDFLAGS=-std=c++11 -lntl -lgmp -lgf2x -lXKCP -lcrypto -ldl -lpthread
CFLAGS=-ansi -Wall -O4 -mpclmul -I include/ -I $(LOCAL)/include -L $(LOCAL)/lib

all : PQCgenKAT_sign


PQCgenKAT_sign : $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
%.o : %.c*
	$(CC) $(CFLAGS) -o $@ -c $<


clean:
	rm -f PQCgenKAT_sign
