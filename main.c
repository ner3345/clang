#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

typedef void (*fun)(void);
void func(){
	printf("%s\n", "Hello World");
	for (int i = 0; i < 100; ++i)
	{
		usleep(1000000);
		printf("%d\n", i);
	}
}

int main(int argv,char **argc){
	fun = func;
	fun();

	
	return 0;
}
