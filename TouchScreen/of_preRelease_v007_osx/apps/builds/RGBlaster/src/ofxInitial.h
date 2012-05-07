//
//  ofxInitial.h
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#ifndef RGBlaster_ofxInitial_h
#define RGBlaster_ofxInitial_h
#include "ofMain.h"

class ofxInitial{
public:
    ofxInitial();
    ~ofxInitial();

    void draw();
    
    void increment(int _increment);
    
    string getCurrentLetter();
    void setCurrentLetter(int _pos);

    void setPos(int _x, int _y);
    
private:
    int currentPos;
    ofTrueTypeFont blockFont;
    
    string alphabet;
    
    string currentLetter;
    
    int highestNum;
    
    
    //pos
    int x;
    int y;
    
};

#endif
