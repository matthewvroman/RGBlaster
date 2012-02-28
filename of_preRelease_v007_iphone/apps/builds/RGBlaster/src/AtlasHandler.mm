//
//  AtlasHandler.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 12/3/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Manages the loading and updating of reoccuring textures

#include <iostream>
#import "AtlasHandler.h"

AtlasHandler* AtlasHandler::instance = NULL;

AtlasHandler* AtlasHandler::getInstance(){
    if(!instance)
        instance = new AtlasHandler;
    return instance;
}

//Loads all texture sprite sheets we need for the gameplay
AtlasHandler::AtlasHandler(){
    
    redShipRenderer = new ofxSpriteSheetRenderer(1,100,0,48);
    redShipRenderer->loadTexture("sprites/red_sprite.png", 512, GL_NEAREST);
    sheets.push_back(redShipRenderer);
    
    blueShipRenderer = new ofxSpriteSheetRenderer(1,100,0,48);
    blueShipRenderer->loadTexture("sprites/blue_sprite.png", 512, GL_NEAREST);
    sheets.push_back(blueShipRenderer);
    
    greenShipRenderer = new ofxSpriteSheetRenderer(1,100,0,48);
    greenShipRenderer->loadTexture("sprites/green_sprite.png", 512, GL_NEAREST);
    sheets.push_back(greenShipRenderer);
    
    missileRenderer = new ofxSpriteSheetRenderer(1,100,0,32);
    missileRenderer->loadTexture("sprites/missile_spriteSheet.png", 256, GL_NEAREST);
    sheets.push_back(missileRenderer);
    
    explosionRenderer = new ofxSpriteSheetRenderer(1,100,0,32);
    explosionRenderer->loadTexture("sprites/explosion_spriteSheet.png", 512, GL_NEAREST);
    sheets.push_back(explosionRenderer);
    
    coreRenderer = new ofxSpriteSheetRenderer(1,100,0,32);
    coreRenderer->loadTexture("sprites/cores_spriteSheet.png", 512, GL_NEAREST);
    sheets.push_back(coreRenderer);
    
    multicoreShipRenderer = new ofxSpriteSheetRenderer(1,100,0,64);
    multicoreShipRenderer->loadTexture("sprites/multicore_ship_sprite.png", 512, GL_NEAREST);
    sheets.push_back(multicoreShipRenderer);
    
    targetRenderer = new ofxSpriteSheetRenderer(1, 1000, 0, 64);
    targetRenderer->loadTexture("sprites/targeting_spriteSheet.png", 256, GL_NEAREST);
    sheets.push_back(targetRenderer);
    
    cout << "Loaded Sprite Sheets" << endl;
    
    background8.loadImage("sprites/background-low.png");
    cout << "Loaded 8-bit Handler" << endl;
    background16.loadImage("sprites/background-med.png");
    cout << "Loaded 16-bit Handler" << endl;
    background32.loadImage("sprites/background-hi.png");
    
    ofEnableAlphaBlending();
    
    cout << "Loaded Atlas Handler" << endl;

}

ofxSpriteSheetRenderer* AtlasHandler::getSpriteSheetRenderer(string _renderer){
    ofxSpriteSheetRenderer* renderer;
    if(_renderer=="RedEnemy"){
        //explosionRenderer->texture;
    }else if(_renderer=="BlueEnemy"){
        
    }else if(_renderer=="GreenEnemy"){
        
    }
    
    return renderer;
}

//deletes all dynamically allocated memory
AtlasHandler::~AtlasHandler(){
    //clear should dealloc each renderer
    sheets.clear();
    delete instance;
    /*
    delete redShipRenderer;
    delete blueShipRenderer;
    delete greenShipRenderer;
    delete missileRenderer;
    delete explosionRenderer;
    delete coreRenderer;
    delete multicoreShipRenderer;
     */
}


//update all the sprite sheets
void AtlasHandler::update(){
    for(short i=0; i<sheets.size(); i++){
        sheets.at(i)->clear(); // clear the sheet
        sheets.at(i)->update(ofGetElapsedTimeMillis());
    }
}


