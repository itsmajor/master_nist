VERSION=-DPORS_k=24 -DMERKLE_h=5 -DGRAVITY_d=1  -DGRAVITY_c=10
#VERSION_S= -DPORS_k=24 -DMERKLE_h=5 -DGRAVITY_d=1  -DGRAVITY_c=10
#VERSION_M= -DPORS_k=32 -DMERKLE_h=5 -DGRAVITY_d=7  -DGRAVITY_c=15
#VERSION_L= -DPORS_k=28 -DMERKLE_h=5 -DGRAVITY_d=10 -DGRAVITY_c=14

# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../
PROJECTCOMMONPATH2=../primitives
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -I $(PROJECTCOMMONPATH2) -fomit-frame-pointer -Ofast -march=native -w $(VERSION)

LDFLAGS = -lssl -lcrypto

# add make lookup pathes
# common: if project use common folder
vpath % $(PROJECTCOMMONPATH)
vpath % $(PROJECTCOMMONPATH2)
# NIST: esp for rng.c
vpath % $(PATHTOROOT)_common/NIST
# 4kem path
vpath %.c $(PATHTOROOT)_common/tomas_sign

# add all c files in this directory
CSRC := $(wildcard *.c)
# add common path (nothing happen if not found)
COMMON := $(wildcard $(PROJECTCOMMONPATH)/*.c) $(wildcard $(PROJECTCOMMONPATH2)/*.c)
# remove PQCgenKAT_kem.c from CSRC and add all COMMON files without path. vpath and cflags imports will find it)
CSRC :=  $(subst PQCgenKAT_kem.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_sign PQCgenKAT_sign_dec PQCgenKAT_sign_enc PQCgenKAT_sign_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: $(TARGET)
	@:

.PHONY: all clean

clean:
	@rm -f -R ./.build/ $(TARGET)

DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

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



#SRC=$(wildcard *.c) $(wildcard primitives/*.c)
#OBJ=$(patsubst %.c, %.o, $(SRC))
#
#CFLAGS_COMMON=-std=c89 -pedantic -Wall -Wextra -Wno-long-long -march=native
#LDFLAGS=-lssl -lcrypto
#
#VERSION_S= -DPORS_k=24 -DMERKLE_h=5  -DGRAVITY_d=1  -DGRAVITY_c=10
#VERSION_M= -DPORS_k=32 -DMERKLE_h=5  -DGRAVITY_d=7  -DGRAVITY_c=15
#VERSION_L= -DPORS_k=28 -DMERKLE_h=5  -DGRAVITY_d=10 -DGRAVITY_c=14
#
#VERSION=$(VERSION_S)
#
#CFLAGS_COMMON+=$(VERSION)
#CFLAGS=$(CFLAGS_COMMON) -O3 -fomit-frame-pointer
#CFLAGS_SANITIZED=$(CFLAGS_COMMON) -fsanitize=address,undefined -g
#
#KERNEL_NAME := $(shell uname -s)
#ifeq ($(KERNEL_NAME), Darwin)
#	CFLAGS += -I/usr/local/opt/openssl/include
#	LDFLAGS += -L/usr/local/opt/openssl/lib
#endif
#
#all: help
#
#help:
#			@echo "Please choose a target:"
#			@echo "\tanalyze\t\t runs static analyzers"
#			@echo "\tbench\t\t runs speed benchmarks"
#			@echo "\tclean\t\t cleans up"
#			@echo "\tformat\t\t formats the code using .clang-format rules"
#
#bench:		$(SRC)
#			$(CC) $(CFLAGS) $^ -o bench $(LDFLAGS)
#			#./bench
#
#format:
#			clang-format -i *.c *.h
#
#analyze:
#			cppcheck . --std=c89
#			scan-build gcc -c $(CFLAGS_SANITIZED) *.c
#			cppclean .
#			rm -f *.o
#
#cloc:
#			cloc $(wildcard *.c) $(wildcard *.h)
#
#clean:
#			rm -f bench *.dSYM *.o
#
#.PHONY: clean format analyze cloc bench
#
