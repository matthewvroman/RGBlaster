//
//  ofxControlInitial.h
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#ifndef RGBlaster_ofxControlInitial_h
#define RGBlaster_ofxControlInitial_h

#import "ofxMSAInteractiveObject.h"
#import "ofxControlArrow.h"
#import "ofxInitial.h"

class ofxControlInitial{ 
public:
    ofxControlInitial();
    ~ofxControlInitial();
    
    void draw();
    
    void setPos(int x, int y);
    
    string getInitial();
    
private:
    ofxControlArrow *upArrow;
    ofxControlArrow *downArrow;
    ofxInitial *initial;
};

#endif
