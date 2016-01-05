#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(){
	pid_t pid;
	pid = fork();

	if(pid>0){
		printf("%d这是父进程!\n",pid);
	}else{
		sleep(2);
		printf("%d这是子进程!\n",pid);
	}
	return 0;
}
