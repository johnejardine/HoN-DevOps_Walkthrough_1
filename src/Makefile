main.o: main.c
	cc -c main.c -D"JENKINS_BUILD_NO=${BUILD_ID}" -D"GIT_COMMIT_HASH=${GIT_COMMIT}" -o main.o
main: main.o
	cc -o main *.o
