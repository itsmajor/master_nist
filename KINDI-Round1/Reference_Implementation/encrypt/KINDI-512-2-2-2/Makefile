CC=gcc
CFLAGS= -Wall -fomit-frame-pointer -Ofast -march=native
LIBS = -lm  -lcrypto

CSRC = $(wildcard *.c) 

TARGET = kindi_cpa


## don't change after here 
BUILD_DIR = .build


OBJ=$(addprefix ${BUILD_DIR}/,$(CSRC:.c=.o)) $(addprefix ${BUILD_DIR}/,$(SSRC:.s=.o)) 

all: $(TARGET)

DEP=$(OBJ:.o=.d)


$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

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
	rm -f -R ./.build/ $(TARGET)

-include $(DEP)

