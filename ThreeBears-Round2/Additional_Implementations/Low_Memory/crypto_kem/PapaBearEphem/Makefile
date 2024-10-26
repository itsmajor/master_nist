# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
CC=gcc
CFLAGS= -I. -I$(PATHTOROOT)_common/NIST -I../common -Wall -Os -std=c11 -march=native -w
LDFLAGS = -lm -lXKCP -lcrypto
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

all: rmOriginal_PQCgenKAT_kem $(TARGET)

.PHONY: all clean rmOriginal_PQCgenKAT_kem

clean:
	@rm -f -R ./.build/ $(TARGET)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# remove original PQCgenKAT_kem
rmOriginal_PQCgenKAT_kem:
	@rm -f -r NIST

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `#dirname $@`
	#$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

-include $(DEP)



#CC ?= cc
#CFLAGS ?= -Wall -Wextra -Wpedantic -Os -std=c11
#BUILDDIR ?= build
#
#SRCS = $(wildcard *.c) $(wildcard NIST/*.c)
#SRCS2 = $(subst NIST/,,$(SRCS:.c=.o))
#OBJS = $(addprefix $(BUILDDIR)/,$(SRCS2))
#
#.PHONY: clean all kat
#
#all: $(BUILDDIR)/genkat
#
#kat: $(BUILDDIR)/genkat
#	(cd $(BUILDDIR) && ./genkat)
#
#$(BUILDDIR)/%.o: %.c *.h
#	@mkdir -p $(BUILDDIR)
#	$(CC) $(CFLAGS) -I. -INIST -c -o $@ $<
#
#$(BUILDDIR)/%.o: NIST/%.c *.h NIST/*.h
#	@mkdir -p $(BUILDDIR)
#	$(CC) $(CFLAGS) -I. -INIST -c -o $@ $<
#
#$(BUILDDIR)/genkat: $(OBJS)
#	$(CC) $(LDFLAGS) -o $@ $^ -lkeccak -lcrypto
#
#clean:
#	rm -fr $(BUILDDIR)
