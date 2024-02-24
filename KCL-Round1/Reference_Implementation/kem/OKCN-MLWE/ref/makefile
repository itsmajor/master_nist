



CFLAGS    = -g -Wall  -O3  
 


all: okcn-mlwe   

SOURCES =   kem.c polynomial.c  reduce.c io.c okcn.c vector.c
HEADERS =   polynomial.h  parameter.h  reduce.h  io.h okcn.h vector.h

okcn-mlwe: $(SOURCES) $(HEADERS)   okcn-mlwe.c rng.c rng.h
	gcc $(CFLAGS) -o $@ $(SOURCES) rng.c okcn-mlwe.c -lcrypto


PQCgenKAT_kem: $(SOURCES) $(HEADERS)  PQCgenKAT_kem.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c PQCgenKAT_kem.c -lcrypto


okcn-mlwe-KATgen: $(SOURCES) $(HEADERS)  okcn-mlwe-KATgen.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c okcn-mlwe-KATgen.c -lcrypto

okcn-mlwe-intermediate-gen: $(SOURCES) $(HEADERS)  okcn-mlwe-intermediate-gen.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c okcn-mlwe-intermediate-gen.c -lcrypto

speed: $(SOURCES) $(HEADERS)  speed.c  rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) rng.c   speed.c -lcrypto



	
.PHONY: clean test

test: 
	.okcn-mlwe

clean:
	-$(RM) *.o
	-$(RM) -r okcn-mlwe
	
