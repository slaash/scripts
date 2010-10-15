#include <unistd.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
        long sz = sysconf(_SC_PAGESIZE);
        printf("memory pagesize on this box : %i\n", sz);
        return 0;
}

