//
//  Line.cpp
//  C++01
//
//  Created by Ner on 15/12/25.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Line.hpp"
#include <iostream>
using namespace std;
Line::Line(int _ax1,int _bx2,int _ay1,int _by2):a(_ax1,_ay1),b(_bx2,_by2)
{
    cout<<"LineConstruct"<<endl;
}

Line::~Line(){
    cout<<"LineDestruct"<<endl;
}

void Line::setA(int _x,int _y){
    a.x = _x;
    a.y = _y;
}

void Line::setB(int _x, int _y){
    b.x = _x;
    b.y = _y;
}

struct _point Line::getPoint(){
    struct _point p;
    p.ax = a.x;
    p.ay = a.y;
    p.bx = b.x;
    p.by = b.y;
    return p;
}
