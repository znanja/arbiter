all: clean .c.so main

main:
	gcc -Wall -O3 -std=c99 -I/opt/local/include -L/opt/local/lib -pthread -L. -ldaemon -lzmq -lmongoc arbiter.c -o arbiter

.c.so: daemon

daemon:
	gcc -Wall -O3 -c -fPIC -o daemon.o daemon.c
	gcc -shared -Wl,-install_name,libdaemon.so -o libdaemon.so daemon.o
	rm daemon.o

clean:
	rm -f *.so *.o
	rm -f arbiter