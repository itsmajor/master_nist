
#include "io.h"

#include "parameter.h"
#include "polynomial.h"


/*
	It compresses the array val[0..7] into n bytes, and stores them into string[0..(n-1)].
	For every 0<=i<=n-1, string[i] := LSB(val[7],i) || ... || LSB(val[0], i).
	For the full detail, see Section 9.3.3 of the document. 
*/
void compress(
		unsigned char * string, 
		const unsigned int * val, 
		const unsigned int number_of_bytes)
{
	unsigned int i;
	int j;	
	unsigned int temp;
	unsigned int value[8];

	for(j=7; j>=0; j--)
		value[j] = val[j]; 
	
	for(i=0; i<number_of_bytes; i++)
	{
		temp = 0;
		for(j=7; j>=0; j--)
		{
			temp = (temp<<1) + (value[j] & 0x1);
			value[j] = value[j]>>1;
		}
		string[i] = temp;
	}
}


/*
	It decompresses the array string[0..(n-1)] into 8 values, and stores them into value[0..7].
	For every 0<=i<=7, value[i] := LSB(string[n-1], i) || ... || LSB(string[0], i). 
	For the full detail, see Section 9.3.3 of the document. 
*/
void decompress(
		unsigned int * value, 
		const unsigned char * string, 
		const unsigned int number_of_bytes)
{
	int i,j;
	unsigned int temp;

	for(j=0; j<8; j++)
		value[j] = 0;

	for(i=number_of_bytes-1; i>=0; i--)
	{
		temp = string[i];
		for(j=0; j<8; j++)
		{
			value[j] = (value[j]<<1) + (temp & 0x1);
			temp = (temp>>1);
		}
	}
}

/*
	The array value[0..MLWE_N] is first divided into MLWE_N/8 block; 
	each block is compressed into n bytes, and is then stored into the appropriate position in the string[] array.
*/
void group_compress(
		unsigned char * string, 
		const unsigned int * value,
		const unsigned int number_of_bytes)
{
	unsigned int i;
	unsigned int str_index = 0, value_index = 0;

	for(i=0; i<MLWE_N/8; i++)
	{
		compress(string+str_index, value+value_index, number_of_bytes);

		value_index += 8;
		str_index += number_of_bytes;
	}
}


/*
	The array string[0...] is first divided into MLWE_N/8 block; 
	each block is decompressed into 8 values, and is then stored into the appropriate position in the value[0...] array. 
*/
void group_decompress(
		unsigned int * value, 
		const unsigned char * string,
		const unsigned int number_of_bytes)
{
	unsigned int i;
	unsigned int str_index = 0, value_index = 0;

	for(i=0; i<MLWE_N/8; i++)
	{
		decompress(value+value_index, string+str_index, number_of_bytes);

		value_index += 8;
		str_index += number_of_bytes;
	}
}


/*
	This function converts the given noise polynomial into a sequence of characters. 
	Note that initially every coefficient of poly is assumed in [q-eta, q+eta]. 
	We first shift this interval into an appropriate position so that very few bits suffices to encode this entire polynomial;
	Then, compress() is invoked.
	
*/
void pack_small_poly(unsigned char * string, const Polynomial *poly)
{
	unsigned int error[8];
	unsigned int i,j;
	unsigned int poly_index = 0, str_index = 0;
	
	for(i=0; i<MLWE_N/8; i++)
	{
		for(j=0; j<8; j++)
			error[j] = poly->coefficients[poly_index+j] - MLWE_Q + MLWE_BASE_FOR_SMALL_POLY;
		
		// 8 errors/values ->3 bytes
		compress(string+str_index, error, UNIT_BYTES_IN_SMALL_POLY);

		poly_index += 8;
		str_index += UNIT_BYTES_IN_SMALL_POLY;
	}
}


/*
	This function converts the given sequence of characters into a noise polynomial.
	Recall that in the pack_small_poly() procedure, shift is applied before compression. 
	Hence, we should shift every coefficient back into the interval [q-eta, q+eta] after decompression. 
*/
void unpack_small_poly(Polynomial * poly, const unsigned char * string)
{
	unsigned int i;

	group_decompress(poly->coefficients, string, UNIT_BYTES_IN_SMALL_POLY);
	
	for(i=0; i<MLWE_N; i++)
		poly->coefficients[i] +=  MLWE_Q - MLWE_BASE_FOR_SMALL_POLY;
}

// It converts the given truncated polynomial into a sequence of characters.
void pack_truncated_poly(unsigned char * string, const Polynomial *truncated_poly)
{
	group_compress(string, truncated_poly->coefficients, UNIT_BYTES_IN_TRUNCATED_POLY);
}

// It converts the given sequence of characters into a truncated polynomial.
void unpack_truncated_poly(Polynomial *truncated_poly, const unsigned char * string)
{
	group_decompress(truncated_poly->coefficients, string, UNIT_BYTES_IN_TRUNCATED_POLY);
}

 
// It converts the given truncated polynomial vector into a sequence of characters.
void pack_truncated_vector(unsigned char * string, const Polynomial truncated_vector[MLWE_ELL])
{
	unsigned int i;

	for(i=0; i<MLWE_ELL; i++)
		pack_truncated_poly(
			string + i* TRUNCATED_POLY_BYTES, 
			truncated_vector + i
		);
}


// It converts the given sequence of characters into a truncated polynomial vector.
void unpack_truncated_vector(Polynomial truncated_vector[], const unsigned char * string)
{
	unsigned int i;

	for(i=0; i<MLWE_ELL; i++)
		unpack_truncated_poly(
			truncated_vector + i, 
			string + i* TRUNCATED_POLY_BYTES
		);
}


// It converts the given noise polynomial vector into a sequence of characters.
void pack_small_vector(unsigned char * string, const Polynomial vector[MLWE_ELL])
{
	for(unsigned int i=0; i<MLWE_ELL; i++)
		pack_small_poly(string+i*SMALL_POLY_BYTES, vector+i);
}


// It converts the given sequence of characters into a noise polynomial vector.
void unpack_small_vector(Polynomial vector[MLWE_ELL], const unsigned char * string)
{
	for(unsigned int i=0; i<MLWE_ELL; i++)
		unpack_small_poly(vector+i, string+i*SMALL_POLY_BYTES);
}



