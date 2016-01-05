//
//  Student.cpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Student.hpp"
#include <iostream>
using namespace std;

Student::Student(string _name,int _age,string _sex):name(_name),age(_age),sex(_sex){
    
}
Student::~Student(){
    
}

void Student::setName(string _name){
    this->name = _name;
}

string Student::getName(){
    return this->name;
}

void Student::setAge(int _age){
    if (_age>0 && _age<100) {
        this->age = _age;
    }
}

int Student::getAge(){
    return this->age;
}

void Student::setSex(string _sex){
    if (_sex=="女" or _sex=="男") {
        this->sex = _sex;
    }
}

string Student::getSex(){
    return this->sex;
}

void Student::sayHi(){
    cout<<"名字是:"<<this->name<<endl;
    cout<<"性别是:"<<this->sex<<endl;
    cout<<"年龄是:"<<this->age<<endl;
}