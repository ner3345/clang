#include <stdio.h>
#include <netdb.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#define PORT 8000
#define MAX_LEN 1024

int main(){
	int serfd;
	int clifd[1024];
	serfd = socket(AF_INET,SOCK_STREAM,0);
	if(serfd<0){
		fprintf(stderr,"CREATE SOCKET ERROR!%s\n",strerror(errno));
		exit(1);
	}

	struct sockaddr_in seraddr,cliaddr;
	bzero(&seraddr,sizeof(seraddr));
	seraddr.sin_family = AF_INET;
	seraddr.sin_port = htons(PORT);
	seraddr.sin_addr.s_addr = INADDR_ANY;
	
	if(bind(serfd,(struct sockaddr*)&seraddr,sizeof(struct sockaddr_in))<0){
		fprintf(stderr,"BIND ERROR%s\n",strerror(errno));
		exit(1);
	}

	if(listen(serfd,10)<0){
		fprintf(stderr,"LISTEN ERROR:%s\n",strerror(errno));
		exit(1);
	}
	

	int maxfd = serfd;
	int maxi = -1;
	for(int i=0;i<1024;i++){
		clifd[i] = -1;
	}
	fd_set rest,allset;
	FD_ZERO(&allset);
	FD_SET(serfd,&allset);
	
	while(1){
		rset = allset;
		

	}
		

	return 0;
}
