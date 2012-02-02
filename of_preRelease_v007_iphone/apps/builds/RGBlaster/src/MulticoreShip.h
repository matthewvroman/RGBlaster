//
//  MulticoreShip.h
//  RGBlaster
//
//  Created by Matthew Vroman on 1/31/12.
//  Copyright (c) 2012 RGBeast. All rights reserved.
//

#ifndef RGBlaster_MulticoreShip_h
#define RGBlaster_MulticoreShip_h

#include "BasicObject.h"
#include "Ship.h"
#include "AtlasHandler.h"
#include "Core.h"
#include "Explosion.h"

#include "ofxSpriteSheetRenderer.h"

#include "Animations.h"

class MulticoreShip : public BasicObject{
public:
    
    //constructor
    MulticoreShip(float _x, float _y):
    BasicObject(_x,_y,64,64,"",true){
        initCores();
    };
    
    //destructor
    ~MulticoreShip();
    
    vector<Core*>cores;
    vector<Explosion*>explosions;
    
    void removeCore(int _pos);
    void removeExplosion(int _pos);
    
    void update();
    void draw();
    
    void move(float _x, float _y);
    
    void addCore(float _x, float _y);
    
private:
    void initCores();
    
    Core *core1;
    Core *core2;
    Core *core3;
    
};

#endif
