//
//  enums.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/10/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles the enums of the App
//               These allow for easy incrementing/decrementing of the various values

#ifndef RGBlaster_enums_h
#define RGBlaster_enums_h

enum Resolution {
    
	BIT8=0,
    BIT16=1,
    BIT32=2
	
};

enum Color {
    RED=0,
    GREEN=1,
    BLUE=2
};

enum MovementType {
    ZIGZAG=0,
    CIRCLE=1,
    CIRCEXPAND=2
};

enum ObjectType {
    BLASTER=0,
    SHIP=1,
    MISSILE=2,
    EXPLOSION=3
};

#endif
