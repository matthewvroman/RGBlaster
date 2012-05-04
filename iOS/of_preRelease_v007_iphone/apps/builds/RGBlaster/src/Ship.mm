//
//  Ship.mm
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

#include <iostream>
#include "Ship.h"

Ship::~Ship(){
}

//swap the animation of the ship based on the current resolution
void Ship::setResolution(Resolution _res){
    
    switch(int(_res)){
        case 0:
            sprite->animation=bit8Animation;
            break;
        case 1:
            sprite->animation=bit16Animation;
            break;
        case 2:
            sprite->animation=bit32Animation;
            break;
        default:
            sprite->animation=defaultAnimation;
            break;
    }
    
    BasicObject::setResolution(_res);
}