//
//  main.c
//  socket1
//
//  Created by Ner on 15/12/20.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include <stdio.h>
#include <netdb.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
int main(int argc, const char * argv[]) {
    int sfd,cfd;
    sfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sfd<0) {
        fprintf(stderr, "sockfd Error:%s\n",strerror(errno));
        exit(1);
    }
    
    struct sockaddr_in saddr,caddr;
    bzero(&saddr,sizeof(saddr));
    saddr.sin_family = AF_INET;
    saddr.sin_port = htons(8001);
    saddr.sin_addr.s_addr = INADDR_ANY;
    
    if (bind(sfd, (struct sockaddr *)&saddr, sizeof(saddr))<0) {
        fprintf(stderr, "Bind Error:%s\n",strerror(errno));
        exit(1);
    }
    
    if (listen(sfd, 20)<0) {
        fprintf(stderr, "Listen Error:%s\n",strerror(errno));
        exit(1);
    }
    socklen_t len = sizeof(caddr);
    char buff[1024];
    while (1) {
        cfd = accept(sfd, (struct sockaddr*)&caddr, &len);
        if (cfd>0) {
            int fid = fork();
            if (fid==0) {
                ssize_t n = read(cfd, buff, sizeof(buff));
                if (n>0) {
                    printf("MSG:%s\n",buff);
                    for (int i=0; i<5; i++) {
                        sleep(1);
                        write(cfd, "Hello ok!", 9);
                    }
                }
            }else{
//                close(sfd);
            }
        }
        
        
    }
    
    
    
                
    
    
    
    return 0;
}
