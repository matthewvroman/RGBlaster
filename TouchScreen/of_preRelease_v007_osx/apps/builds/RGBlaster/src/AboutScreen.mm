//
//  AboutScreen.mm
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the about screen
//

#include "AboutScreen.h"

//--------------------------------------------------------------
AboutScreen::AboutScreen(){	
    
    screenRes.x=ofGetWidth();
    screenRes.y=ofGetHeight();
    
    soundManager = SoundManager::getInstance();
                
    // Loading label text
	font.loadFont("fonts/ArcadeClassic.ttf", 45, true, true, false);
    aboutFont.loadFont("fonts/visitor1.ttf", 27, true, true, false);
    
    // Initialize buttons
    btn_back.init( 3, true, "Main Menu", font, 35 );
    btn_back.setPosAndSize( screenRes.x/2-184,screenRes.y-104, 368, 80 );
    
    // Assign screen ID
    nextScreen = 3;
}


//--------------------------------------------------------------
void AboutScreen::update(){
    // Check for button press
    if(btn_back.pressed) {
        nextScreen = 0;
        SoundManager::getInstance()->click.play();
    }
}

//--------------------------------------------------------------
void AboutScreen::draw(){
    ofSetColor( 255, 255, 255 );
    ofTranslate(150,250,0);
    ofPushMatrix();
    // Draw text
    aboutFont.drawString( "   The planet Reztopia, home to the", 30, 50);
    aboutFont.drawString( "RGBeast race, is under planetwide", 30, 90);
    aboutFont.drawString( "siege by their arch enemies, the", 30, 130);
    aboutFont.drawString( "BitLords of planet Colorica. The", 30, 170);
    aboutFont.drawString( "siege is the result of a long,", 30, 210);    
    aboutFont.drawString( "drawn out war over the rights to", 30, 250);
    aboutFont.drawString( "he Blue moon of RezTopia, a land", 30, 290);
    aboutFont.drawString( "that Colorica has tried to take", 30, 330);
    aboutFont.drawString( "over time and time again.", 30, 370);
    
    aboutFont.drawString( "   You must utilize your defense", 30, 450);
    aboutFont.drawString( "turret to fire off homing missiles", 30, 490);
    aboutFont.drawString( "at the oncoming BitLords, targeting", 30, 530);
    aboutFont.drawString( "specific ships with weapons that", 30, 570);
    aboutFont.drawString( "work best against the enemy shields.", 30, 610);
    aboutFont.drawString( "The BitLords utilize 3 different", 30, 650);
    aboutFont.drawString( "shield types, red, green and blue.", 30, 690);
    aboutFont.drawString( "Similarly, your turret has a mode", 30, 730);
    aboutFont.drawString( "to combat each of these with", 30, 770);
    aboutFont.drawString( "matching colored projectiles. Swipe", 30, 810);
    aboutFont.drawString( "left or right over your cannon", 30, 850);
    aboutFont.drawString( "to switch projectile colors.", 30, 890);
    ofPopMatrix();
}

AboutScreen::~AboutScreen(){
    // Hide button
    btn_back.hide();
}