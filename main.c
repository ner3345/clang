#include <stdio.h>
#include <time.h>
#include <stdlib.h>
int myinput();
int main(int argv,char *argc[]){
	//1 布 2剪  3锤子
	while(1){
		int tmp;
		tmp = myinput();
		if (tmp!=0)
		{
			printf("%s\n", "程序退出,再见!!");
			break;
		}
	}

	return 0;
}

int myinput(){
	printf("%s\n", "Hello 请输入你的数字:");
	int myint;
	scanf("%d",&myint);
	if(myint>100){
		return -1;
	}
	// srand((int)time(0));
	int ran = rand()%3+1;
	printf("你输入的是:%d,%d\n", myint,ran);
	return 0;
}

int bidui(int u,int c){
	if (u=c)
	{	
		return 0;
	}else if(){

	}else if(){
		
	}
}
