//
//  SoundManager.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Manages all the music & sfx in the game

#ifndef RGBlaster_SoundManager_h
#define RGBlaster_SoundManager_h

#import "ofMain.h"
#import "ofxiPhone.h"
#import "ofxiPhoneExtras.h"


class SoundManager{
public:
    
    static SoundManager* instance;
    static SoundManager* getInstance();
    
    ~SoundManager();
    
    ofSoundPlayer  targeted;
    ofSoundPlayer  explosion;
    
    ofSoundPlayer   missileSuccess;
    ofSoundPlayer   missileFailure;
    
    ofSoundPlayer   spin;
    
    ofSoundPlayer   resUp;
    ofSoundPlayer   resDown;
    
    ofSoundPlayer   gameOver;
    
    ofSoundPlayer   click;
    
    ofSoundPlayer   mainMenuMusic;
	ofSoundPlayer   backgroundMusic;
    
    void loadGameplaySounds();
    void loadMenuSounds();
    
    void setVolumes();
    
    void stopAll();
    
private:
    
    vector<ofSoundPlayer>sfx;
    vector<ofSoundPlayer>music;
    
    bool gameplaySoundsLoaded;
    bool menuSoundsLoaded;
    
    //singleton has a private constructor called by getInstance()
    SoundManager();
    
};

#endif
