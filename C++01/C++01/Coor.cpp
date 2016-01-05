//
//  Coor.cpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include "Coor.hpp"
#include <iostream>
using namespace std;
Coor::Coor(){
    cout<<"CoorConstruct"<<endl;
}

Coor::Coor(int _x,int _y){
    this->x = _x;
    this->y = _y;
    cout<<"CoorConstruct"<<endl;
}
Coor::~Coor(){
    cout<<"~Coordestruct"<<endl;
}