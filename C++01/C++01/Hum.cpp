//
//  Hum.cpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Hum.h"
#include <string>
#include <iostream>
using namespace std;
Hum::Hum(){
    this->name = "xxxxxx";
    this->sex = 1;
    this->age = 30;
}

Hum::~Hum(){
    cout<<"distruct ..run"<<endl;
}

void Hum::setName(char *name){
    this->name = name;
}

void Hum::setAge(int age){
    this->age = age;
}

void Hum::setSex(int sex){
    this->sex = sex;
}

char * Hum::getName(){
    return this->name;
}

int Hum::getAge(){
    return this->age;
}

char* Hum::getSex(){
    char *str;
    if(this->sex==1){
        str = "男";
    }else{
        str = "女";
    }
    return str;
}

void Hum::sayHi(){
    cout<<this->name<<"--"<<this->getAge()<<"--"<<this->getSex()<<endl;
}


