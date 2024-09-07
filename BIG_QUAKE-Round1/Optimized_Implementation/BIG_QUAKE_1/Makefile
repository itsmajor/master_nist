CC = gcc-9
CFLAGS = -W -Wall -O4
LDFLAGS = -lssl -lcrypto
CPPFLAGS = -I. -I../../../_common/NIST
vpath %.h ../../../_common/NIST
vpath %.c ../../../_common/tomas

OBJECTS = keccak.o kem.o m2e.o permutation.o gf.o poly.o goppa.o decode.o roots.o ../../../_common/NIST/rng.o

.SECONDARY:

.PHONY: force all

all: PQCgenKAT_kem PQCgenKAT_kem_keygen PQCgenKAT_kem_dec PQCgenKAT_kem_enc

#
# main targets
#

PQCgenKAT_kem: $(OBJECTS) PQCgenKAT_kem.o
	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)

PQCgenKAT_kem_keygen: $(OBJECTS) PQCgenKAT_kem_keygen.o
	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)

PQCgenKAT_kem_enc: $(OBJECTS) PQCgenKAT_kem_enc.o
	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)

PQCgenKAT_kem_dec: $(OBJECTS) PQCgenKAT_kem_dec.o
	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)

#
# cleaning rules
#

clean:
	- /bin/rm -f *.o

veryclean: clean
	- /bin/rm PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen PQCkemKAT_*.req PQCkemKAT_*.rsp

# DO NOT DELETE

decode.o: goppa.h gf.h poly.h permutation.h
gf.o: gf.h rng.h
goppa.o: goppa.h gf.h poly.h permutation.h
kem.o: kem.h sizes.h gf.h api.h rng.h goppa.h poly.h permutation.h
kem.o: m2e.h
m2e.o: m2e.h sizes.h gf.h api.h
permutation.o: permutation.h rng.h
poly.o: gf.h poly.h
PQCgenKAT_kem.o: rng.h api.h sizes.h gf.h
rng.o: rng.h
roots.o: gf.h poly.h
