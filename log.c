#include <syslog.h>

int main(int argc, char* argv[])
{
printf ("Ati introdus: \"%s\"\n",argv[1]);
syslog(LOG_INFO,"%s",argv[1]);
return 1;
}

