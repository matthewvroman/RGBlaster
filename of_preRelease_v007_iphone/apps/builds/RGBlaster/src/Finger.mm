//
//  Finger.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/22/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles collision detection between touches & ships

#include <iostream>
#import "Finger.h"

//setup finger with OF touch event listeners
Finger::Finger(){
    ofAddListener(ofEvents.touchDown, this, &Finger::touchDown);
	ofAddListener(ofEvents.touchMoved, this, &Finger::touchMoved);
	ofAddListener(ofEvents.touchUp, this, &Finger::touchUp);
    
    //defines how large of a radius the touch has influence over
    defaultRadius=radius=15;
    r=0;
    defaultScale=scale=1;
    speed=3;
    
    sprite = new basicSprite();
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    sprite->animation.index = 0;

    renderer = new ofxSpriteSheetRenderer(1,100,0,56);
    renderer->loadTexture("sprites/finger_sprite.png", 512, GL_NEAREST);
}

//remove all touch events
Finger::~Finger(){
    ofRemoveListener(ofEvents.touchDown, this, &Finger::touchDown);
	ofRemoveListener(ofEvents.touchMoved, this, &Finger::touchMoved);
	ofRemoveListener(ofEvents.touchUp, this, &Finger::touchUp);

    delete sprite;
    delete renderer;
}

void Finger::touchDown(ofTouchEventArgs &touch) {
    down=true;
    x=touch.x;
    y=touch.y;
    
}

void Finger::touchMoved(ofTouchEventArgs &touch) {
    x=touch.x;
    y=touch.y;
        
}

void Finger::touchUp(ofTouchEventArgs &touch) {
    down=false;
    x=nil;
    y=nil;
}

void Finger::setColor(Color _color){
    color=_color;
    sprite->animation.index = int(color);
}

//Check if the touch has collided with any of the ships on-screen
bool Finger::hitTest(BasicObject *ship){
    if(x - radius < ship->x+ship->width/2 && x + radius > ship->x - ship->width/2 &&
       y - radius < ship->y+ship->height/2 && y + radius > ship->y-ship->height/2 &&
       !ship->targeted){
        return true;
    }else{
        return false;
    }
}

void Finger::powerUp(){
    scale=2;
    radius=30;
}

void Finger::powerDown(){
    scale=defaultScale;
    radius=defaultRadius;
}

void Finger::update(){
    if(!x && !y) return;
    renderer->clear(); // clear the sheet
    renderer->update(ofGetElapsedTimeMillis());
    
    renderer->addCenterRotatedTile(&sprite->animation,0,0);
}


void Finger::draw(){
    if((!x && !y) || (y>900)) return;

    ofPushMatrix();
    ofTranslate(x, y);
    ofRotateZ(r);
    ofScale(scale,scale);
    renderer->draw();
    ofPopMatrix();
    
    r%=360;
    r+=speed;
    
}