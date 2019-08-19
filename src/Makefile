main.o: main.c
	cc -c main.c -D "BUILD_NO=${BUILD_NUMBER}" -D "COMMIT_HASH=\"${GIT_COMMIT}\"" -o main.o
#	cc -c main.c -D "BUILD_NO=${BUILD_NUMBER}" -D 'COMMIT_HASH='${GIT_COMMIT} -o main.o
main: main.o
	cc -o main *.o

all: main

clean:
	rm main main.o

.phoney: clean
