//
//  Ship.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/8/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Extends BasicObject
//               Ships are the basic enemies that come down from the top of the screen

#include "BasicObject.h"

class Ship : public BasicObject{
public:
    //constructor
    Ship(float _x, float _y, int _width, int _height, string _spriteSheet):
    BasicObject(_x,_y,_width,_height,_spriteSheet,false){};
    
    //destructor
    ~Ship();
    
    void setResolution(Resolution _res);

};