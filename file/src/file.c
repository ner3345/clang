#include <stdio.h>
#include <fcntl.h>

int main(){
	
	int fd = open("bb.txt",O_RDONLY);
	
	printf("fd:%d\n",fd);
	return 0;
}
