//
//  GameScreen.mm
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the game screen
//

#include "GameScreen.h"

//--------------------------------------------------------------
GameScreen::GameScreen(){	
    screenRes.x=ofGetWidth();
    screenRes.y=ofGetHeight();
    soundManager = SoundManager::getInstance();
    
    soundManager->loadGameplaySounds();
    AtlasHandler::getInstance()->loadSpriteSheets();
    
    // Create world
    world = new World();
    world->soundManager = soundManager;
    
    // Play game music
    if(soundManager->mainMenuMusic.getIsPlaying())
        soundManager->mainMenuMusic.stop();
    if(!soundManager->backgroundMusic.getIsPlaying())
        soundManager->backgroundMusic.play();
    
    // Set up buttons
    font.loadFont("fonts/ArcadeClassic.ttf", 45, true, true, false);
    btn_replay.init( 1, true, "Replay", font, 110 );
    btn_mainMenu.init( 3, true, "Main Menu", font, 70 );
    btn_replay.setPosAndSize( screenRes.x/2-184, 430, 368, 80 );
    btn_mainMenu.setPosAndSize( screenRes.x/2-184, 550, 368, 80 );
    btn_replay.hide();
    btn_mainMenu.hide();
    
    // Assign screen ID
    nextScreen = 1;
}


//--------------------------------------------------------------
void GameScreen::update(){
    // Update world
    world->update();
    
    if(world->hud->gameOver==true){
    // Check for button press after game over
        if(btn_mainMenu.pressed) {
            // Return to main menu
            SoundManager::getInstance()->click.play();
            nextScreen = 0;
            btn_replay.hide();
            btn_mainMenu.hide();
        } else if(btn_replay.pressed) {
            // Reset game
            SoundManager::getInstance()->click.play();
            delete world;
            soundManager = SoundManager::getInstance();
            world = new World();
            world->soundManager = soundManager;
            btn_replay.hide();
            btn_mainMenu.hide();
        }
    }
}

//--------------------------------------------------------------
void GameScreen::draw(){
    // Draw world
    world->draw();
    
    // Draw buttons
    if(world->hud->gameOver==true){
        btn_replay.show();
        btn_mainMenu.show();
    }
}

GameScreen::~GameScreen(){
    // Delete world
    delete world;
}