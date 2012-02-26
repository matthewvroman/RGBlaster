//
//  Missile.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Object that chases ships after they have been targeted

#ifndef RGBlaster_Missile_h
#define RGBlaster_Missile_h
#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ofxSpriteSheetRenderer.h"

#import "Enums.h"
#import "Structs.h"
#import "Animations.h"

#import "BasicObject.h"
#import "Ship.h"
#import "SpawnManager.h"
#import "SoundManager.h"
#import "AtlasHandler.h"

#import "Stats.h"

class Missile : public BasicObject{
public:
    //constructor
    Missile(int posX, int posY, Color _color, Resolution _res, BasicObject *_target);
    
    //destructor
    ~Missile();
    
    float speed;
    
    BasicObject *target;
    
    Color color;
    Resolution resolution;
    
    //ofxSpriteSheetRenderer *spriteRenderer;
    
    ofVec2f relativePos;
    
    bool hitTest(BasicObject &ship);
    
    void update();
    void draw();
    
    float maxRotation;
    
    
    
    
private:
    
    float generateRotation(float _x, float _y);
};


#endif
