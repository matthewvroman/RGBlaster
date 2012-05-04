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


#import "BasicObject.h"
#import "Missile.h"
#import "Finger.h"
#import "SpawnManager.h"
#import "Explosion.h"

class Blaster : public BasicObject{
public:
    //constructor
    Blaster();
    
    //destructor
    ~Blaster();
    
    void update();
    void draw();
    
    void setResolution(Resolution _res);
    void updateSpriteSheet();
    
    void setSpawner(SpawnManager *_spawner);
    
    void _mousePressed(ofMouseEventArgs &touch);
	void _mouseReleased(ofMouseEventArgs &touch);
    
    Finger *finger;
    
private:
    Resolution resolution;
    Color color;
    
    SpawnManager *spawner;
    
    bool lockedOn;
    vector<BasicObject*>targets;
    vector<Missile*>missiles;
    
    void removeMissile(int);
    
    vector<Explosion*>explosions;
    void removeExplosion(int _pos);
    
    int         leeway;
    ofVec2f     lastTouch;
    
    ofVec2f     missileSpawnPos;
    ofVec2f     currentMissileSpawnPos;
    
    ofxSpriteSheetRenderer *colorWheelRenderer;
    basicSprite *colorWheelSprite;
    
    float currentR;
    float rotationSpeed;
    float maxRotation;
    
    bool switchingColor;
    
    bool lastGameOverCheck;
    
    void switchColor();
    
    int maxMissilesOnScreen;
    

};

#endif
