MODE=2
HASH=AES

# for AES an extra gcc flag is needed,
ifeq ($(HASH),AES)
	AESFLAG=-DDILITHIUM_USE_AES
    EXTRA_SRC := symmetric-aes.c aes256ctr.c
else
    EXTRA_SRC := symmetric-shake.c
endif

# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
PROJECTNAME=$(shell basename $(CURDIR))
BINARYPATH=../../../bin/$(PROJECTNAME)_MODE$(MODE)_$(HASH)
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -I $(PATHTOROOT)_common/tomas_sign -O3 -march=native -mtune=native -w -fPIC -DDILITHIUM_MODE=$(MODE) $(AESFLAG)
LDFLAGS = -lcrypto

# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas_sign
vpath % $(BINARYPATH)

# add all c files in this directory
CSRC := $(wildcard *.c)
# add common path (nothing happen if not found)
COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c)
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c $(EXTRA_SRC)

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_sign PQCgenKAT_sign_dec PQCgenKAT_sign_enc PQCgenKAT_sign_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build/mode$(MODE)_$(HASH)

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: $(TARGET)
	@:

.PHONY: all clean

clean:
	@rm -f -R ./.build/ $(BINARYPATH)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) $$(BUILD_DIR)/$$(patsubst %,%.o,$$@)
	mkdir -p $(BINARYPATH)
	$(CC) $(CFLAGS) -o $(BINARYPATH)/$@ $^ $(LDFLAGS)

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



