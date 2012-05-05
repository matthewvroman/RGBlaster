//
//  ScreenManager.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the help screen
//

#include "HelpScreen.h"

//--------------------------------------------------------------
HelpScreen::HelpScreen(){	
    screenRes.x=ofGetWidth();
    screenRes.y=ofGetHeight();
    
    soundManager = SoundManager::getInstance();
        
    // loading label text
	font.loadFont("fonts/ArcadeClassic.ttf", 45, true, true, false);
    aboutFont.loadFont("fonts/visitor1.ttf", 23, true, true, false);
    
    // loading images
    help1.loadImage("sprites/help1.png");
    help2.loadImage("sprites/help2.png");
    help3.loadImage("sprites/help3.png");
    help4.loadImage("sprites/help4.png");
    help5.loadImage("sprites/help5.png");
    help6.loadImage("sprites/help6.png");
    help7.loadImage("sprites/help7.png");
    
    // Initialize buttons
    btn_back.init( 2, true, "Main Menu", font, 35 );
    btn_back.setPosAndSize( screenRes.x/2-184,screenRes.y-104, 368, 80 );
    
    // Assign screen ID
    nextScreen = 2;
}


//--------------------------------------------------------------
void HelpScreen::update(){
    // Check for button press
    if(btn_back.pressed) {
        nextScreen = 0;
        SoundManager::getInstance()->click.play();
    }
}

//--------------------------------------------------------------
void HelpScreen::draw(){
    ofSetColor( 255, 255, 255 );
    ofTranslate(150,250,0);
    ofPushMatrix();
    // Draw icons
    ofEnableAlphaBlending();
    help1.draw(40, 20);
    help2.draw(70, 170);
    help3.draw(30, 270);
    help4.draw(35, 440);
    help5.draw(30, 555);
    help6.draw(30, 675);
    help7.draw(25, 805);
    ofDisableAlphaBlending();
    
    // Draw text
    aboutFont.drawString( "Touch or swipe across an\noncoming ship to fire a\nmissile at it.", 215, 50);
    aboutFont.drawString( "Ships can only be destroyed\nby missiles of the same color.", 215, 200);
    aboutFont.drawString( "Swipe your finger across the\nblaster to switch missile color.", 215, 323);
    aboutFont.drawString( "Watch your resolution bar at\nthe bottom of the screen.", 215, 446);
    aboutFont.drawString( "The better you do, the higher\nyour resolution.", 215, 569);
    aboutFont.drawString( "Enemy ships hitting your planet\nwill decrease your resolution.", 215, 693);
    aboutFont.drawString( "Losing all your resolution will\nend the game.", 215, 815);
    
    ofPopMatrix();
}

HelpScreen::~HelpScreen(){
    // Hide button
    btn_back.hide();
}