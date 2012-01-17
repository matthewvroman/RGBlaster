//
//  Finger.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/22/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles collision detection between touches & ships

#ifndef RGBlaster_Finger_h
#define RGBlaster_Finger_h

#import "ofMain.h"
#import "ofxiPhone.h"
#import "ofxiPhoneExtras.h"

#import "ofxSpriteSheetRenderer.h"
#import "Animations.h"

#import "Target.h"
#import "Ship.h"

class Finger{
public:
    //constructor
    Finger();
    
    //destructor
    ~Finger();
    
    Target      *target;
    
    float       x;
    float       y;
    float       scale;
    int         r;
    float       radius;
    
    float       speed;
    
    bool        down;
    
    bool        hitTest(Ship &ship);
    
    void        setColor(Color _color);
    
    void		touchDown(ofTouchEventArgs &touch);
    void		touchMoved(ofTouchEventArgs &touch);
    void		touchUp(ofTouchEventArgs &touch);
    
    
    void        update();
    void        draw();
    
    void        powerUp();
    void        powerDown();
    
private:
    Color color;
    
    basicSprite *sprite;
    ofxSpriteSheetRenderer  *renderer;
    
    int defaultRadius;
    int defaultScale;
};


#endif