#CC ?= /usr/bin/cc
#CFLAGS += -Wall -Wextra -Wpedantic -Wmissing-prototypes -Wredundant-decls \
#  -Wshadow -Wvla -Wpointer-arith -O3 -march=native -mtune=native
#NISTFLAGS += -Wno-unused-result -O3
#SOURCES = sign.c packing.c polyvec.c poly.c ntt.c reduce.c rounding.c
#HEADERS = config.h params.h api.h sign.h packing.h polyvec.h poly.h ntt.h \
#  reduce.h rounding.h symmetric.h randombytes.h
#KECCAK_SOURCES = $(SOURCES) fips202.c symmetric-shake.c
#KECCAK_HEADERS = $(HEADERS) fips202.h
#AES_SOURCES = $(SOURCES) fips202.c aes256ctr.c symmetric-aes.c
#AES_HEADERS = $(HEADERS) fips202.h aes256ctr.h
#
#.PHONY: all speed shared clean
#
#all: PQCgenKAT_sign
#
#speed: \
#  test/test_mul \
#  test/test_speed2 \
#  test/test_speed3 \
#  test/test_speed5 \
#  test/test_speed2aes \
#  test/test_speed3aes \
#  test/test_speed5aes
#
#shared: \
#  libpqcrystals_dilithium2_ref.so \
#  libpqcrystals_dilithium3_ref.so \
#  libpqcrystals_dilithium5_ref.so \
#  libpqcrystals_dilithium2aes_ref.so \
#  libpqcrystals_dilithium3aes_ref.so \
#  libpqcrystals_dilithium5aes_ref.so \
#  libpqcrystals_fips202_ref.so \
#  libpqcrystals_aes256ctr_ref.so
#
#libpqcrystals_fips202_ref.so: fips202.c fips202.h
#	$(CC) -shared -fPIC $(CFLAGS) -o $@ $<
#
#libpqcrystals_aes256ctr_ref.so: aes256ctr.c aes256ctr.h
#	$(CC) -shared -fPIC $(CFLAGS) -o $@ $<
#
#libpqcrystals_dilithium2_ref.so: $(SOURCES) $(HEADERS) symmetric-shake.c
#	$(CC) -shared -fPIC $(CFLAGS) -DDILITHIUM_MODE=2 \
#	  -o $@ $(SOURCES) symmetric-shake.c
#
#libpqcrystals_dilithium3_ref.so: $(SOURCES) $(HEADERS) symmetric-shake.c
#	$(CC) -shared -fPIC $(CFLAGS) -DDILITHIUM_MODE=3 \
#	  -o $@ $(SOURCES) symmetric-shake.c
#
#libpqcrystals_dilithium5_ref.so: $(SOURCES) $(HEADERS) symmetric-shake.c
#	$(CC) -shared -fPIC $(CFLAGS) -DDILITHIUM_MODE=5 \
#	  -o $@ $(SOURCES) symmetric-shake.c
#
#libpqcrystals_dilithium2aes_ref.so: $(SOURCES) $(HEADERS) symmetric-aes.c
#	$(CC) -shared -fPIC $(CFLAGS) -DDILITHIUM_MODE=2 -DDILITHIUM_USE_AES \
#	   -o $@ $(SOURCES) symmetric-aes.c
#
#libpqcrystals_dilithium3aes_ref.so: $(SOURCES) $(HEADERS) symmetric-aes.c
#	$(CC) -shared -fPIC $(CFLAGS) -DDILITHIUM_MODE=3 -DDILITHIUM_USE_AES \
#	   -o $@ $(SOURCES) symmetric-aes.c
#
#libpqcrystals_dilithium5aes_ref.so: $(SOURCES) $(HEADERS) symmetric-aes.c
#	$(CC) -shared -fPIC $(CFLAGS) -DDILITHIUM_MODE=5 -DDILITHIUM_USE_AES \
#	   -o $@ $(SOURCES) symmetric-aes.c
#
#test/test_dilithium2: test/test_dilithium.c randombytes.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=2 \
#	  -o $@ $< randombytes.c $(KECCAK_SOURCES)
#
#test/test_dilithium3: test/test_dilithium.c randombytes.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=3 \
#	  -o $@ $< randombytes.c $(KECCAK_SOURCES)
#
#test/test_dilithium5: test/test_dilithium.c randombytes.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=5 \
#	  -o $@ $< randombytes.c $(KECCAK_SOURCES)
#
#test/test_dilithium2aes: test/test_dilithium.c randombytes.c $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=2 -DDILITHIUM_USE_AES \
#	  -o $@ $< randombytes.c $(AES_SOURCES)
#
#test/test_dilithium3aes: test/test_dilithium.c randombytes.c $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=3 -DDILITHIUM_USE_AES \
#	  -o $@ $< randombytes.c $(AES_SOURCES)
#
#test/test_dilithium5aes: test/test_dilithium.c randombytes.c $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=5 -DDILITHIUM_USE_AES \
#	  -o $@ $< randombytes.c $(AES_SOURCES)
#
#test/test_vectors2: test/test_vectors.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=2 \
#	  -o $@ $< $(KECCAK_SOURCES)
#
#test/test_vectors3: test/test_vectors.c $(KECCAK_SOURCES) $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=3 \
#	  -o $@ $< $(KECCAK_SOURCES)
#
#test/test_vectors5: test/test_vectors.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=5 \
#	  -o $@ $< $(KECCAK_SOURCES)
#
#test/test_vectors2aes: test/test_vectors.c $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=2 -DDILITHIUM_USE_AES \
#	  -o $@ $< $(AES_SOURCES)
#
#test/test_vectors3aes: test/test_vectors.c $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=3 -DDILITHIUM_USE_AES \
#	  -o $@ $< $(AES_SOURCES)
#
#test/test_vectors5aes: test/test_vectors.c $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=5 -DDILITHIUM_USE_AES \
#	  -o $@ $< $(AES_SOURCES)
#
#test/test_speed2: test/test_speed.c test/speed_print.c test/speed_print.h \
#  test/cpucycles.c test/cpucycles.h randombytes.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=2 \
#	  -o $@ $< test/speed_print.c test/cpucycles.c randombytes.c \
#	  $(KECCAK_SOURCES)
#
#test/test_speed3: test/test_speed.c test/speed_print.c test/speed_print.h \
#  test/cpucycles.c test/cpucycles.h randombytes.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=3 \
#	  -o $@ $< test/speed_print.c test/cpucycles.c randombytes.c \
#	  $(KECCAK_SOURCES)
#
#test/test_speed5: test/test_speed.c test/speed_print.c test/speed_print.h \
#  test/cpucycles.c test/cpucycles.h randombytes.c $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=5 \
#	  -o $@ $< test/speed_print.c test/cpucycles.c randombytes.c \
#	  $(KECCAK_SOURCES)
#
#test/test_speed2aes: test/test_speed.c test/speed_print.c test/speed_print.h \
#  test/cpucycles.c test/cpucycles.h randombytes.c $(AES_SOURCES) $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=2 -DDILITHIUM_USE_AES \
#	  -o $@ $< test/speed_print.c test/cpucycles.c randombytes.c \
#	  $(AES_SOURCES)
#
#test/test_speed3aes: test/test_speed.c test/speed_print.c test/speed_print.h \
#  test/cpucycles.c test/cpucycles.h randombytes.c $(AES_SOURCES) $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=3 -DDILITHIUM_USE_AES \
#	  -o $@ $< test/speed_print.c test/cpucycles.c randombytes.c \
#	  $(AES_SOURCES)
#
#test/test_speed5aes: test/test_speed.c test/speed_print.c test/speed_print.h \
#  test/cpucycles.c test/cpucycles.h randombytes.c $(AES_SOURCES) $(AES_HEADERS)
#	$(CC) $(CFLAGS) -DDILITHIUM_MODE=5 -DDILITHIUM_USE_AES \
#	  -o $@ $< test/speed_print.c test/cpucycles.c randombytes.c \
#	  $(AES_SOURCES)
#
#test/test_mul: test/test_mul.c randombytes.c $(KECCAK_SOURCES) $(KECCAK_HEADERS)
#	$(CC) $(CFLAGS) -UDBENCH -o $@ $< randombytes.c $(KECCAK_SOURCES)
#
#PQCgenKAT_sign: PQCgenKAT_sign.c rng.c rng.h $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(NISTFLAGS) -o $@ $< rng.c $(KECCAK_SOURCES) $(LDFLAGS) -lcrypto
#
#PQCgenKAT_sign2: PQCgenKAT_sign.c rng.c rng.h $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=2 \
#	  -o $@ $< rng.c $(KECCAK_SOURCES) $(LDFLAGS) -lcrypto
#
#PQCgenKAT_sign3: PQCgenKAT_sign.c rng.c rng.h $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=3 \
#	  -o $@ $< rng.c $(KECCAK_SOURCES) $(LDFLAGS) -lcrypto
#
#PQCgenKAT_sign5: PQCgenKAT_sign.c rng.c rng.h $(KECCAK_SOURCES) \
#  $(KECCAK_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=5 \
#	  -o $@ $< rng.c $(KECCAK_SOURCES) $(LDFLAGS) -lcrypto
#
#PQCgenKAT_sign2aes: PQCgenKAT_sign.c rng.c rng.h $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=2 -DDILITHIUM_USE_AES \
#	  -o $@ $< rng.c $(AES_SOURCES) $(LDFLAGS) -lcrypto
#
#PQCgenKAT_sign3aes: PQCgenKAT_sign.c rng.c rng.h $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=3 -DDILITHIUM_USE_AES \
#	  -o $@ $< rng.c $(AES_SOURCES) $(LDFLAGS) -lcrypto
#
#PQCgenKAT_sign5aes: PQCgenKAT_sign.c rng.c rng.h $(AES_SOURCES) \
#  $(AES_HEADERS)
#	$(CC) $(NISTFLAGS) -DDILITHIUM_MODE=5 -DDILITHIUM_USE_AES \
#	  -o $@ $< rng.c $(AES_SOURCES) $(LDFLAGS) -lcrypto
#
#clean:
#	rm -f *~ test/*~ *.gcno *.gcda *.lcov
#	rm -f libpqcrystals_dilithium2_ref.so
#	rm -f libpqcrystals_dilithium3_ref.so
#	rm -f libpqcrystals_dilithium5_ref.so
#	rm -f libpqcrystals_dilithium2aes_ref.so
#	rm -f libpqcrystals_dilithium3aes_ref.so
#	rm -f libpqcrystals_dilithium5aes_ref.so
#	rm -f libpqcrystals_fips202_ref.so
#	rm -f libpqcrystals_aes256ctr_ref.so
#	rm -f test/test_dilithium2
#	rm -f test/test_dilithium3
#	rm -f test/test_dilithium5
#	rm -f test/test_dilithium2aes
#	rm -f test/test_dilithium3aes
#	rm -f test/test_dilithium5aes
#	rm -f test/test_vectors2
#	rm -f test/test_vectors3
#	rm -f test/test_vectors5
#	rm -f test/test_vectors2aes
#	rm -f test/test_vectors3aes
#	rm -f test/test_vectors5aes
#	rm -f test/test_speed2
#	rm -f test/test_speed3
#	rm -f test/test_speed5
#	rm -f test/test_speed2aes
#	rm -f test/test_speed3aes
#	rm -f test/test_speed5aes
#	rm -f test/test_mul
#	rm -f PQCgenKAT_sign2
#	rm -f PQCgenKAT_sign3
#	rm -f PQCgenKAT_sign5
#	rm -f PQCgenKAT_sign2aes
#	rm -f PQCgenKAT_sign3aes
#	rm -f PQCgenKAT_sign5aes