SEC     = 128
CC	= gcc
LDFLAGS = -lssl -lcrypto
CFLAGS	= -ansi -O3 -march=native -mtune=native -fomit-frame-pointer -funroll-loops -Wall -Wextra -D_SEC=$(SEC) -w -std=c11
DIR     = lotus$(SEC)
KDIR	= ../PQCgenKAT
INCL	= -I./$(DIR) -I../../_common/NIST -I../../_common/tomas
SRC	= $(wildcard $(DIR)/*.c) $(KDIR)/rng.c
OBJ	= $(SRC:.c=.o)
vpath % ../../../_common/NIST
vpath %.c ../../../_common/tomas

TARGET1 = PQCgenKAT_kem
TARGET2 = PQCgenKAT_kem_dec
TARGET3 = PQCgenKAT_kem_enc
TARGET4 = PQCgenKAT_kem_keygen

all: $(TARGET1) $(TARGET2) $(TARGET3) $(TARGET4)

$(TARGET1) $(TARGET2) $(TARGET3) $(TARGET4) : $(OBJ)
	$(CC) $(CFLAGS) $(INCL) -o $(DIR)/$@ ../../../_common/tomas/$@.c $^ $(LDFLAGS)

#PQCgenKAT_kem: $(OBJ)
#	@mkdir -p tests/lotus$(SEC)
#	$(CC) $(CFLAGS) $(INCL) -o tests/lotus$(SEC)/$@ $(KDIR)/PQCgenKAT_kem.c $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) $(INCL) -o $@ -c $<

clean:
	rm -f $(OBJ) $(DIR)/$(TARGET1) $(DIR)/$(TARGET2) $(DIR)/$(TARGET3) $(DIR)/$(TARGET4)
