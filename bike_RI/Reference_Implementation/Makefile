MODE=1
HASH=AES


# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
#PROJECTNAME=$(shell basename $(CURDIR))
BINARYPATH=../bin/$(HASH)_$(MODE)
CC=g++
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -fomit-frame-pointer -Ofast -march=native -w
LDFLAGS = -lcrypto -lssl -lm -ldl -lntl -lgmp -lgf2x -lpthread
#-lm -lXKCP -lcrypto

# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas
vpath % $(BINARYPATH)

# add all c files in this directory
CSRC := $(wildcard *.c) $(wildcard *.cpp)
# add common path (nothing happen if not found)
COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c)
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build/$(HASH)_$(MODE)

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))
OBJ:=$(OBJ:.cpp=.o)

all: removeOriginals $(TARGET)

.PHONY: all clean removeOriginals

clean:
	@rm -f -R ./.build/ $(BINARYPATH)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) $$(BUILD_DIR)/$$(patsubst %,%.o,$$@)
	mkdir -p $(BINARYPATH)
	$(CC) $(CFLAGS) -o $(BINARYPATH)/$@ $^ $(LDFLAGS)

# remove NIST originals in project
removeOriginals:
	@rm -f PQCgenKAT_kem.c randombytes.h rng.c rng.h

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -DNIST_RAND=1 -o $@ $<

$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -DNIST_RAND=1 -o $@ $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -DNIST_RAND=1 -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

-include $(DEP)




## BIKE reference and optimized implementations assume that OpenSSL and NTL libraries are available in the platform.
#
## To compile this code for NIST KAT routine use: make bike-nist-kat
## To compile this code for demo tests use: make bike-demo-test
#
## TO EDIT PARAMETERS AND SELECT THE BIKE VARIANT: please edit defs.h file in the indicated sections.
#
## The file measurements.h controls how the cycles are counted. Note that #define REPEAT is initially set to 100,
## which means that every keygen, encaps and decaps is repeated 100 times and the number of cycles is averaged.
#
## Verbose levels: 0, 1, 2 or 3
#VERBOSE=0
#
#CC:=g++
#CFLAGS:=-O3
##-m64
#
#SRC:=*.c ntl.cpp FromNIST/rng.c
#INCLUDE:=-I. -I$(OpenSSL)/include -L$(OpenSSL)/lib -std=c++11 -lcrypto -lssl -lm -ldl -lntl -lgmp -lgf2x -lpthread
#
#all: bike-nist-kat
#
#bike-demo-test: $(SRC) *.h tests/test.c
#	$(CC) $(CFLAGS) tests/test.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@
#
#bike-nist-kat: $(SRC) *.h FromNIST/*.h FromNIST/PQCgenKAT_kem.c
#	$(CC) $(CFLAGS) FromNIST/PQCgenKAT_kem.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@
#
#clean:
#	rm -f PQCkemKAT_*
#	rm -f bike*
#
