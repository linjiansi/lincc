CFLAGS=-std=c11 -g -static

lincc: main.c

test: lincc
	./test.sh

clean:
	rm -f lincc *.o *~ tmp*

.PHONY: test clean

