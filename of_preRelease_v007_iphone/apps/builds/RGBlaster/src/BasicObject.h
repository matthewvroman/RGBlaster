//
//  BasicObject.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/3/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Basic Object that handles individual movements,
//               resolution shifts, color changes, etc.

#ifndef RGBlaster_BasicObject_h
#define RGBlaster_BasicObject_h

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ofxSpriteSheetRenderer.h"

#import "Enums.h"
#import "Structs.h"
#import "Animations.h"



class BasicObject{
public:
    //constructors
    BasicObject();
    BasicObject(float _x, float _y, int _width, int _height, string _spriteSheet, bool _enabled);
    
    //destructors
    ~BasicObject();
    
    basicSprite *sprite;
    
    ofxSpriteSheetRenderer * spriteRenderer;
    
    //movement methods
    void move(float _x, float _y);
    void circleMove(float _parentX, float _parentY, float _speed, int _radius);
    void expandMove(float _parentX, float _parentY, float _speed, int _radius);
    void zigZagMove(float _parentX, float _parentY, float _speed, int _radius);
    
    bool derez();
    bool targeted;
    bool dead;
    
    ObjectType type;
    
    //getters/setters
    void setPosition(float _x, float _y);
    ofVec2f getPosition();
    
    void setColor(Color _color); 
    Color getColor(); 
    
    void setResolution(Resolution _res);
    Resolution getRes();
    
    void setSpriteTexture(string spriteTexture, int spriteSheetSize, int spriteSize);
    
    //cascading OF methods
    void update();
    void draw();
    
    
    //object variables
    int width;
    int height;
    
    int tilesPerRow;
    
    float x;
    float y;
    float r;
    int a;
    int saturation;
    
    float speed;
    
    float scale;
    
    //determines whether or not to run update & draw
    bool enabled;
    
protected:
    Resolution resolution;
    Color color;
    float deg2rad(float _deg);
    
private:


};

#endif
