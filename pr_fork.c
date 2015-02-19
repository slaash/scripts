#include <stdio.h>
#include <math.h>
#include <stdlib.h>
//#include <unistd.h>
//#include <sys/wait.h>

int main(int argc,char* argv[])
{
printf("calculam de la %s la %s\n",argv[1],argv[2]);

unsigned long long i,j,from,to;
char prim;
from=atoll(argv[1]);
to=atoll(argv[2]);
int parallel=10;
int running=0;
pid_t pid;
int status;
int rez;

for (i=from;i<=to;i++){
	pid=fork();
	if (pid==0){
		prim=1;
		for (j=2;j<=sqrtl(i);j++){
			if (fmodl(i,j)==0){
				prim=0;
				break;
			}
		}
		if (prim==1){
			printf("%lld\n",i);
		}
		exit(0);
	}
	else{
		running++;
		if (running>=parallel){
			wait(&status);
			running--;
		}
	}
}

rez=wait(&status);
while (rez>0){
	rez=wait(&status);
}

return 0;
}

