SHELL = /bin/sh
RM=/bin/rm -f
CXX=g++

PROGNAME=PQCgenKAT_kem
PROGNAME2=PQCgenKAT_kem_dec
PROGNAME3=PQCgenKAT_kem_enc
PROGNAME4=PQCgenKAT_kem_keygen

INCLUDES = -I. -I../../_common/NIST

LIBS= -lntl -lgmp -lssl -lcrypto

DEFINES=$(INCLUDES) $(DEFS)

XFLAGS = -Ofast -march=native -w

SRCS = kem.c ../../_common/NIST/rng.c ../../_common/tomas/PQCgenKAT_kem.c
SRCS2 = kem.c ../../_common/NIST/rng.c ../../_common/tomas/PQCgenKAT_kem_dec.c
SRCS3 = kem.c ../../_common/NIST/rng.c ../../_common/tomas/PQCgenKAT_kem_enc.c
SRCS4 = kem.c ../../_common/NIST/rng.c ../../_common/tomas/PQCgenKAT_kem_keygen.c

OBJNAMES = $(SRCS:.cpp=.o)
OBJNAMES2 = $(SRCS2:.cpp=.o)
OBJNAMES3 = $(SRCS3:.cpp=.o)
OBJNAMES4 = $(SRCS4:.cpp=.o)

all: PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen
	@:

%.o: %.cpp
	$(CXX) $(XFLAGS) $(DEFINES) -o$@ -c $<

PQCgenKAT_kem: $(OBJNAMES)
	$(CXX) $(XFLAGS) $(DEFINES) -o $@ $(OBJNAMES) $(LIBS)

PQCgenKAT_kem_dec: $(OBJNAMES2)
	$(CXX) $(XFLAGS) $(DEFINES) -o $@ $(OBJNAMES2) $(LIBS)

PQCgenKAT_kem_enc: $(OBJNAMES3)
	$(CXX) $(XFLAGS) $(DEFINES) -o $@ $(OBJNAMES3) $(LIBS)

PQCgenKAT_kem_keygen: $(OBJNAMES4)
	$(CXX) $(XFLAGS) $(DEFINES) -o $@ $(OBJNAMES4) $(LIBS)

clean:
	$(RM) *.o PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen *.req *.rsp
