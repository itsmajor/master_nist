OPENSSL_DIR=/usr

CC=cc

OPENSSL_INCLUDE_DIR=$(OPENSSL_DIR)/include
OPENSSL_LIB_DIR=$(OPENSSL_DIR)/lib

CFLAGS=-O3 -I$(OPENSSL_INCLUDE_DIR)
LDFLAGS=-L$(OPENSSL_LIB_DIR) -lcrypto -lssl


all:

	$(CC) $(CFLAGS) -c encrypt.c ntt.c ntt.h ntt_const.h $(LDFLAGS)
	$(CC) $(CFLAGS) -o R_EMBLEM_ref encrypt.o ntt.o $(LDFLAGS)
