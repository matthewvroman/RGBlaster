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


#import "ofxSpriteSheetRenderer.h"
#import "Animations.h"

#import "SoundManager.h"

#import "Ship.h"
#import "Core.h"

class Finger{
public:
    //constructor
    Finger();
    
    //destructor
    ~Finger();
    
    float       x;
    float       y;
    float       scale;
    int         r;
    float       radius;
    
    float       speed;
    
    bool        down;
    
    bool        hitTest(BasicObject *ship);
    
    void        setColor(Color _color);
    
	void        _mousePressed(ofMouseEventArgs &touch);
	void        _mouseDragged(ofMouseEventArgs &touch);
	void        _mouseReleased(ofMouseEventArgs &touch);
    
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
