#include "gen_randomness.h"


void shake4x_hash(uint8_t *out, unsigned long long outlen,
		 uint8_t *in, unsigned long long inlen) {

  //we assume outlen and inlen can be divided by 4;
  unsigned long long offset_out = outlen / 4;
  unsigned long long offset_in = inlen / 4;

#if KINDI_KEM_SHAKEMODE == 128
  shake128x4(out, out + offset_out, out + 2 * offset_out, out + 3 * offset_out, offset_out,
      in, in+offset_in, in +2*offset_in, in+3*offset_in, offset_in);
#elif KINDI_KEM_SHAKEMODE == 256
  shake256x4(out, out + offset_out, out + 2 * offset_out, out + 3 * offset_out, offset_out,
        in, in+offset_in, in +2*offset_in, in+3*offset_in, offset_in);
#endif



}

//H
void kindi_crypto_stream(uint8_t *out, unsigned long long outlen,
		const uint8_t *in, unsigned long long inlen) {


  //we assume outlen can be divided by 4;
  unsigned long long offset = outlen / 4;

  // make each of the four inputs different in order to get different output streams
  uint8_t *in1 = malloc(inlen+1);
  uint8_t *in2 = malloc(inlen+1);
  uint8_t *in3 = malloc(inlen+1);
  uint8_t *in4 = malloc(inlen+1);

  memcpy(in1,in,inlen);
  memcpy(in2,in,inlen);
  memcpy(in3,in,inlen);
  memcpy(in4,in,inlen);

  in1[inlen]=0;
  in2[inlen]=1;
  in3[inlen]=2;
  in4[inlen]=3;

#if KINDI_KEM_SHAKEMODE == 128
  shake128x4(out, out + offset, out + 2 * offset, out + 3 * offset, offset,
      in1, in2, in3, in4, inlen+1);
#elif KINDI_KEM_SHAKEMODE == 256
  shake256x4(out, out + offset, out + 2 * offset, out + 3 * offset, offset,
        in1, in2, in3, in4, inlen+1);
#endif
  free(in1);
  free(in2);
  free(in3);
  free(in4);


}

//H' for d <- H'(s1)
void kindi_crypto_stream_2(uint8_t *out, unsigned long long outlen,
		const uint8_t *in, unsigned long long inlen) {


  uint8_t *ext_in = malloc(inlen+1);
  memcpy(ext_in,in,inlen);

  // padding with 4 so it differs with every input stream from kindi_crypto_stream
  ext_in[inlen]=4;
  crypto_hash(out,outlen,ext_in,inlen+1);
  free(ext_in);


}

#define BUFFERLEN (KINDI_KEM_BYTESLOGRSECP1 * KINDI_KEM_L * KINDI_KEM_N + KINDI_KEM_MESSAGEBYTES)

void gen_randomness(poly_d *s, uint8_t *u, uint8_t *s1) {
#if KINDI_KEM_S1BITS == 1
	int i, a, x;

	uint8_t *buffer = malloc(BUFFERLEN);
	kindi_crypto_stream(buffer, BUFFERLEN, s1, KINDI_KEM_S1SIZE);

	int tmp, pos = 0;

	// set s1=LSB in s1_bar
	for (i = 0; i < KINDI_KEM_S1SIZE; i++)
		for (a = 0; a < 8; a++)
			s[0][a + 8 * i] = (s1[i] >> a) & 1;

	// set missing bits in s1_bar
	for (a = 0; a < KINDI_KEM_N; a++) {
		tmp = 0;
		for (x = 0; x < KINDI_KEM_BYTESLOGRSECP1; x++)
			tmp += (int) buffer[pos++] << x * 8;

		tmp &= KINDI_KEM_RSEC - 1;
		tmp = tmp << 1;
		s[0][a] = s[0][a] + tmp - KINDI_KEM_RSEC;
	}

	// set bits for s_2,..., s_L
	for (i = 1; i < KINDI_KEM_L; i++) {
		for (a = 0; a < KINDI_KEM_N; a++) {
			tmp = 0;
			for (x = 0; x < KINDI_KEM_BYTESLOGRSECP1; x++)
				tmp += (int) buffer[pos++] << x * 8;

			s[i][a] = (tmp & ((KINDI_KEM_RSEC << 1) - 1)) - KINDI_KEM_RSEC;
		}
	}

	memcpy(u, buffer + pos, KINDI_KEM_MESSAGEBYTES);

	free(buffer);
#elif KINDI_KEM_S1BITS == 2
	int i, a, x;

		uint8_t *buffer = malloc(BUFFERLEN);
		kindi_crypto_stream(buffer, BUFFERLEN, s1, KINDI_KEM_S1SIZE);

		int tmp, pos = 0;

		// set s1=LSB in s1_bar
		for (i = 0; i < KINDI_KEM_S1SIZE; i++)
			for (a = 0; a < 4; a++)
				s[0][a + 4 * i] = (s1[i] >> (2*a)) & 0x03;

		// set missing bits in s1_bar
		for (a = 0; a < KINDI_KEM_N; a++) {
			tmp = 0;
			for (x = 0; x < KINDI_KEM_BYTESLOGRSECP1; x++)
				tmp += (int) buffer[pos++] << x * 8;

			tmp &= (KINDI_KEM_RSEC>>1) - 1;
			tmp = tmp << 2;
			s[0][a] = s[0][a] + tmp - KINDI_KEM_RSEC;
		}

		// set bits for s_2,..., s_L
		for (i = 1; i < KINDI_KEM_L; i++) {
			for (a = 0; a < KINDI_KEM_N; a++) {
				tmp = 0;
				for (x = 0; x < KINDI_KEM_BYTESLOGRSECP1; x++)
					tmp += (int) buffer[pos++] << x * 8;

				s[i][a] = (tmp & ((KINDI_KEM_RSEC << 1) - 1)) - KINDI_KEM_RSEC;
			}
		}

		memcpy(u, buffer + pos, KINDI_KEM_MESSAGEBYTES);

		free(buffer);

#endif
}

