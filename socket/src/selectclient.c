#include <stdio.h>
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
	sockfd.sin_port = htons(8000);
	//sockfd.sin_addr.s_addr = 
	inet_pton(AF_INET,"127.0.0.1",&sockfd.sin_addr.s_addr);
	if(connect(fd,(struct sockaddr*)&sockfd,sizeof(sockfd))<0){
		printf("Connect OK...\n");
		exit(1);
	}
	//write(fd,"lll",3);
	char buff[1024];
	read(fd,buff,1024);
	printf("%s\n",buff);
	while(1){
		memset(buff,0,sizeof(buff));
		/*int n = read(fd,buff,sizeof(buff));
		if(n>0)
			printf("%s\n",buff);*/
		char str[1024];
		scanf("%s",str);
		write(fd,str,strlen(str));
		int n = read(fd,buff,sizeof(buff));
		if(n>0)
			printf("%s\n",buff);
		if(!strcmp(buff,"exit")){
			close(fd);
		}
	}
	close(fd);
	return 0;
}
