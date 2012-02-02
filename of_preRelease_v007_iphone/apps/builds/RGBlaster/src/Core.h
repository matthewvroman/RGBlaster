//
//  Core.h
//  RGBlaster
//
//  Created by Matthew Vroman on 2/1/12.
//  Copyright (c) 2012 RGBeast. All rights reserved.
//

#ifndef RGBlaster_Core_h
#define RGBlaster_Core_h

#include "AtlasHandler.h"
#include "BasicObject.h"

#include "ofxSpriteSheetRenderer.h"

#include "Animations.h"

class Core : public BasicObject{
public:
    
    //constructor
    Core(float _x, float _y, float _scale, Color _color, Resolution _res):
    BasicObject(_x,_y,32,32,"",true){
        setColor(_color);
        setResolution(_res);
        initCore(_scale);
    };
    
    //destructor
    ~Core();
    
private:
    void initCore(float _s);
    
};

#endif
