#include <stdlib.h>
#include <stdio.h>
int main(int argc, char *args[]) {
   printf("Build version:%i_%s\n","""JENKINS_BUILD_NO""", """GIT_COMMIT_HASH""");
   printf("There are %i args\n", argc);
}
