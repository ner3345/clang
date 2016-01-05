//
//  Cpobj.cpp
//  C++01
//
//  Created by Ner on 15/12/25.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Cpobj.h"
#include <iostream>
using namespace std;
Cpobj::Cpobj(int _p){
    p = _p;
    cout<<this<<endl;
    cout<<"构造函数"<<endl;
}

Cpobj::Cpobj(Cpobj &p){
    p=p.p;
    cout<<"复制构造函数.."<<endl;
}

Cpobj::~Cpobj(){
    cout<<"析构函数.."<<endl;
}

int Cpobj::getA(){
    return this->p;
}

void Cpobj::setA(int _p){
    this->p = _p;
}
