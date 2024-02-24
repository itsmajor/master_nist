CC=/usr/bin/gcc
CFLAGS= -O3 -fomit-frame-pointer -march=native -fPIC -no-pie
LDFLAGS=-lcrypto

SOURCES = poly_r2_inv.c fips202.c ntrukem.c owcpa.c poly.c verify.c PQCgenKAT_kem.c rng.c
SOURCES += square_1_701_patience.s \
	   square_3_701_patience.s \
	   square_6_701_patience.s \
	   square_12_701_shufbytes.s \
	   square_15_701_shufbytes.s \
	   square_27_701_shufbytes.s \
	   square_42_701_shufbytes.s \
	   square_84_701_shufbytes.s \
	   square_168_701_shufbytes.s \
	   square_336_701_shufbytes.s
SOURCES += poly_r2_mul.s poly_rq_mul.s poly_s3_mul.s poly_rq_mul_xm1.s
SOURCES += poly_s3_inv.s poly_rq_to_s3.s poly_s3_to_rq.s cbds3.s

HEADERS = api.h owcpa.h params.h poly.h poly_r2_inv.h rng.h verify.h rng.h

PQCgenKAT_kem: $(HEADERS) $(SOURCES)
	$(CC) $(CFLAGS) -o $@ $(SOURCES) $(LDFLAGS)

.PHONY: clean

clean:
	-rm PQCgenKAT_kem



