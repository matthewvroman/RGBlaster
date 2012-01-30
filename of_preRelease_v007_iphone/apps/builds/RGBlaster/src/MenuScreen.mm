//
//  MenuScreen.mm
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the menu screen
//

#include "MenuScreen.h"

//--------------------------------------------------------------
MenuScreen::MenuScreen(){	    
    // Reset font DPI
    ofTrueTypeFont::setGlobalDpi(96);
    
    soundManager = SoundManager::getInstance();
    
    // Play menu music
    if(!soundManager->mainMenuMusic.getIsPlaying())
        soundManager->mainMenuMusic.play();
    
    // Load images
    logo.loadImage("logo.png");
    
	// Loading label text
	font.loadFont("fonts/ArcadeClassic.ttf", 45, true, true, false);
    visitorFont.loadFont("fonts/visitor1.ttf", 27, true, true, false);
    
    // Initialize buttons
    btn_start.init( 1, true, "Start Game", font, 20 );
    btn_about.init( 3, true, "About", font, 110 );
    btn_help.init( 2, true, "Help", font, 120 );
    btn_start.setPosAndSize( 200, 390, 368, 80 );
    btn_help.setPosAndSize( 200, 510, 368, 80 );
    btn_about.setPosAndSize( 200, 630, 368, 80 );
    btn_start.show();
    btn_help.show();
    btn_about.show();
    
    // Assign screen ID
    nextScreen = 0;
}


//--------------------------------------------------------------
void MenuScreen::update(){
    // Check for button press
    if(btn_start.pressed) {
        btn_start.setPosAndSize( 200, 390, 368, 80 );
        btn_help.setPosAndSize( 200, 510, 368, 80 );
        btn_about.setPosAndSize( 200, 630, 368, 80 );
        nextScreen = 1;
        SoundManager::getInstance()->click.play();
    } else if (btn_help.pressed) {
        nextScreen = 2;
        SoundManager::getInstance()->click.play();
    } else if (btn_about.pressed) {
        nextScreen = 3;
        SoundManager::getInstance()->click.play();
    }
}

//--------------------------------------------------------------
void MenuScreen::draw(){
    
    // Draw logo
    ofSetColor( 255, 255, 255 );
    ofEnableAlphaBlending();
    logo.draw(30, 100, 699, 178);
    ofDisableAlphaBlending();
    
    // Draw copyright text
    ofSetColor(97, 114, 175);
    visitorFont.drawString( "Copyright RGBeast 2011", 175, 1000);
    
    // Reset color
    ofSetColor( 255, 255, 255 );
}

MenuScreen::~MenuScreen(){
    // Hide buttons
    btn_start.hide();
    btn_help.hide();
    btn_about.hide();
}