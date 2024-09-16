SEC     = 128
# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -fomit-frame-pointer -Ofast -march=native -w -D_SEC=$(SEC)
LDFLAGS = -lssl -lcrypto
#-lm -lXKCP

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
TARGET = PQCgenKAT_encrypt PQCgenKAT_encrypt_keygen #PQCgenKAT_encrypt_dec PQCgenKAT_encrypt_enc

## all files will be created in BUILD_DIR
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: removeOriginals $(TARGET)

.PHONY: all clean removeOriginals

clean:
	rm -f -R ./.build/ $(TARGET)

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

