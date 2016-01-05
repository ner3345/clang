#include <stdio.h>
#include <netdb.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#define PORT 8000
#define MAX_LEN 1024

int main(){
	int serfd,clifd;
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
	socklen_t len = sizeof(cliaddr);
	while(1){
		clifd = accept(serfd,(struct sockaddr*)&cliaddr,&len);
		char *str = "Link ok ..";
		write(clifd,str,strlen(str));

		int wd = fork();
		if(wd==0){
			int i;
			//printf("workpid:%d,clint:%d\n",getpid(),clifd);
			/*for(i=0;i<10;i++){
				sleep(2);
				write(clifd,"2",1);
			}*/
			char buff[1024];
			while(1){
				int n = read(clifd,buff,1024);
				if(n>0)
					printf("workpid:%d,clifd:%d,:%s\n",getpid(),clifd,buff);
			//char ex[1024];
			//scanf("%s",&ex);
				write(clifd,buff,n);
			}
		}else{
			//printf("parent 1\n");
		}
	}


	return 0;
}
