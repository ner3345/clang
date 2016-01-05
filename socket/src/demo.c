#include <stdio.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
int main(){
	int fd = socket(AF_INET,SOCK_STREAM,0);

	struct sockaddr_in sockfd;
	bzero(&sockfd,sizeof(sockfd));
	sockfd.sin_family = AF_INET;
	sockfd.sin_port = htons(8787);
	//sockfd.sin_addr.s_addr = 
	inet_pton(AF_INET,"192.168.0.109",&sockfd.sin_addr.s_addr);
	if(connect(fd,(struct sockaddr*)&sockfd,sizeof(sockfd))<0){
		printf("Connect Error...\n");
		exit(1);
	}
	write(fd,"lll",3);
	char buff[1024];
	//read(fd,buff,1024);
	//printf("Return Msg%s\n",buff);
	while(1){
		memset(buff,0,sizeof(buff));
		int n = read(fd,buff,1024);
		if(n>0)
			printf("%s\n",buff);
			//write(fd,"333",3);
		
	}
	close(fd);
	return 0;
}
