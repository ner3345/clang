//
//  Objpoint.cpp
//  C++01
//
//  Created by Ner on 15/12/25.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Objpoint.h"
using namespace std;
Objpoint::Objpoint(int _x,int _y){
    x = _x;
    y = _y;
    cout<<this<<endl;
}

Objpoint::~Objpoint(){
    cout<<"析构函数.."<<endl;
}

int Objpoint::getX(){
    return x;
}

int Objpoint::getY(){
    return y;
}

void Objpoint::pxpoint(){
    cout<<&x<<endl;
}

void Objpoint::pypoint(){
    cout<<&y<<endl;
}
