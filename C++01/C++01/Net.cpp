//
//  Net.cpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Net.hpp"
#include <string>
#include <netdb.h>
#include <unistd.h>
#include <sys/socket.h>
#include <iostream>
using namespace std;
Net::Net(string ip,int port){
    int fd;
    fd = socket(AF_INET,SOCK_STREAM,0);
    if (fd<0) {
        _exit(1);
    }
    
    struct sockaddr_in seraddr;
    memset(&seraddr, 0, sizeof(seraddr));
    seraddr.sin_family = AF_INET;
    seraddr.sin_port = htons(port);
    seraddr.sin_addr.s_addr = INADDR_ANY;
    socklen_t len = sizeof(seraddr);
    bind(fd, (struct sockaddr*)&seraddr, len);
    this->fd = fd;
}