# need for $$(patsubst %,%.o,$$@)
.SECONDEXPANSION:
# eval path to root
PATHTOROOT = $(shell cd ../_common/ 2> /dev/null && echo "../")$(shell cd ../../_common 2> /dev/null && echo "../../")$(shell cd ../../../_common 2> /dev/null && echo "../../../")$(shell cd ../../../../_common 2> /dev/null && echo "../../../../")$(shell cd ../../../../../_common 2> /dev/null && echo "../../../../../")$(shell cd ../../../../../../_common 2> /dev/null && echo "../../../../../../")
PROJECTCOMMONPATH=../common
CC=gcc
CFLAGS= -I . -I $(PATHTOROOT)_common/NIST -I $(PROJECTCOMMONPATH) -fomit-frame-pointer -Ofast -march=native -w
LDFLAGS = -lm -lcrypto

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


#TARGET := ntru-pke-443
#
#LIBS := -lm -lcrypto
#
#C_SRCS += \
#  NTRUEncrypt.c \
#  PQCgenKAT_encrypt.c \
#  encrypt.c \
#  packing.c \
#  param.c \
#  ../common/rng.c \
#  poly.c \
#  ../common/crypto_hash_sha512.c \
#  ../common/crypto_stream.c \
#  ../common/fastrandombytes.c \
#  ../common/shred.c
#
#OBJS += \
#  NTRUEncrypt.o \
#  PQCgenKAT_encrypt.o \
#  encrypt.o \
#  packing.o \
#  param.o \
#  ../common/rng.o \
#  poly.o \
#  ../common/crypto_hash_sha512.o \
#  ../common/crypto_stream.o \
#  ../common/fastrandombytes.o \
#  ../common/shred.o
#
#C_DEPS += \
#  NTRUEncrypt.d \
#  PQCgenKAT_encrypt.d \
#  encrypt.d \
#  packing.d \
#  param.d \
#  ../common/rng.d \
#  poly.d \
#  ../common/crypto_hash_sha512.d \
#  ../common/crypto_stream.d \
#  ../common/fastrandombytes.d \
#  ../common/shred.d
#
#
#
#%.o: %.c
#	@echo 'Building file: $<'
#	@echo 'Invoking: Cross GCC Compiler'
#	gcc -I/usr/include -O3 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
#	@echo 'Finished building: $<'
#	@echo ' '
#
#poly/%.o: poly/%.c
#	@echo 'Building file: $<'
#	@echo 'Invoking: Cross GCC Compiler'
#	gcc -I/usr/include -O3 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
#	@echo 'Finished building: $<'
#	@echo ' '
#
#rng/%.o: rng/%.c
#	@echo 'Building file: $<'
#	@echo 'Invoking: Cross GCC Compiler'
#	gcc -I/usr/include -O3 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
#	@echo 'Finished building: $<'
#	@echo ' '
#
#RM := rm -rf
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
