#include "io.h"
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#define BUFF_LEN 1024

void mycp(int fd_in,int fd_out){
	char buff[BUFF_LEN] = {"\0"};
	ssize_t n;
	while((n = read(fd_in,buff,BUFF_LEN)) !=0){
		write(fd_out,buff,n);
	}

}



