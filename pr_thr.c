#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <pthread.h>
//#include <unistd.h>
//#include <sys/wait.h>

typedef struct str_thdata
{
    int thread_no;
    unsigned long long i;
} thdata;

void *is_prime(void *arg)
{
	thdata *data;            
	data = (thdata *) arg;  /* type cast to a pointer to thdata */
	int prim=1;
	unsigned long long j;

//	printf("Thread %d says %lld \n", data->thread_no, data->i);
	for (j=2;j<=sqrtl(data->i);j++){
		if (fmodl(data->i,j)==0){
			prim=0;
			break;
		}
	}
	if (prim==1){
		printf("%lld\n",data->i);
	}
	pthread_exit(0); /* exit */
}

int main(int argc,char* argv[])
{
printf("calculam de la %s la %s\n",argv[1],argv[2]);

unsigned long long i,from,to;
char prim;
from=atoll(argv[1]);
to=atoll(argv[2]);
int ret;
pthread_t thread;  /* thread variables */
thdata data;         /* structs to be passed to threads */

for (i=from;i<=to;i++){
	data.thread_no=i;
	data.i=i;
	ret=pthread_create(&thread,NULL,&is_prime,&data);
	pthread_join(thread, NULL);
}

exit(0);
}
