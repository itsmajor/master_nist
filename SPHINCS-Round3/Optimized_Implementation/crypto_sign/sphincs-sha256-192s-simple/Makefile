# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -O3 -march=native -w
LDFLAGS = -lcrypto

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

.PHONY: all clean removeNIST

removeNIST:
	@rm -f rng.c rng.h PQCgenKAT_sign.c

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




#LDLIBS=-lcrypto
#CC = /usr/bin/gcc
#CFLAGS = -Wall -Wextra -Wpedantic -O3 -std=c99
#
#HASH = haraka
#THASH = robust
#
#SOURCES =          address.c rng.c wots.c utils.c fors.c sign.c hash_$(HASH).c thash_$(HASH)_$(THASH).c
#HEADERS = params.h address.h rng.h wots.h utils.h fors.h api.h  hash.h thash.h
#
#ifeq ($(HASH),shake256)
#	SOURCES += fips202.c
#	HEADERS += fips202.h
#endif
#ifeq ($(HASH),haraka)
#	SOURCES += haraka.c
#	HEADERS += haraka.h
#endif
#ifeq ($(HASH),sha256)
#	SOURCES += sha256.c
#	HEADERS += sha256.h
#endif
#
#DET_SOURCES = $(SOURCES:rng.%=rng.%)
#DET_HEADERS = $(HEADERS:rng.%=rng.%)
#
#TESTS = test/wots \
#		test/fors \
#		test/spx \
#
#BENCHMARK = test/benchmark
#
#.PHONY: clean test benchmark
#
#default: PQCgenKAT_sign
#
#all: PQCgenKAT_sign tests benchmarks
#
#tests: $(TESTS)
#
#test: $(TESTS:=.exec)
#
#benchmarks: $(BENCHMARK)
#
#benchmark: $(BENCHMARK:=.exec)
#
#PQCgenKAT_sign: PQCgenKAT_sign.c $(DET_SOURCES) $(DET_HEADERS)
#	$(CC) $(CFLAGS) -o $@ $(DET_SOURCES) $< -lcrypto
#
#test/%: test/%.c $(SOURCES) $(HEADERS)
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) $< $(LDLIBS)
#
#test/haraka: test/haraka.c $(filter-out haraka.c,$(SOURCES)) $(HEADERS)
#	$(CC) $(CFLAGS) -o $@ $(filter-out haraka.c,$(SOURCES)) $< $(LDLIBS)
#
#test/%.exec: test/%
#	@$<
#
#clean:
#	-$(RM) $(TESTS)
#	-$(RM) $(BENCHMARK)
#	-$(RM) PQCgenKAT_sign
#	-$(RM) PQCsignKAT_*.rsp
#	-$(RM) PQCsignKAT_*.req
