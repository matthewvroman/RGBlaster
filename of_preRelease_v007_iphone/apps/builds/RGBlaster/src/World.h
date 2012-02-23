//
//  World.h
//  RGBlaster
//
//  Created by Matthew Vroman on 10/25/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles the gameplay portion of the app
//               Handles calling the HUD, Blaster, and Spawn Manager

#ifndef RGBlaster_World_h
#define RGBlaster_World_h

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#import "AtlasHandler.h"
#import "SoundManager.h"
#import "SpawnManager.h"
#import "Group.h"
#include "BasicObject.h"
#include "Ship.h"
#include "Blaster.h"
#import "Target.h"
#import "Finger.h"
#import "HUD.h"
#import "Notifier.h"
#import "button.h"

class World{
    
    public:
        //constructor
        World();
        
        //destructor
        ~World();
        
        void        update();
        void        draw();
    
        void        drawMotivator();
    
        void        checkRezStatus();
         
        int         currentFPS;
    
        bool        enabled;
    
        AtlasHandler *handler;
        SpawnManager *spawner;
        
        Blaster     *blaster;
    
        HUD         *hud;
        
        Notifier    *notifier;
    
        ofImage     background8;
        ofImage     background16;
        ofImage     background32;
    
        ofImage     motivator;
        
    
        void        spawnBlaster();
    
        Resolution  resolution;
    
        void        rezUp();
        void        rezDown();
        void        derezAll();
    
        void        drawBackground();
    
        void		touchDown(ofTouchEventArgs &touch);
        void		touchMoved(ofTouchEventArgs &touch);
        void		touchUp(ofTouchEventArgs &touch);
    
        SoundManager        *soundManager;
    
    private:
    
    
    
};

#endif
