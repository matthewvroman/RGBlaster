//
//  Explosion.h
//  RGBlaster
//
//  Created by Matthew Vroman on 1/25/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#ifndef RGBlaster_Explosion_h
#define RGBlaster_Explosion_h
#include "ofMain.h"

#include "ofxSpriteSheetRenderer.h"

#import "Enums.h"
#import "Structs.h"
#import "Animations.h"

#import "BasicObject.h"

#import "SoundManager.h"
#import "AtlasHandler.h"

class Explosion : public BasicObject{
public:
    //constructor
    Explosion(int posX, int posY, Color _color, Resolution _res, float _scale=3, bool _gray=false);
    
    //destructor
    ~Explosion();
    
    float speed;
    
    void update();
    void draw();
    
    
    
    
private:
    
};


#endif
