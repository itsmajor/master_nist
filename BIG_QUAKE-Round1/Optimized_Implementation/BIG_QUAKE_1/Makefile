# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
# ld errors with gcc
CC=gcc-9
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -fomit-frame-pointer -Ofast -march=native -O4 -w
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
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

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


#CC = gcc-9
 #CFLAGS = -W -Wall -O4
 #LDFLAGS = -lssl -lcrypto
 #CPPFLAGS = -I. -I../../../_common/NIST
 #vpath %.h ../../../_common/NIST
 #vpath %.c ../../../_common/tomas
 #
 #OBJECTS = keccak.o kem.o m2e.o permutation.o gf.o poly.o goppa.o decode.o roots.o ../../../_common/NIST/rng.o
 #
 #.SECONDARY:
 #
 #.PHONY: force all
 #
 #all: PQCgenKAT_kem PQCgenKAT_kem_enc PQCgenKAT_kem_dec PQCgenKAT_kem_keygen
 #
 ##
 ## main targets
 ##
 #
 #PQCgenKAT_kem: $(OBJECTS) PQCgenKAT_kem.o
 #	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)
 #
 #PQCgenKAT_kem_enc: $(OBJECTS) PQCgenKAT_kem_enc.o
 #	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)
 #
 #PQCgenKAT_kem_dec: $(OBJECTS) PQCgenKAT_kem_dec.o
 #	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)
 #
 #PQCgenKAT_kem_keygen: $(OBJECTS) PQCgenKAT_kem_keygen.o
 #	$(CC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS)
 #
 ##
 ## cleaning rules
 ##
 #
 #clean:
 #	- /bin/rm -f *.o
 #
 #veryclean: clean
 #	- /bin/rm PQCgenKAT_kem PQCgenKAT_kem_enc PQCgenKAT_kem_dec PQCgenKAT_kem_keygen PQCkemKAT_*.req PQCkemKAT_*.rsp
 #
 ## DO NOT DELETE
 #
 #decode.o: goppa.h gf.h poly.h permutation.h
 #gf.o: gf.h rng.h
 #goppa.o: goppa.h gf.h poly.h permutation.h
 #kem.o: kem.h sizes.h gf.h api.h rng.h goppa.h poly.h permutation.h
 #kem.o: m2e.h
 #m2e.o: m2e.h sizes.h gf.h api.h
 #permutation.o: permutation.h rng.h
 #poly.o: gf.h poly.h
 #PQCgenKAT_kem.o: rng.h api.h sizes.h gf.h
 #rng.o: rng.h
 #roots.o: gf.h poly.h
