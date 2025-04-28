# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
CC=gcc
CFLAGS= -I. -I$(PATHTOROOT)_common/NIST -I../common -Wall -fomit-frame-pointer -Ofast -march=native -w
#LDFLAGS = -lm -lssl-lcrypto
LDFLAGS = -lssl -lcrypto
# add make lookup pathes
# common: if project use common folder
vpath % ../common
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas

# add all c files in this directory
CSRC := $(wildcard *.c)
# add common path (nothing happen if not found)
COMMON := $(wildcard ../common/*.c)
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC := $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_kem PQCgenKAT_kem_dec PQCgenKAT_kem_enc PQCgenKAT_kem_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

# Default-Wert für SABER_L, falls nicht von außen gesetzt
SABER_DEFINE ?= -DSABER_L=3

all: rmOriginal_PQCgenKAT_kem $(TARGET)

.PHONY: all clean rmOriginal_PQCgenKAT_kem saber2 saber3 saber4

clean:
	@rm -f -R ./.build/ $(TARGET)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) $(CFLAGS) $(SABER_DEFINE) -o $@ $^ $(LDFLAGS)

# remove original PQCgenKAT_kem
rmOriginal_PQCgenKAT_kem:
	@rm -f PQCgenKAT_kem.c

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) $(SABER_DEFINE) -c -o $@ $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) $(SABER_DEFINE) -c -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

-include $(DEP)

# Zusätzliche Targets für SABER_L Auswahl
saber2:
	$(MAKE) SABER_DEFINE="-DSABER_L=2" all

saber3:
	$(MAKE) SABER_DEFINE="-DSABER_L=3" all

saber4:
	$(MAKE) SABER_DEFINE="-DSABER_L=4" all
