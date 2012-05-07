//
//  ControlArrow.cpp
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#import "ofxControlArrow.h"
#include <iostream>


ofxControlArrow::ofxControlArrow(){

}

ofxControlArrow::~ofxControlArrow(){
    disableMouseEvents();
}

void ofxControlArrow::setup(){
    imgArrow.loadImage("sprites/arrow.png");
    enableMouseEvents();
}

void ofxControlArrow::setDirectionUp(bool _up){
    isUp=_up;
}

void ofxControlArrow::draw(){
    ofPushMatrix();
    if(!isUp){
        ofTranslate(x+width/2.0, y+height/2.0, 0);  
        ofRotateZ(180);  
        ofTranslate((x+width/2.0)*-1.0, (y+height/2.0)*-1.0, 0);  
    }
    
    // Reset color
    ofSetColor( 255, 255, 255 );
    ofEnableAlphaBlending();
    imgArrow.draw(x,y);
    ofDisableAlphaBlending();
    ofPopMatrix();
}

void ofxControlArrow::onPress(int x, int y, int button){

}
void ofxControlArrow::onRelease(int x, int y, int button){
    if(initial){
        initial->increment(isUp?-1:1);
    }
}
void ofxControlArrow::onReleaseOutside(int x, int y, int button){
    
}

void ofxControlArrow::setInitial(ofxInitial *_initial){
    initial=_initial;
}