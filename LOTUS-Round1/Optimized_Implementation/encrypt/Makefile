# replace by tomas Makefiles in subfolder

#SEC     = 128
#CC	= gcc
#LDFLAGS = -lssl -lcrypto
#CFLAGS	= -ansi -O3 -march=native -mtune=native -fomit-frame-pointer -funroll-loops -Wall -Wextra -D_SEC=$(SEC)
#DIR     = lotus$(SEC)
#KDIR	= ../PQCgenKAT
#INCL	= -I./$(DIR)
#SRC	= $(wildcard $(DIR)/*.c) $(KDIR)/rng.c
#OBJ	= $(SRC:.c=.o)
#
#PQCgenKAT_encrypt: $(OBJ)
#	@mkdir -p tests/lotus$(SEC)
#	$(CC) $(CFLAGS) $(INCL) -o tests/lotus$(SEC)/$@ $(KDIR)/PQCgenKAT_encrypt.c $^ $(LDFLAGS)
#
#%.o: %.c
#	$(CC) $(CFLAGS) $(INCL) -o $@ -c $<
#
#clean:
#	rm $(OBJ) PQCgenKAT_encrypt
