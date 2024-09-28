CC=    gcc
CXX=   g++
LD=    gcc

#PROJ = amd64
#
#ifdef REF
#	PROJ = ref
#endif
PROJ=Gui-184

PROJ_DIR = ./$(PROJ)

CFLAGS= -O2 -std=c99 -Wall -Wextra -w
INCPATH= -I/usr/local/include -I/opt/local/include -I/usr/include -I$(PROJ_DIR)
LDFLAGS=
LIBPATH= -L/usr/local/lib -L/opt/local/lib -L/usr/lib
LIBS=    -lcrypto


SRCS = $(wildcard $(PROJ_DIR)/*.c)
SRCS_O = $(SRCS:.c=.o)
SRCS_O_ND = $(subst $(PROJ_DIR)/,,$(SRCS_O))

OBJ = $(SRCS_O_ND) utils.o

EXE= PQCgenKAT_sign gui-genkey gui-sign gui-verify


.PHONY: all tests tables clean

all: $(OBJ) $(EXE)

%-test: $(OBJ) %-test.o
	$(LD) $(LDFLAGS) $(LIBPATH) -o $@ $^ $(LIBS)

%-benchmark: $(OBJ) %-benchmark.o
	$(LD) $(LDFLAGS) $(LIBPATH) -o $@ $^ $(LIBS)

PQCgenKAT_sign: $(OBJ) PQCgenKAT_sign.o
	mkdir -p tests/$(PROJ)
	$(LD) $(LDFLAGS) $(LIBPATH) -o tests/$(PROJ)/$@ $^ $(LIBS)

gui-genkey: $(OBJ) gui-genkey.o
	mkdir -p tests/$(PROJ)
	$(LD) $(LDFLAGS) $(LIBPATH) -o tests/$(PROJ)/$@ $^ $(LIBS)

gui-sign: $(OBJ) gui-sign.o
	$(LD) $(LDFLAGS) $(LIBPATH) -o tests/$(PROJ)/$@ $^ $(LIBS)

gui-verify: $(OBJ) gui-verify.o
	$(LD) $(LDFLAGS) $(LIBPATH) -o tests/$(PROJ)/$@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(PROJ_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: common/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<


%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCPATH) -c $<

tests:
	cd tests; make

tables:
	cd supplement; make

clean:
#	rm *.o *-test *-benchmark PQCgenKAT_sign gui-genkey gui-sign gui-verify;
	@rm -f *.o PQCgenKAT_sign gui-genkey gui-sign gui-verify;
