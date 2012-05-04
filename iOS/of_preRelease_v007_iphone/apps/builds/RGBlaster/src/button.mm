//
//  button.cpp
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Button class used in GUI
//

#include "button.h"

button::button() {
	enableTouchEvents();
}

button::~button() {
    if(touchEventsEnabled)
        disableTouchEvents();
}

void button::init( int _buttonId, bool _alive, string _buttonLabel, ofTrueTypeFont &font, float _offset ) {
	// Assigning ID, background image path, and button label text
	buttonId = _buttonId;
	alive = _alive;
	buttonLabel = _buttonLabel;
	hideBtn = false;
    ArcadeClassic = font;
    offset = _offset;
    saturation=255;
}

void button::setup() {
	// Used in find the size of the string, so it can be centered in draw()
	labelBoundingBox = ArcadeClassic.getStringBoundingBox( buttonLabel, 0, 0 );
	
    // Initialize button states
	pressed = false;
	touchedDown = false;
}

void button::update() {
    if(hideBtn) return; 
	// So a press only registers once
	if(pressed)
		pressed = false;
}

void button:: hide() {
    pressed=false;
    hideBtn = true;
    enabled=false;
    if(touchEventsEnabled)
        disableTouchEvents();
}

void button:: show() {
    pressed=false;
    hideBtn = false;
    enabled=true;
    if(!touchEventsEnabled)
        enableTouchEvents();
}

void button::draw() {
    if(!hideBtn){
        //glow();
        // Draw background
        if(buttonId==1)
            ofSetColor( saturation, 0, 0 );
        else if(buttonId==2)
            ofSetColor( 0, saturation, 0 );
        else if(buttonId==3)
            ofSetColor( 0, 0, saturation );
        ofRect( x - 3, y - 3, width + 6, height + 6 );
        ofSetColor( 8, 7, 27 );
        ofRect( x, y, width, height );
        if(buttonId==1)
            ofSetColor( saturation, 0, 0 );
        else if(buttonId==2)
            ofSetColor( 0, saturation, 0 );
        else if(buttonId==3)
            ofSetColor( 0, 0, saturation );
        
        // Draw the label text
        ArcadeClassic.drawString( buttonLabel, x + offset, y + (height/2) + 15 );
        
        ofSetColor( 255, 255, 255 );
    }
}

void button::glow(){
    if(saturation<150){
        goingDown=false;
    }else if(saturation==255){
        goingDown=true;
    }
    
    if(goingDown){
        saturation-=3;
    }else{
        saturation+=3;
    }
    
    //cout << saturation << endl;
}



void button::exit() {
}

void button::onTouchDown( float x, float y ) {
	// Activate touch
    if(!hideBtn){
        touchedDown = true;
        pressed = true;
    }
}

void button::onTouchMoved( float x, float y ) {}

void button::onTouchUp( float x, float y ) {
	// Deactivate touch
    if(!hideBtn){
        touchedDown = false;
    }
}

void button::setLabel( string _newLabel ) {
	// Change the label to desired string
	buttonLabel = _newLabel;
}