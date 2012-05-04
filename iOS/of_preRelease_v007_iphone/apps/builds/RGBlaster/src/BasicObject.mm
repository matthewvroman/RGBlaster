//
//  BasicObject.mm
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

#include <iostream>
#include "BasicObject.h"
#include <math.h>

//Creates a default object
BasicObject::BasicObject(){
    
    enabled=true;
    
    sprite = new basicSprite(); // create a new sprite
    sprite->pos.set(0,0); //set its position
    sprite->speed=1; //set its speed
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    sprite->animation.frame_duration = 5; //adjust its frame duration based on how fast it is walking (faster = smaller)
    sprite->animation.index = 0; //change the start index of our sprite. we have 4 rows of animations and our spritesheet is 8 tiles wide, so our possible start indicies are 0, 8, 16, and 24
    
    type = SHIP;
    
    scale=1;
    
    dead=false;
    saturation=255;

}

BasicObject::BasicObject(float _x, float _y, int _width, int _height,string _spriteSheet,bool _enabled){
    if(_enabled==true){
        enabled=true;
    }

    sprite = new basicSprite(); // create a new sprite
    sprite->pos.set(0,0); //set its position
    sprite->speed=1; //set its speed
    sprite->tileSize=_width;
    sprite->spriteSheetWidth=512;
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    sprite->animation.frame_duration = 5; //adjust its frame duration based on how fast it is walking (faster = smaller)
    //each resolution starts on a new row
    sprite->animation.index = (sprite->spriteSheetWidth/sprite->tileSize)*resolution;

	ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    //color = Color(int(ofRandom(0,3)));
    x=_x;
    y=_y;
    
    scale=1;
    a=0;
    
    width=_width;
    height=_height;
    
    targeted=false;
    dead=false;
    
    type = SHIP;
    
    saturation=255;

}

//destructor
BasicObject::~BasicObject(){
    enabled=false;
    
    //sprite=NULL;
    //delete allocated memory
    delete sprite;

}

void BasicObject::kill(){
    dead=true;
}

bool BasicObject::derez(){
    return true;
}

void BasicObject::setSpriteTexture(string spriteTexture, int spriteSheetSize, int spriteSize) {
    //delete spriteRenderer;
    spriteRenderer = new ofxSpriteSheetRenderer(1, 10000, 0, spriteSize);
    spriteRenderer->loadTexture(spriteTexture, spriteSheetSize, GL_NEAREST);
}

void BasicObject::move(float _x, float _y){
    x+=_x;
    y+=_y;
}

//move object in a circlular pattern
void BasicObject::circleMove(float _parentX, float _parentY, float _speed, int _radius){
    float radian = deg2rad(a);
    x =_parentX + _radius * cos(radian);
    y =_parentY + _radius * sin(radian);
    a +=_speed;
    a %= 360;
    
}

//move object in-and-out from a centralized point
void BasicObject::expandMove(float _parentX, float _parentY, float _speed, int _radius){
    float radian = deg2rad(a);
    x =_parentX + _radius * cos(radian);
    y =_parentY + _radius * sin(radian);
    
}

//zig-zag back and forth while moving downwards
void BasicObject::zigZagMove(float _parentX, float _parentY, float _speed, int _radius){
    float radian = deg2rad(_radius);
    x =_parentX + _radius * cos(radian);
    y =_parentY + _radius * cos(radian)-a;
}

void BasicObject::setColor(Color _color){
    color=_color;
}

Color BasicObject::getColor(){
    return color;
}

void BasicObject::setResolution(Resolution _res){
    resolution=_res;
    sprite->animation.index = (sprite->spriteSheetWidth/sprite->tileSize)*resolution;
    
}

Resolution BasicObject::getRes(){
    return resolution;
}

void BasicObject::setPosition(float _x, float _y){
    x=_x;
    y=_y;
}

ofVec2f BasicObject::getPosition(){
    ofVec2f _pos;
    _pos.set(x,y);
    return _pos;
}

void BasicObject::update() {
    if(!enabled || dead) return;
    
    //spriteRenderer->clear(); // clear the sheet
	//spriteRenderer->update(ofGetElapsedTimeMillis()); //update the time in the renderer, this is necessary for animations to advance
    
    if(sprite!=NULL && !dead){
        spriteRenderer->addCenterRotatedTile(&sprite->animation,x,y, -1, 1, F_NONE, scale, 0, saturation,saturation,saturation,255); 
    }
    
}

void BasicObject::draw() {
    if(!enabled || dead) return;
    
    spriteRenderer->draw();
}

float BasicObject::deg2rad(float _deg){
    return _deg*(3.1415926/180);
}
