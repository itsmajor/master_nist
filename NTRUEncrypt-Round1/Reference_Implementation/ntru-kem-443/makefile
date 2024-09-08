.SECONDEXPANSION:
CC=gcc
CFLAGS= -I. -I../../../_common/NIST -I../common -Wall -fomit-frame-pointer -Ofast -march=native -w
LDFLAGS = -lm -lcrypto
vpath % ../common
vpath % ../../../_common/NIST
vpath %.c ../../../_common/tomas

CSRC = $(wildcard *.c)
CSRC2 := $(wildcard ../common/*.c)
CSRC3 := $(CSRC) $(notdir $(CSRC2:.c=.o))

TARGET1 = PQCgenKAT_kem
TARGET2 = PQCgenKAT_kem_dec
TARGET3 = PQCgenKAT_kem_enc
TARGET4 = PQCgenKAT_kem_keygen

## don't change after here
BUILD_DIR = .build

OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC3:.c=.o))

all: $(TARGET1) $(TARGET2) $(TARGET3) $(TARGET4)

#output:
#	@echo CSRC2: $(CSRC2)
#	@echo CSRC3: $(CSRC3)

DEP=$(OBJ:.o=.d)

$(TARGET1) $(TARGET2) $(TARGET3) $(TARGET4) : $(OBJ) .build/$$(patsubst %,%.o,$$@)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)


$(BUILD_DIR)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.d: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) > $@


clean:
	rm -f -R ./.build/ $(TARGET1) $(TARGET2) $(TARGET3) $(TARGET4)

-include $(DEP)

