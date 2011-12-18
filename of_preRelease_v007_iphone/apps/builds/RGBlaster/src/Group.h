//
//  Group.h
//  RGBlaster
//
//  Created by Matthew Vroman on 10/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Manages a group of ships that move down the screen

#ifndef RGBlaster_Group_h
#define RGBlaster_Group_h
#import "ofMain.h"
#import "ofxiPhone.h"
#import "ofxiPhoneExtras.h"

#import "Ship.h"
#import "ofxSpriteSheetRenderer.h"
#import "HUD.h"
#import "AtlasHandler.h"

#import "Enums.h"

class Group{
public:
    //constructors
    Group();
    Group(int _numShips, Color _color, Resolution _res, MovementType _movement);
    
    //destructor
    ~Group();
    
    //movement methods
    void updatePos(float _x, float _y);
    void move(float _x, float _y);
    void circleMove(int _speed, int _radius);
    void expandMove(int _speed, int _maxRadius);
    void expandCircleMove(int _speed, int _maxRadius);
    void zigZagMove(int _speed, int _maxRadius);
    
    void distributeAngles();
    
    //OF cascading methods
    void update();
    void draw();
    
    //ship handling methods
    void addShip(int _x, int _y, int _height, int _width);
    void addShips(int _numShips);

    void removeFromVector(int _pos);
    
    void setResolution(Resolution);
    
    float x;
    float y;
    float a;
    float r; //radius
    
    //used for better collision detection
    float width;
    float height;
    
    bool dead;
    
    int numShips;
    
    bool killThis;
    
    ofxSpriteSheetRenderer * spriteRenderer;
    
    Color color;
    Resolution resolution;
    int movement;
    
    vector<Ship*>objects;
    
private:
    float deg2rad(float _deg);
    bool expanding;
    PixelTexture texture;
    bool enabled;
    ofxSpriteSheetRenderer *renderer;

};

#endif
