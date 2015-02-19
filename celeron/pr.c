#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main(int argc,char* argv[])
{
unsigned long long i,j,from,to;
char prim;
printf("calculam de la %s la %s\n\n",argv[1],argv[2]);
from=atoll(argv[1]);
to=atoll(argv[2]);
for (i=from;i<=to;i++){
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
}
return 0;
}

