cd tests

NTRUNAME=ntrulpr1013
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=ntrulpr1277
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=ntrulpr653
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=ntrulpr761
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=ntrulpr857
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=ntrulpr953
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=sntrup1013
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=sntrup1277
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=sntrup653
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=sntrup761
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=sntrup857
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..

NTRUNAME=sntrup953
cd ${NTRUNAME}
echo "generate kat NTRU-Prime ${NTRUNAME}"
./kat kem/${NTRUNAME} > kat_kem.int 8> kat_kem.req 9> kat_kem.rsp
cd ..


cd ..