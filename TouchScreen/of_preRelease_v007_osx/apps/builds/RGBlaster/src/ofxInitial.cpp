//
//  ofxInitial.cpp
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#include <iostream>
#include "ofxInitial.h"

ofxInitial::ofxInitial(){
    
    blockFont.loadFont("fonts/ArcadeClassic.ttf",72,true,true);
    
    alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    highestNum=alphabet.length();
    
    currentPos=0;
    setCurrentLetter(currentPos);
    
    x=y=0;
    
}


ofxInitial::~ofxInitial(){
    
}

void ofxInitial::draw(){
    blockFont.drawString(currentLetter,x,y);
}
                         
    

void ofxInitial::increment(int _increment){
    currentPos+=_increment;
    if(currentPos<0){
        currentPos=highestNum-1;
    }else if(currentPos>highestNum-1){
        currentPos=0;
    }
    
    currentLetter = alphabet.substr(currentPos,1);
}

      
string ofxInitial::getCurrentLetter(){
    return currentLetter;
}


void ofxInitial::setCurrentLetter(int _pos){
    if(_pos>=0 && _pos<=highestNum){
        currentLetter=alphabet.substr(_pos,1);
    }
}

void ofxInitial::setPos(int _x, int _y){
    x=_x;
    y=_y;
}