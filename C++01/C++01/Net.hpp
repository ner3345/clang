//
//  Net.hpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#ifndef Net_hpp
#define Net_hpp

#include <stdio.h>
#include <string>
using namespace std;
class Net{
    int fd;
public:
    Net(string ip,int port);
    ~Net();
    int getsockfd();
};

#endif /* Net_hpp */
