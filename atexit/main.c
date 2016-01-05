#include <stdio.h>
#include <stdlib.h>

void fun(void){
	printf("atexit()\n");
}

int main(){
	atexit(fun);
	printf("Hello C!!\n");

	return 0;
}
