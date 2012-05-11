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
    
    screenRes.x=ofGetWidth();
    screenRes.y=ofGetHeight();
    
    // Reset font DPI
    ofTrueTypeFont::setGlobalDpi(96);
    
    soundManager = SoundManager::getInstance();
    
    // Load images
    logo.loadImage("logo.png");
    
	// Loading label text
	font.loadFont("fonts/ArcadeClassic.ttf", 45, true, true, false);
    visitorFont.loadFont("fonts/visitor1.ttf", 27, true, true, false);
    
    btn_start = new button();
    btn_about = new button();
    btn_help = new button();
    // Initialize buttons
    btn_start->init( 1, true, "Start Game", font, 20 );
    btn_about->init( 3, true, "About", font, 110 );
    btn_help->init( 2, true, "Help", font, 120 );
    btn_start->setPosAndSize( screenRes.x/2-184, 790, 368, 80 );
    btn_help->setPosAndSize( screenRes.x/2-184, 910, 368, 80 );
    btn_about->setPosAndSize( screenRes.x/2-184, 1030, 368, 80 );
    btn_start->show();
    btn_help->show();
    btn_about->show();
    
    // Assign screen ID
    nextScreen = 0;
    
    //test= new ofxInitialsBox();
    //test->setPos(ofGetWidth()/2,200);
}


//--------------------------------------------------------------
void MenuScreen::update(){
    // Play menu music
    if(!soundManager->mainMenuMusic.getIsPlaying())
        soundManager->mainMenuMusic.play();
    
    // Check for button press
    if(btn_start->pressed) {
        btn_start->setPosAndSize( screenRes.x/2-184, 790, 368, 80 );
        btn_help->setPosAndSize( screenRes.x/2-184, 910, 368, 80 );
        btn_about->setPosAndSize( screenRes.x/2-184, 1030, 368, 80 );
        nextScreen = 1;
        SoundManager::getInstance()->click.play();
    } else if (btn_help->pressed) {
        nextScreen = 2;
        SoundManager::getInstance()->click.play();
    } else if (btn_about->pressed) {
        nextScreen = 3;
        SoundManager::getInstance()->click.play();
    }
}

//--------------------------------------------------------------
void MenuScreen::draw(){
    
    // Draw logo
    ofSetColor( 255, 255, 255 );
    ofEnableAlphaBlending();
    logo.draw(screenRes.x/2-350, 100, 699, 178);
    ofDisableAlphaBlending();
    
    // Draw copyright text
    ofSetColor(97, 114, 175);
    visitorFont.drawString( "Copyright RGBeast 2012", screenRes.x/2-175, screenRes.y-24);
    
    // Reset color
    ofSetColor( 255, 255, 255 );
    
    //ofPushMatrix();
    //test->draw();
    //ofPopMatrix();
}

MenuScreen::~MenuScreen(){
    // Hide buttons
    btn_start->hide();
    btn_help->hide();
    btn_about->hide();
    delete btn_start;
    delete btn_help;
    delete btn_about;
}