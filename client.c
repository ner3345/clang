#include <stdlib.h>
#include <stdio.h> 
#include <winsock2.h>
#include <string.h>
int main(int argv,char *argc[]){
	//if(argv<2){
	//	exit(-1);
	//}
	int port = 8787;
	char *addr = "192.168.1.153";
	printf("port:%d,addr:%s\n",port,addr);
	int sockfd = socket(AF_INET,SOCK_STREAM,0);
	
	struct sockaddr_in seraddr;
	bzero(&seraddr,sizeof(seraddr));
	seraddr.sin_family = AF_INET;
	seraddr.sin_port = htons(port);
	inet_pton(AF_INET,addr,&seraddr.sin_addr);

	if((connect(sockfd,(struct sockaddr*)&seraddr,sizeof(seraddr)))<0){
		printf("connect Error\n");
		exit(-1);
	}
	char buff[1024]={0};
	int n,i;
	while(1){
		//scanf("%s",buff);
		/*		n = read(sockfd,buff,strlen(buff));
				if(n>0){
					printf("Server Back:%s\n",buff);
				}*/
				sleep(1);
				//printf("%d\n",i);
				char s[1024];
				sprintf(s,"%d",i);
				write(sockfd,s,sizeof(s));
				n = read(sockfd,buff,sizeof(buff));
				if(n>0){
					printf("Server Back:%s\n",buff);
					bzero(&buff,sizeof(buff));
				}
				i++;
	}

	close(sockfd);



	return 0;
}
