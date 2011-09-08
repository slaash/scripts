#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

struct thread_info {    /* Used as argument to thread_start() */
	pthread_t thread_id;        /* ID returned by pthread_create() */
	int       thread_num;       /* Application-defined thread # */
	char     *argv_string;      /* From command-line argument */
};


void *say_hello(void *arg)
{
	struct thread_info *tinfo = (struct thread_info *) arg;
	printf("%d: Hello!\n",tinfo->thread_id);
	while (1){}
}

int main(char *argv[],int argc)
{
//	pthread_t thr;
	int ret;
	long t;
	char p;
	struct thread_info *tinfo;
	tinfo = calloc(1, sizeof(struct thread_info));
	ret=pthread_create(&tinfo->thread_id,NULL,say_hello,&tinfo->thread_num);
	printf("%d\n",ret);
	scanf("%c",&p);
	return 0;
}

