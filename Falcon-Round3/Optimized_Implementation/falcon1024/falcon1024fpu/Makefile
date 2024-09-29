# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -O3 -march=native -w
LDFLAGS = -lssl -lcrypto

# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas_sign

# add all c files in this directory
CSRC := $(wildcard *.c)
# add common path (nothing happen if not found)
COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c)
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_sign PQCgenKAT_sign_dec PQCgenKAT_sign_enc PQCgenKAT_sign_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: $(TARGET)
	@:

.PHONY: all clean

clean:
	@rm -f -R ./.build/ $(TARGET)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

#$(BUILD_DIR)/%.o: %.s
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) -c -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

-include $(DEP)


## This Makefile compiles the implementation in this directory along with
## the known answer tests generator located in the
## ../../../KAT/generator/ directory. The output is an executable program
## in the build/ subdirectory, whose name starts with 'kat', followed by
## the implementation name (e.g. 'kat512int' for the 'falcon512int'
## implementation). This program, when executed, generates the .req and
## .rsp files in the expected NIST format.
#
#.POSIX:
#
#CC = c99
#CFLAGS = -W -Wall -O2
#LD = c99
#LDFLAGS = -lssl -lcrypto
#LIBS =
#
#OBJ1 = build/codec.o build/common.o build/fft.o build/fpr.o build/keygen.o build/nist.o build/rng.o build/shake.o build/sign.o build/vrfy.o
#
#OBJ2 = build/PQCgenKAT_sign.o build/katrng.o
#
#HEAD1 = api.h fpr.h inner.h
#HEAD2 = api.h ../../../KAT/generator/katrng.h
#
#all: build build/kat1024fpu
#
#build:
#	-mkdir build
#
#clean:
#	-rm -f build/kat1024fpu $(OBJ1) $(OBJ2)
#
#build/kat1024fpu: $(OBJ1) $(OBJ2)
#	$(LD) -o build/kat1024fpu $(OBJ1) $(OBJ2) $(LIBS) $(LDFLAGS)
#
#build/codec.o: codec.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/codec.o codec.c
#
#build/common.o: common.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/common.o common.c
#
#build/fft.o: fft.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/fft.o fft.c
#
#build/fpr.o: fpr.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/fpr.o fpr.c
#
#build/keygen.o: keygen.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/keygen.o keygen.c
#
#build/nist.o: nist.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/nist.o nist.c
#
#build/rng.o: rng2.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/rng.o rng.c
#
#build/shake.o: shake.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/shake.o shake.c
#
#build/sign.o: sign.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/sign.o sign.c
#
#build/vrfy.o: vrfy.c $(HEAD1)
#	$(CC) $(CFLAGS) -c -o build/vrfy.o vrfy.c
#
#build/PQCgenKAT_sign.o: ../../../KAT/generator/PQCgenKAT_sign.c $(HEAD2)
#	$(CC) $(CFLAGS) -I . -DALGNAME=falcon1024fpu -c -o build/PQCgenKAT_sign.o ../../../KAT/generator/PQCgenKAT_sign.c
#
#build/katrng.o: ../../../KAT/generator/katrng.c $(HEAD2)
#	$(CC) $(CFLAGS) -I . -c -o build/katrng.o ../../../KAT/generator/katrng.c
