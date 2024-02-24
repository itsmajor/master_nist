


CFLAGS    = -g -Wall  -O3  
 


all: okcn-sec   

SOURCES =   kem.c polynomial.c  reduce.c io.c okcn.c sec.c
HEADERS =   polynomial.h  parameter.h  reduce.h  io.h okcn.h sec.h

okcn-sec: $(SOURCES) $(HEADERS)   okcn-sec.c rng.c rng.h
	gcc $(CFLAGS) -o $@ $(SOURCES) rng.c okcn-sec.c -lcrypto


PQCgenKAT_kem: $(SOURCES) $(HEADERS)  PQCgenKAT_kem.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c PQCgenKAT_kem.c -lcrypto


speed: $(SOURCES) $(HEADERS)  speed.c  rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) rng.c   speed.c -lcrypto


okcn-sec-KATgen: $(SOURCES) $(HEADERS)  okcn-sec-KATgen.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c okcn-sec-KATgen.c -lcrypto
	
.PHONY: clean test

test: 
	.okcn-sec

clean:
	-$(RM) *.o
	-$(RM) -r okcn-sec
	
