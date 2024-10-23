# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH)
#-O3 -march=native -w
LDFLAGS = -lm -lcrypto

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
CSRC := $(subst PQCgenKAT_signOrig.c, ,$(CSRC)) $(notdir $(COMMON:.c=.o)) fastrandombytes.c rng.c

# 4 kems to test them all, executable created in same folder
TARGET = PQCgenKAT_sign PQCgenKAT_sign_dec PQCgenKAT_sign_enc PQCgenKAT_sign_keygen

## all files will be created in BUILD_DIR
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o))

all: removeOriginals $(TARGET)

.PHONY: all clean removeOriginals

clean:
	@rm -f -R ./.build/ $(TARGET)

#DEP=$(OBJ:.o=.d)

$(TARGET): $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) -o $@ $^ $(LDFLAGS)

# remove NIST originals in project
removeOriginals:
	@:

$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

#$(BUILD_DIR)/%.o: %.s
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) -c -o $@ $<

#$(BUILD_DIR)/%.d: %.c
#	@mkdir -p `dirname $@`
#	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@

#-include $(DEP)





# original:

#RM := rm -rf
#
#TARGET := Gaussian-pqNTRUSign-1024
#
#LIBS := -lm -lcrypto
#
#C_SRCS += \
#  PQCgenKAT_sign.c \
#  ../common/packing.c \
#  ../common/param.c \
#  ../common/pqNTRUSign.c \
#  ../common/rng.c \
#  sign.c \
#  ../common/crypto_hash_sha512.c \
#  ../common/crypto_stream.c \
#  ../common/fastrandombytes.c \
#  ../common/shred.c \
#  ../common/DGS.c \
#  ../common/NTT.c \
#  ../common/misc.c \
#  ../common/poly.c
#
#OBJS += \
#  PQCgenKAT_sign.o \
#  ../common/packing.o \
#  ../common/param.o \
#  ../common/pqNTRUSign.o \
#  ../common/rng.o \
#  sign.o \
#  ../common/crypto_hash_sha512.o \
#  ../common/crypto_stream.o \
#  ../common/fastrandombytes.o \
#  ../common/shred.o \
#  ../common/DGS.o \
#  ../common/NTT.o \
#  ../common/misc.o \
#  ../common/poly.o
#
#C_DEPS += \
#  PQCgenKAT_sign.d \
#  ../common/packing.d \
#  ../common/param.d \
#  ../common/pqNTRUSign.d \
#  ../common/rng.d \
#  sign.d \
#  ../common/crypto_hash_sha512.d \
#  ../common/crypto_stream.d \
#  ../common/fastrandombytes.d \
#  ../common/shred.d \
#  ../common/DGS.d \
#  ../common/NTT.d \
#  ../common/misc.d \
#  ../common/poly.d
#
#%.o: ../%.c
#	@echo 'Building file: $<'
#	@echo 'Invoking: Cross GCC Compiler'
#	gcc -I/usr/local/include/ -I/usr/include/ -O3 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
#	@echo 'Finished building: $<'
#	@echo ' '
#
#
#
#
## Add inputs and outputs from these tool invocations to the build variables
#
## All Target
#all: $(TARGET)
#
## Tool invocations
#$(TARGET): $(OBJS) $(USER_OBJS)
#	@echo 'Building target: $@'
#	@echo 'Invoking: Cross GCC Linker'
#	gcc  -o $(TARGET) $(OBJS) $(USER_OBJS) $(LIBS)
#	@echo 'Finished building target: $@'
#	@echo ' '
#
## Other Targets
#clean:
#	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) $(TARGET)
#	-@echo ' '
#
#.PHONY: all clean dependents
#.SECONDARY:
#
#
