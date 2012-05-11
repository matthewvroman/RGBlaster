//
//  ControlArrow.h
//  RGBlaster
//
//  Created by Matthew Vroman on 5/6/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#ifndef RGBlaster_ofxControlArrow_h
#define RGBlaster_ofxControlArrow_h

#import "ofxMSAInteractiveObject.h"
#import "ofxInitial.h"

class ofxControlArrow : public ofxMSAInteractiveObject {
public:
    
    ofxControlArrow();
    ~ofxControlArrow();
    
    void setDirectionUp(bool _up);
    bool directionIsUp();
    
    void onPress(int x, int y, int button);
    void onRelease(int x, int y, int button);
	void onReleaseOutside(int x, int y, int button);
    
    void setup();
    
    void draw();
    
    void setInitial(ofxInitial *_initial);
    
private:
    bool isUp;
    
    ofImage imgArrow;
    ofImage imgArrowPressed;
    
    ofxInitial *initial;
};

#endif
