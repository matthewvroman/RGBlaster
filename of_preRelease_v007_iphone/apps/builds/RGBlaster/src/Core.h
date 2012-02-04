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
    Core(float _x, float _y, float _scale=1.0, Color _color=RED, Resolution _res=BIT8, bool _flashing=false):
    BasicObject(_x,_y,32,32,"",true){
        setColor(_color);
        setResolution(_res);
        flashing=_flashing;
        scale=_scale;
        
        initCore();
    };
    
    void setColor(Color _color);
    
    //destructor
    ~Core();
    
private:
    void initCore();
    bool flashing;
    bool multicolor;
    
};

#endif
