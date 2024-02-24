CC=gcc
CFLAGS_AVX = -Wall -fomit-frame-pointer -Ofast -msse2avx -mavx2 -march=native 
LIBS_AVX = -lm -lcrypto


CSRC = $(wildcard *.c) \
			$(wildcard keccak4x/*.c)


TARGET_AVX = kindi_cpa_avx



## don't change after here 

BUILD_DIR_AVX = .build_avx

OBJ_AVX=$(addprefix ${BUILD_DIR_AVX}/,$(CSRC:.c=.o)) 

all: $(TARGET_AVX)


DEP_AVX=$(OBJ_AVX:.o=.d)


$(TARGET_AVX): $(OBJ_AVX)
	$(CC) $(CFLAGS_AVX) -o $@ $^ $(LIBS_AVX)

$(BUILD_DIR_AVX)/%.o: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS_AVX) -c -o $@ $<

$(BUILD_DIR_AVX)/%.o: %.s
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS_AVX) -c -o $@ $<

$(BUILD_DIR_AVX)/%.d: %.c
	@mkdir -p `dirname $@`
	$(CC) $(CFLAGS_AVX) $< -MM -MT $(@:.d=.o) > $@

clean:
	rm -f -R ./.build/ $(TARGET)
	rm -f -R ./.build_avx/ $(TARGET_AVX)

-include $(DEP_AVX)
