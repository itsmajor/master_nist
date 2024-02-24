This README file accompanies the LOTUS submission package for the NIST PQC Standardization Process.

/
Root directory
- README.txt: this file.

/Supporting_Documentation
- LOTUS_CoverSheet.pdf: contains the cover sheet.
- LOTUS_specifications_2017Nov30.pdf: contains the algorithm specifications and supporting Documentation.

/Reference_Implementation
This folder contains the reference implementation of LOTUS-PKE and LOTUS-KEM.
- kem/genKAT_batch.sh: generates KATs which will be placed in the /KAT/kem directory.
- encrypt/genKAT_batch.sh: generates KATs which will be placed in the /KAT/encrypt directory.
- kem/testKAT_batch.sh: generates KATs and automatically compares with KATs placed in /KAT/kem directory.
- encrypt/testKAT_batch.sh: generates KATs and automatically compares with KATs placed in /KAT/encrypt directory.

/Optimized_Implementation
This folder contains the optimized implementation of LOTUS-PKE and LOTUS-KEM.
- kem/testKAT_batch.sh: generates KATs and automatically compares with KATs placed in /KAT/kem directory.
- encrypt/testKAT_batch.sh: generates KATs and automatically compares with KATs placed in /KAT/encrypt directory.

/Additional_Implementation
This folder contains the AVX2-based implementation of LOTUS-PKE and LOTUS-KEM.
- kem/testKAT_batch.sh: generates KATs and automatically compares with KATs placed in /KAT/kem directory.
- encrypt/testKAT_batch.sh: generates KATs and automatically compares with KATs placed in /KAT/encrypt directory.

/IP_Statement
This folder contains the scanned pdf files of IP statements. The hard copies will be given to NIST in person.
