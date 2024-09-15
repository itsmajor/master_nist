CC = gcc
CFLAGS = -w -pedantic -std=c11 -g -L./Lib -I./Lib -O3 -march=native
LIBS = -lLima -lXKCP -lm

all: lib
#Test-SubRoutines.exe

lib: 
	+ cd Lib; make 

#Test-SubRoutines.exe: Test-SubRoutines.c
	#$(CC) $(CFLAGS) Test-SubRoutines.c -o Test-SubRoutines.exe $(LIBS)

clean:
	rm -f -R *.exe
	+ cd Lib; make clean
	+ cd NIST; make clean
