//
//  Student.hpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#ifndef Student_hpp
#define Student_hpp

#include <stdio.h>
#include <string>

using namespace std;
class Student{
private:
    string name;
    int age;
    string sex;
public:
    Student();
    Student(string,int,string);
    ~Student();
    void setName(string);
    string getName();
    void setAge(int);
    int getAge();
    void setSex(string);
    string getSex();
    void sayHi();
};

#endif /* Student_hpp */
