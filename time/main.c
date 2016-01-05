#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
	
	time_t tt = time(NULL);
	printf("%ld\n",tt);
	struct tm *t,*gt;
	//t = localtime(&tt);
	gt = gmtime(&tt);
	time(&tt);
	printf("%s\n",asctime(gt));
	printf("%s\n",ctime(&tt));

	return 0;
}
