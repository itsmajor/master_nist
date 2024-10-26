# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -fomit-frame-pointer -Ofast -march=native -w
LDFLAGS = -lcrypto

# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas_encrypt

# add all c files in this directory
CSRC := $(wildcard *.c)
# add common path (nothing happen if not found)
COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c)
# remove PQCgenKAT_encrypt.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_encrypt.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_encrypt PQCgenKAT_encrypt_dec PQCgenKAT_encrypt_enc PQCgenKAT_encrypt_keygen

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
	@rm -f PQCgenKAT_encrypt.c randombytes.h rng.c rng.h

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



#
#CFLAGS    = -g -Wall  -O3
#
#
#
#all: akcn-mlwe
#
#SOURCES =   kem.c polynomial.c  reduce.c io.c akcn.c vector.c
#HEADERS =   polynomial.h  parameter.h  reduce.h  io.h akcn.h vector.h
#
#akcn-mlwe: $(SOURCES) $(HEADERS)   akcn-mlwe.c rng.c rng.h
#	gcc $(CFLAGS) -o $@ $(SOURCES) rng.c akcn-mlwe.c -lcrypto
#
#
#PQCgenKAT_kem: $(SOURCES) $(HEADERS)  PQCgenKAT_kem.c rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c PQCgenKAT_kem.c -lcrypto
#
#
#akcn-mlwe-KATgen: $(SOURCES) $(HEADERS)  akcn-mlwe-KATgen.c rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c akcn-mlwe-KATgen.c -lcrypto
#
#
#
#akcn-mlwe-intermediate-gen: $(SOURCES) $(HEADERS)  akcn-mlwe-intermediate-gen.c rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c akcn-mlwe-intermediate-gen.c -lcrypto
#
#
#speed: $(SOURCES) $(HEADERS)  speed.c  rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) rng.c   speed.c -lcrypto
#
#
#
#
#.PHONY: clean test
#
#test:
#	.akcn-mlwe
#
#clean:
#	-$(RM) *.o
#	-$(RM) -r akcn-mlwe
#

#
#CFLAGS    = -g -Wall  -O3
#
#all: akcn-mlwe-cca
#
#SOURCES =  myOpenSSL.c encrypt.c polynomial.c  reduce.c io.c akcn.c vector.c
#HEADERS =  myOpenSSL.h polynomial.h  parameter.h  reduce.h  io.h akcn.h vector.h
#
#akcn-mlwe-cca: $(SOURCES) $(HEADERS)   akcn-mlwe-cca.c rng.c rng.h
#	gcc $(CFLAGS) -o $@ $(SOURCES) rng.c akcn-mlwe-cca.c -lcrypto
#
#PQCgenKAT_encrypt: $(SOURCES) $(HEADERS)  PQCgenKAT_encrypt.c rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c PQCgenKAT_encrypt.c -lcrypto
#
#speed: $(SOURCES) $(HEADERS)  speed.c rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c speed.c -lcrypto
#
#encrypt_KATgen: $(SOURCES) $(HEADERS)  encrypt_KATgen.c rng.c rng.h
#	$(CC) $(CFLAGS) -o $@ $(SOURCES) -I. rng.c encrypt_KATgen.c -lcrypto
#
#
#
#
#.PHONY: clean test
#
#test:
#	.akcn-mlwe-cca
#
#clean:
#	-$(RM) *.o
#	-$(RM) -r akcn-mlwe-cca
#
