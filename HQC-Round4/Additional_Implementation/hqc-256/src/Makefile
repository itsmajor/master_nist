# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../lib/fips202
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -Wall -fomit-frame-pointer -Ofast -march=native -w
LDFLAGS = -lssl -lcrypto
# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas

# add all c files in this directory
CSRC := $(wildcard *.c)
# add common path (nothing happen if not found)
COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c)
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o))

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: removeOriginals $(TARGET)

.PHONY: all clean removeOriginals

clean:
	@rm -f -R ./.build/ $(TARGET)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# remove NIST originals in project
removeOriginals:
	@rm -f PQCgenKAT_kem.c randombytes.h rng.c rng.h

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

-include $(DEP)


#ifeq ($(ROOT),)
#ROOT:=.
#endif
#
#CC:=gcc
#
#CFLAGS:=-O3 -std=c99 -funroll-all-loops -flto -pedantic -Wall -Wextra
#
#SHA3_SRC:=$(ROOT)/lib/fips202/fips202.c
#SHA3_INCLUDE:=-I $(ROOT)/lib/fips202
#
#SRC:=$(ROOT)/src/
#INCLUDE:=-I $(ROOT)/src
#LIB:=$(SHA3_INCLUDE)
#
#MAIN_HQC:=$(ROOT)/src/main_hqc.c
#MAIN_KAT:=$(ROOT)/src/main_kat.c
#
#HQC_OBJS:=vector.o reed_muller.o reed_solomon.o fft.o gf.o gf2x.o code.o parsing.o hqc.o kem.o shake_ds.o shake_prng.o
#HQC_OBJS_VERBOSE:=vector.o reed_muller.o reed_solomon-verbose.o fft.o gf.o gf2x.o code-verbose.o parsing.o hqc-verbose.o kem-verbose.o shake_ds.o shake_prng.o
#LIB_OBJS:= fips202.o
#
#BIN:=bin
#BUILD:=bin/build
#
#folders:
#	@/bin/echo -e "\n### Creating folders"
#	mkdir -p $(BUILD)
#
#fips202.o: | folders
#	@/bin/echo -e "\n### Compiling fips202"
#	$(CC) $(CFLAGS) -c $(SHA3_SRC) $(SHA3_INCLUDE) -o $(BUILD)/$@
#
#%.o: $(SRC)/%.c | folders
#	@/bin/echo -e "\n### Compiling $@"
#	$(CC) $(CFLAGS) -c $< $(INCLUDE) $(LIB) -o $(BUILD)/$@
#
#%-verbose.o: $(SRC)/%.c | folders
#	@/bin/echo -e "\n### Compiling $@ (verbose mode)"
#	$(CC) $(CFLAGS) -c $< $(INCLUDE) $(LIB) -D VERBOSE -o $(BUILD)/$@
#
#hqc-128: $(HQC_OBJS) $(LIB_OBJS) | folders
#	@/bin/echo -e "\n### Compiling hqc-128"
#	$(CC) $(CFLAGS) $(MAIN_HQC) $(addprefix $(BUILD)/, $^) $(INCLUDE) $(LIB) -o $(BIN)/$@
#
#hqc-128-kat: $(HQC_OBJS) $(LIB_OBJS) | folders
#	@/bin/echo -e "\n### Compiling hqc-128 KAT"
#	$(CC) $(CFLAGS) $(MAIN_KAT) $(addprefix $(BUILD)/, $^) $(INCLUDE) $(LIB) -o $(BIN)/$@
#
#hqc-128-verbose: $(HQC_OBJS_VERBOSE) $(LIB_OBJS) | folders
#	@/bin/echo -e "\n### Compiling hqc-128 (verbose mode)"
#	$(CC) $(CFLAGS) $(MAIN_HQC) $(addprefix $(BUILD)/, $^) $(INCLUDE) $(LIB) -D VERBOSE -o $(BIN)/$@
#
#
#clean:
#	rm -f PQCkemKAT_*
#	rm -f vgcore.*
#	rm -rf ./bin
