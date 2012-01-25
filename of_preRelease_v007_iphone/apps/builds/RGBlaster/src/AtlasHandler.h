//
//  AtlasHandler.h
//  RGBlaster
//
//  Created by Matthew Vroman on 12/3/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Manages the loading and updating of reoccuring textures

#ifndef RGBlaster_AtlasHandler_h
#define RGBlaster_AtlasHandler_h

#import "ofMain.h"
#import "ofxiPhone.h"
#import "ofxiPhoneExtras.h"

#import "ofxSpriteSheetRenderer.h"


class AtlasHandler{
public:
    
    //destructor
    ~AtlasHandler();
    
    static AtlasHandler* instance;
    static AtlasHandler* getInstance();
    
    void loadTextureAtlases();
    
    void update();
    
    ofxSpriteSheetRenderer *redShipRenderer;
    ofxSpriteSheetRenderer *blueShipRenderer;
    ofxSpriteSheetRenderer *greenShipRenderer;
    ofxSpriteSheetRenderer *missileRenderer;
    ofxSpriteSheetRenderer *explosionRenderer;

    
private:
    //singleton has a private constructor called by getInstance()
    AtlasHandler();
    vector<ofxSpriteSheetRenderer*>sheets;
};

#endif
