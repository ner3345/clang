#include <stdio.h>
#include <stdlib.h>
extern char **environ;

void envlist(){
	int i=0;
	char *str;
	while((str=environ[i])!=NULL){
		printf("%s\n",str);
		i++;
	}
}

int main(int argv,char *argc[]){
	//envlist();
	if(argv<2){
		printf("Error:");
		exit(1);
	}
	char *s = getenv(argc[1]);
	printf("%s\n",s);
	return 0;
}
