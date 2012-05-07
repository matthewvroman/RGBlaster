//
//  ofxInitialsBox.h
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#ifndef RGBlaster_ofxInitialsBox_h
#define RGBlaster_ofxInitialsBox_h
#include "ofMain.h"
#include "ofxMSAInteractiveObject.h"
#include "ofxControlInitial.h"
#include "button.h"

class ofxInitialsBox {
public:
    ofxInitialsBox();
    ~ofxInitialsBox();
    
    void setPos(int x, int y);
    
    void draw();
    
private:
    ofxControlInitial *firstInitial;
    ofxControlInitial *middleInitial;
    ofxControlInitial *lastInitial;
    
    button *submitBtn;
    
    int spacing;
    
    ofTrueTypeFont blockFont;
    
    int _x;
    int _y;
};

#endif
