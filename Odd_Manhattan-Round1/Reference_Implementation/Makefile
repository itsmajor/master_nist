LDFLAGS = -lgmp -lcrypto
CFLAGS = 
OBJS = rng.o \
	kem.o \
	PQCgenKAT_kem.o 
PQCgenKAT_kem : $(OBJS) 
	gcc -o $@ $^ $(LDFLAGS) $(CFLAGS) 

%.o : %.c
	gcc $(CFLAGS) -o $@ -c $<

rng.o : rng.h 		
api.o : api.h 
PQCgenKAT_kem.o : rng.h api.h
