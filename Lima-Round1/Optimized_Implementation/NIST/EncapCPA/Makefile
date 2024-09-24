# 6 security level: 1018, 1024, 1306, 1822, 2048, 2062
# (make LIMASZ=1018)
LIMASZ=1018

# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
PROJECTNAME=$(shell basename $(CURDIR))
BINARYPATH=../../../bin/$(PROJECTNAME)_$(LIMASZ)
CC=gcc
CFLAGS= -L./../../Lib -I./../../Lib -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -fomit-frame-pointer -Ofast -march=native -w
LDFLAGS = -lLima -lm -lXKCP -lcrypto

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
BUILD_DIR = .build/$(LIMASZ)

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: cleanBuild removeOriginals $(TARGET)

.PHONY: all clean removeOriginals cleanBuild

clean:
	@rm -f -R ./.build/ $BINARYPATH/* $(TARGET)

DEP=$(OBJ:.o=.d)

# kem.o need to be rebuild with param -DLIMASZ=
#cleanBuild:
#	rm -f $(BUILD_DIR)/*.o

$(TARGET): $(OBJ) $$(BUILD_DIR)/$$(patsubst %,%.o,$$@)
	mkdir -p $(BINARYPATH)
	$(CC) $(CFLAGS) -DLIMASZ=$(LIMASZ) -o $(BINARYPATH)/$@ $^ $(LDFLAGS)

# remove NIST originals in project
removeOriginals:
	@rm -f PQCgenKAT_kem.c randombytes.h rng.c rng.h

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -DLIMASZ=$(LIMASZ) -c -o $@ $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -DLIMASZ=$(LIMASZ) -c -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

-include $(DEP)



#CC = gcc
 #CFLAGS = -Wall -Wextra -pedantic -std=c11 -g -L./../../Lib -I./../../Lib -O3 -march=native
 #LIBS = -lLima -lXKCP -lcrypto -lm
 #
 #all: KATFiles
 #
 #PQCgenKAT_encrypt-2048.exe:  encrypt.c api.h rng.c rng.h PQCgenKAT_encrypt.c
 #	$(CC) $(CFLAGS) -DLIMASZ=2048 PQCgenKAT_encrypt.c encrypt.c rng.c -o PQCgenKAT_encrypt-2048.exe $(LIBS)
 #
 #PQCgenKAT_encrypt-1018.exe:  encrypt.c api.h rng.c rng.h PQCgenKAT_encrypt.c
 #	$(CC) $(CFLAGS) -DLIMASZ=1018 PQCgenKAT_encrypt.c encrypt.c rng.c -o PQCgenKAT_encrypt-1018.exe $(LIBS)
 #
 #PQCgenKAT_encrypt-1306.exe:  encrypt.c api.h rng.c rng.h PQCgenKAT_encrypt.c
 #	$(CC) $(CFLAGS) -DLIMASZ=1306 PQCgenKAT_encrypt.c encrypt.c rng.c -o PQCgenKAT_encrypt-1306.exe $(LIBS)
 #
 #PQCgenKAT_encrypt-1822.exe:  encrypt.c api.h rng.c rng.h PQCgenKAT_encrypt.c
 #	$(CC) $(CFLAGS) -DLIMASZ=1822 PQCgenKAT_encrypt.c encrypt.c rng.c -o PQCgenKAT_encrypt-1822.exe $(LIBS)
 #
 #PQCgenKAT_encrypt-2062.exe:  encrypt.c api.h rng.c rng.h PQCgenKAT_encrypt.c
 #	$(CC) $(CFLAGS) -DLIMASZ=2062 PQCgenKAT_encrypt.c encrypt.c rng.c -o PQCgenKAT_encrypt-2062.exe $(LIBS)
 #
 #PQCgenKAT_encrypt-1024.exe:  encrypt.c api.h rng.c rng.h PQCgenKAT_encrypt.c
 #	$(CC) $(CFLAGS) -DLIMASZ=1024 PQCgenKAT_encrypt.c encrypt.c rng.c -o PQCgenKAT_encrypt-1024.exe $(LIBS)
 #
 #KATFiles: PQCgenKAT_encrypt-2048.exe PQCgenKAT_encrypt-1018.exe PQCgenKAT_encrypt-1306.exe PQCgenKAT_encrypt-1822.exe PQCgenKAT_encrypt-2062.exe PQCgenKAT_encrypt-1024.exe
 #	./PQCgenKAT_encrypt-2048.exe
 #	./PQCgenKAT_encrypt-1018.exe
 #	./PQCgenKAT_encrypt-1306.exe
 #	./PQCgenKAT_encrypt-1822.exe
 #	./PQCgenKAT_encrypt-2062.exe
 #	./PQCgenKAT_encrypt-1024.exe
 #
 #clean:
 #	rm *.exe *.rsp *.req