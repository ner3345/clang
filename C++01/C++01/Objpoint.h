//
//  Objpoint.h
//  C++01
//
//  Created by Ner on 15/12/25.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#ifndef Objpoint_h
#define Objpoint_h

#include <iostream>
class Objpoint{
public:
    Objpoint(int,int);
    ~Objpoint();
    int getX();
    int getY();
    void pxpoint();
    void pypoint();
private:
    int x;
    int y;
};

#endif /* Objpoint_h */
