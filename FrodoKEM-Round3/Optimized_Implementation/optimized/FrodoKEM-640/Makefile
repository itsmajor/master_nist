#[AES/SHAKE]
MATRIX=AES
SEC=640

ifeq ($(MATRIX),AES)
    USE_GENERATION_A=_AES128_FOR_A_
else
    USE_GENERATION_A=_SHAKE128_FOR_A_
endif

# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=aes
PROJECTNAME=$(shell basename $(CURDIR))
BINARYPATH=../../../bin/$(PROJECTNAME)_$(MATRIX)
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -I sha3 -Wall -fomit-frame-pointer -Ofast -march=native -w -DNIX -D_ARM_ -D$(USE_GENERATION_A) -D_OPTIMIZED_GENERIC_ -D_USE_OPENSSL_
LDFLAGS =  -lrt -lm -lssl -lcrypto
# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
vpath % sha3
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas
vpath % $(BINARYPATH)

# add all c files in this directory
#CSRC := $(wildcard *.c)
CSRC := frodo$(SEC).c util.c
# add common path (nothing happen if not found)
#COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c)
COMMON := aes/aes.c aes/aes_c.c sha3/fips202.c
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build_$(MATRIX)

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: removeOriginals $(TARGET)

.PHONY: all clean removeOriginals

clean:
	@rm -f -R ./.build* $(BINARYPATH)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) $$(BUILD_DIR)/$$(patsubst %,%.o,$$@)
	mkdir -p $(BINARYPATH)
	$(CC) $(CFLAGS) -o $(BINARYPATH)/$@ $^ $(LDFLAGS)

# remove NIST originals in project
removeOriginals:
	@rm -f PQCgenKAT_kem.c randombytes.h rng.c rng.h

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




#####  Makefile for compilation on Unix-like operative systems  ####
#
#CC=gcc
#ifeq "$(CC)" "gcc"
#    COMPILER=gcc
#else ifeq "$(CC)" "clang"
#    COMPILER=clang
#endif
#
#ARCHITECTURE=_ARM_
#ifeq "$(ARCH)" "x64"
#    ARCHITECTURE=_AMD64_
#else ifeq "$(ARCH)" "x86"
#    ARCHITECTURE=_X86_
#else ifeq "$(ARCH)" "ARM"
#    ARCHITECTURE=_ARM_
#endif
#
#USE_OPT_LEVEL=_OPTIMIZED_GENERIC_
#
#ifeq "$(GENERATION_A)" "AES128"
#    USE_GENERATION_A=_AES128_FOR_A_
#else ifeq "$(GENERATION_A)" "SHAKE128"
#    USE_GENERATION_A=_SHAKE128_FOR_A_
#else
#    USE_GENERATION_A=_AES128_FOR_A_
#endif
#
#ifeq "$(ARCH)" "ARM"
#    ARM_SETTING=-lrt
#endif
#
#USING_OPENSSL=_USE_OPENSSL_
#ifeq "$(USE_OPENSSL)" "FALSE"
#    USING_OPENSSL=NO_OPENSSL
#endif
#
#OPENSSL_INCLUDE_DIR=/usr/include
#OPENSSL_LIB_DIR=/usr/lib
#
#AR=ar rcs
#RANLIB=ranlib
#LN=ln -s
#
#CFLAGS= -O3 -std=gnu11 -Wall -Wextra -DNIX -D $(ARCHITECTURE) -D $(USE_OPT_LEVEL) -D $(USE_GENERATION_A) -D $(USING_OPENSSL)
#ifeq "$(CC)" "gcc"
#CFLAGS+= -march=native
#endif
#ifeq "$(USE_OPENSSL)" "FALSE"
#LDFLAGS=-lm
#else
#CFLAGS+= -I$(OPENSSL_INCLUDE_DIR)
#LDFLAGS=-lm -L$(OPENSSL_LIB_DIR) -lssl -lcrypto
#endif
#
#
#.PHONY: all check clean prettyprint
#
#all: lib640 tests KATS
#
#objs/%.o: %.c
#	@mkdir -p $(@D)
#	$(CC) -c  $(CFLAGS) $< -o $@
#
#objs/frodo640.o: frodo640.c
#	@mkdir -p $(@D)
#	$(CC) -c  $(CFLAGS) $< -o $@
#
#
## RAND
#objs/random/random.o: random/random.h
#RAND_OBJS := objs/random/random.o
#
## KEM_FRODO
#KEM_FRODO640_OBJS := $(addprefix objs/, frodo640.o util.o)
#KEM_FRODO640_HEADERS := api.h config.h frodo_macrify.h
#$(KEM_FRODO640_OBJS): $(KEM_FRODO640_HEADERS)
#
## AES
#AES_OBJS := $(addprefix objs/aes/, aes.o aes_c.o)
#AES_HEADERS := $(addprefix aes/, aes.h)
#$(AES_OBJS): $(AES_HEADERS)
#
## SHAKE
#SHAKE_OBJS := $(addprefix objs/sha3/, fips202.o)
#SHAKE_HEADERS := $(addprefix sha3/, fips202.h)
#$(SHAKE_OBJS): $(SHAKE_HEADERS)
#
#lib640: $(KEM_FRODO640_OBJS) $(RAND_OBJS) $(AES_OBJS) $(SHAKE_OBJS)
#	rm -rf frodo
#	mkdir frodo
#	$(AR) frodo/libfrodo.a $^
#	$(RANLIB) frodo/libfrodo.a
#
#tests: lib640 tests/ds_benchmark.h
#	$(CC) $(CFLAGS) -L./frodo tests/test_KEM640.c -lfrodo $(LDFLAGS) -o frodo/test_KEM $(ARM_SETTING)
#
#
#lib640_for_KATs: $(KEM_FRODO640_OBJS) $(AES_OBJS) $(SHAKE_OBJS)
#	$(AR) frodo/libfrodo_for_testing.a $^
#	$(RANLIB) frodo/libfrodo_for_testing.a
#
#KATS: lib640_for_KATs
#ifeq "$(GENERATION_A)" "SHAKE128"
#	$(CC) $(CFLAGS) -L./frodo tests/PQCtestKAT_kem_shake.c tests/rng.c -lfrodo_for_testing $(LDFLAGS) -o frodo/PQCtestKAT_kem_shake $(ARM_SETTING)
#else
#	$(CC) $(CFLAGS) -L./frodo tests/PQCtestKAT_kem.c tests/rng.c -lfrodo_for_testing $(LDFLAGS) -o frodo/PQCtestKAT_kem $(ARM_SETTING)
#endif
#
#check: tests
#
#clean:
#	rm -rf objs *.req frodo
#	find . -name .DS_Store -type f -delete
#
#prettyprint:
#	astyle --style=java --indent=tab --pad-header --pad-oper --align-pointer=name --align-reference=name --suffix=none *.h */*.h */*.c
