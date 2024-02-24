
CFLAGS    = -g -Wall  -O3 

all: akcn-mlwe-cca

SOURCES =  myOpenSSL.c encrypt.c polynomial.c  reduce.c io.c akcn.c vector.c 
HEADERS =  myOpenSSL.h polynomial.h  parameter.h  reduce.h  io.h akcn.h vector.h 

akcn-mlwe-cca: $(SOURCES) $(HEADERS)   akcn-mlwe-cca.c rng.c rng.h
	gcc $(CFLAGS) -o $@ $(SOURCES) rng.c akcn-mlwe-cca.c -lcrypto
 
PQCgenKAT_encrypt: $(SOURCES) $(HEADERS)  PQCgenKAT_encrypt.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c PQCgenKAT_encrypt.c -lcrypto

speed: $(SOURCES) $(HEADERS)  speed.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c speed.c -lcrypto 

encrypt_KATgen: $(SOURCES) $(HEADERS)  encrypt_KATgen.c rng.c rng.h
	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c encrypt_KATgen.c -lcrypto 



	
.PHONY: clean test

test: 
	.akcn-mlwe-cca

clean:
	-$(RM) *.o
	-$(RM) -r akcn-mlwe-cca
	
