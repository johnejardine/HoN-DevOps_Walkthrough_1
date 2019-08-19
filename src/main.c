#include <stdlib.h>
#include <stdio.h>
int main(int argc, char *args[]) {
   printf("Build version:%04i_%.8s\n", BUILD_NO, COMMIT_HASH);
   printf("There are %i args\n", argc);
}
