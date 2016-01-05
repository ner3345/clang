//
//  Cpobj.h
//  C++01
//
//  Created by Ner on 15/12/25.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#ifndef Cpobj_h
#define Cpobj_h

#include <iostream>

class Cpobj{
public:
    Cpobj(int);
    Cpobj(Cpobj &cp);
    ~Cpobj();
    int getA();
    void setA(int);
private:
    int p;
};

#endif /* Cpobj_h */
