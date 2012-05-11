//
//  ofxControlInitial.cpp
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#include <iostream>
#include "ofxControlInitial.h"

ofxControlInitial::ofxControlInitial(){
    upArrow = new ofxControlArrow();
    downArrow = new ofxControlArrow();
    initial = new ofxInitial();
    
    upArrow->setDirectionUp(true);
    downArrow->setDirectionUp(false);
    
    upArrow->setInitial(initial);
    downArrow->setInitial(initial);
    
}

ofxControlInitial::~ofxControlInitial(){
    delete upArrow;
    delete downArrow;
    delete initial;
}

void ofxControlInitial::setPos(int x, int y){
    upArrow->setPosAndSize(x-5,y-130,64,64);
    downArrow->setPosAndSize(x-5,y+10,64,64);
    initial->setPos(x,y);
}


void ofxControlInitial::draw(){
    upArrow->draw();
    initial->draw();
    downArrow->draw();
}

string ofxControlInitial::getInitial(){
    return initial->getCurrentLetter();
}