#
## CSCI 370 S10: Sample Makefile for OCCI compilation
#

CFLAGS = -I/usr/local/lib/Oracle/instantclient_11_2/sdk/include
LFLAGS = -L/usr/local/lib/Oracle/instantclient_11_2 -locci -lociei
all: main

main.o: main.cpp
	g++ -c $(CFLAGS) main.cpp

main: main.o
	g++ $(LFLAGS) -o main main.o

clean:
	rm main.o main
