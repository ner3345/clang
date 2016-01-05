//
//  main.cpp
//  C++01
//
//  Created by Ner on 15/12/24.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#include <iostream>
#include "Hum.h"
#include <string>
#include <string.h>
#include "Student.hpp"
#include "Coor.hpp"
#include "Line.hpp"
#include "Cpobj.h"
#include "Objpoint.h"
#define PS 12
using namespace std;

int getMax(int a,int b);
int getMax(int arr[],int count);


int main(int argc, const char * argv[]) {
    
//    string name;
//AA:
//    cout<<"please input:"<<endl;
//    getline(cin, name);
//    if (name.empty()) {
//        cout<<"you input string is empty.."<<endl;
//        goto AA;
//    }
//    
//    if (name=="liuhuawei") {
//        cout<<"你是一个天才"<<endl;
//    }
//    
//    Student *st = new Student("liuhuawei",30,"男");
//    st->sayHi();
//    
//    cout<<11<<endl;
//    cout<<"string size:"<<name.size()<<endl;
//    cout<<"one world:"<<name[0]<<endl;
//    cout<<"hello:"<<name<<endl;
    
//    Coor co[10];
//    co[0].x = 100;
//    co[0].y = 200;
//    
//    
//    Coor *c = new Coor[10];
//    c->x = 10;
//    c->y = 20;
//    for (int i=0; i<10; i++) {
//        cout<<c[i].x<<endl;
//        cout<<c[i].y<<endl;
//    }
//    delete []c;
//    c=NULL;
//    Line *li = new Line(1,2,34,56);
//    struct _point pp;
//    li->setA(20, 30);
//    pp = li->getPoint();
//    cout<<"x1:"<<pp.ax<<",\ty1:"<<pp.ay<<endl;
//    cout<<"x2:"<<pp.bx<<",\ty2:"<<pp.by<<endl;
//    delete li;
//    Cpobj cp(1);
//    Cpobj pp = cp;
//    pp.setA(10);
//    cp.setA(20);
//    cout<<pp.getA()<<endl;
//    cout<<cp.getA()<<endl;
    Objpoint *obj = new Objpoint(12,14);
    cout<<"X"<<obj->getX()<<"--Y:"<<obj->getY()<<endl;
    obj->pxpoint();
    cout<<obj<<endl;
    obj->pypoint();
    delete obj;
    
    return 0;
}

int getMax(int a,int b){
    return a>b?a:b;
}

int getMax(int arr[],int count){
    
    int t = arr[0];
    for (int i=1; i<count; i++) {
        if(t<arr[i]){
            t = arr[i];
        }
    }
    return t;
}
