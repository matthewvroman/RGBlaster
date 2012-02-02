//
//  Target.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Assigns targets to individual ships

#include "ofxSpriteSheetRenderer.h"

#import "Enums.h"
#import "Structs.h"
#import "Animations.h"

#import "Ship.h"
#import "Core.h"

#import "SoundManager.h"

class Target{
public:
    //constructor
    Target();
    
    //destructor
    ~Target();
    
    ofxSpriteSheetRenderer * spriteRenderer;
    basicSprite *sprite;
    
    vector<BasicObject*>targets;
    
    void addTarget(BasicObject *ship);
    //void addTarget(Core *core);
    
    void removeTarget(int);
    void clearTargets();
    
    void changeColor(Color _color);
    
    void update();
    void draw();
    
private:
    bool enabled;
    
};