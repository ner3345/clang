#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include "io.h"

int main(int argc,char *argv[]){
	
	if(argc<3){
		fprintf(stderr,"Error:%s\n",argv[0]);
		exit(1);
	}
	int fd_in = open(argv[1],O_RDONLY);

	if(fd_in<0){
		fprintf(stderr,"Error:%s\n",strerror(errno));
		exit(1);
	}

	int fd_out = open(argv[2],O_WRONLY | O_CREAT | O_TRUNC,0644);

	if(fd_out<0){
		fprintf(stderr,"Error:%s\n",strerror(errno));
		exit(1);
	}

	mycp(fd_in,fd_out);
	close(fd_in);
	close(fd_out);

	return 0;
}
