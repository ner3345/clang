#include <stdio.h>
#include <arpa/inet.h>

int main(){
	unsigned int x = 0x12345678;
	printf("%p\n",x);
	printf("%p\n",htonl(x));
	return 0;
}
