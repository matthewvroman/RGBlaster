//
//  Blaster.h
//  RGBlaster
//
//  Created by Alex Miner on 11/10/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Blaster object that sits at the bottom of the screen
//               Allows for targeting & missile firing

#ifndef RGBlaster_Blaster_h
#define RGBlaster_Blaster_h

#import "ofMain.h"
#import "ofxiPhone.h"
#import "ofxiPhoneExtras.h"

#import "BasicObject.h"
#import "Target.h"
#import "Missile.h"
#import "Finger.h"
#import "SpawnManager.h"

class Blaster : public BasicObject{
public:
    //constructor
    Blaster();
    
    //destructor
    ~Blaster();
    
    
    void addTarget(BasicObject *target);
    
    void update();
    void draw();
    
    void switchColor();
    void setResolution(Resolution _res);
    void updateSpriteSheet();
    
    void setSpawner(SpawnManager *_spawner);
    
    void touchDown(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    Finger *finger;
    
private:
    Resolution resolution;
    Color color;
    
    Target *targetOverlay;
    
    SpawnManager *spawner;
    
    bool lockedOn;
    vector<BasicObject*>targets;
    vector<Missile*>missiles;
    
    void removeMissile(int);
    
    int         leeway;
    ofVec2f     lastTouch;
};

#endif
