//
//  ofxInitialsBox.cpp
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#include <iostream>
#include "ofxInitialsBox.h"

ofxInitialsBox::ofxInitialsBox(){
    
    blockFont.loadFont("fonts/ArcadeClassic.ttf",56,true,true);
    
    firstInitial = new ofxControlInitial();
    middleInitial = new ofxControlInitial();
    lastInitial = new ofxControlInitial();
    
    spacing=100;
    
    submitBtn = new button();
    
    submitBtn->init( 4, true, "Submit", blockFont, 20 );
    submitBtn->show();
    
}

ofxInitialsBox::~ofxInitialsBox(){
    delete firstInitial;
    delete middleInitial;
    delete lastInitial;
}

void ofxInitialsBox::setPos(int x, int y){
    firstInitial->setPos(x-spacing,y);
    middleInitial->setPos(x,y);
    lastInitial->setPos(x+spacing,y);
    
    submitBtn->setPosAndSize( x-125, y+spacing*1.5, 275, 80 );
    
    _x=x;
    _y=y;
}

void ofxInitialsBox::draw(){
    
    //centered
    blockFont.drawString("ENTER YOUR INITIALS",_x-blockFont.stringWidth("ENTER YOUR INITIALS")/2,_y-spacing*1.5);
    
    firstInitial->draw();
    middleInitial->draw();
    lastInitial->draw();
}