//
//  Hum.hpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#ifndef Hum_h
#define Hum_h

#include <stdio.h>

class Hum{
private:
    char *name;
    int age;
    int sex;
public:
    Hum();
    ~Hum();
    void sayHi();
    void setName(char *name);
    void setAge(int age);
    void setSex(int);
    char *getName();
    int getAge();
    char* getSex();
};

#endif /* Hum_hpp */
