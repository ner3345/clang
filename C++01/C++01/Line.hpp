//
//  Line.hpp
//  C++01
//
//  Created by Ner on 15/12/25.
//  Copyright © 2015年 独自等待. All rights reserved.
//

#ifndef Line_hpp
#define Line_hpp

#include <stdio.h>
#include "Coor.hpp"
struct _point {
    int ax;
    int ay;
    int bx;
    int by;
};

class Line{
public:
    Line(int x1,int x2,int y1,int y2);
    ~Line();
    void setA(int ,int );
    void setB(int ,int );
    struct _point getPoint();
private:
    Coor a;
    Coor b;
};

#endif /* Line_hpp */
