#include <stdio.h>
#include <netdb.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#define MAX_LEN 1024
#define PORT 8000
int serfd,clifd;

int main(){
	serfd = socket(AF_INET,SOCK_STREAM,0);
	if(serfd>0){
		printf("SOCKET OK\n");
	}
	char buff[MAX_LEN];
	struct sockaddr_in seraddr,cliaddr;
	bzero(&seraddr,sizeof(struct sockaddr_in));
	seraddr.sin_family = AF_INET;
	seraddr.sin_port = htons(PORT);
	seraddr.sin_addr.s_addr = INADDR_ANY;
	printf("地址成功绑定!\n");

	bind(serfd,(struct sockaddr*)&seraddr,sizeof(struct sockaddr));
	printf("bind ok\n");
	listen(serfd,10);

	printf("listen ok\n");
	socklen_t len = sizeof(cliaddr);
	
	clifd = accept(serfd,(struct sockaddr*)&cliaddr,&len);
	write(clifd,"..........",10);
	buff[len] = '\0';
	read(clifd,buff,len);
	printf("%s\n",buff);
	while(1){
	//	sleep(1);
		printf("Enter You Msg:\n");
		char ch[1024];
		scanf("%s",ch);
		//printf("%s,%d",ch,sizeof(ch));
		write(clifd,ch,sizeof(ch));
		memset(buff,0,sizeof(buff));
		int n = read(clifd,buff,len);
		if(n>0)
			printf("%s\n",buff);
		//char *bu;
		//write(clifd,buff,len);
		//scanf("%s",bu);
	}
	printf("close");
	close(clifd);
	close(serfd);
	return 0;
}
