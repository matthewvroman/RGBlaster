//
//  Missile.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Object that chases ships after they have been targeted

#include <iostream>
#import "Missile.h"

Missile::Missile(int posX, int posY, Color _color, Resolution _res, BasicObject *_target){
    enabled=true;
    
    color=_color;
    resolution=_res;
    
    
    spriteRenderer=AtlasHandler::getInstance()->missileRenderer;
    
    ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    //sprite = new basicSprite(); // create a new sprite
    
    sprite->pos.set(0,0); //set its position
    
    
    sprite->speed=1; //set its speed
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    //spritesheet is loaded in as 256x256px, 32x32px tiles (256/32=8 tiles per row)
    sprite->animation.index = 8*int(resolution)+int(color);
    
    targetSprite = new basicSprite();
    targetSprite->pos.set(0,0);
    targetSprite->animation = defaultAnimation; //targetAnimation
    targetSprite->animation.index=int(color)*4; //4 tiles per row
    
    targetRenderer=AtlasHandler::getInstance()->targetRenderer;
    
    target=_target;
    
    speed=5;
    
    r=0;
    
    a=0;
    
    type = MISSILE;
    
    maxRotation=0.9;
    
    this->setPosition(posX, posY);
    
    relativePos.set(this->getPosition());
    
    if(target==NULL){
        dead=true;
    }else{
        dead = false;
    }
    
    
}

Missile::~Missile(){
    //remove self-contained calls to update & draw
    enabled=false;
    delete targetSprite;
    
}


void Missile::update() {
    if(dead) return;

    moveTowardsTarget();
    
    if(sprite!=NULL){
        //cout << _modX << ", " << _modY << endl;
        spriteRenderer->addCenterRotatedTile(&sprite->animation,x,y, 0, 1, F_NONE, 1.0, r); 
    }
    if(targetSprite!=NULL){
        targetRenderer->addCenterRotatedTile(&targetSprite->animation,target->getPosition().x,target->getPosition().y, 0, 1, F_NONE, 1.0, 0);
    }
    
    if(target!=NULL){
    //check if we hit the target
        hitTest(target);
    }
    
}

void Missile::moveTowardsTarget(){
    //Get the targets position and adjust path accordingly
    if(target!=NULL && !target->dead){
        relativePos.set(target->getPosition()-this->getPosition());
    }else{
        dead=true;
        return;
    }
    
    ofVec2f direction;
    if(relativePos.x<speed && relativePos.x >-speed){
        direction.x=0;
    }else if(relativePos.x>speed){
        direction.x=speed/1.75;
    }else{
        direction.x=-speed/1.75;
    }
    if(relativePos.y<speed && relativePos.y>-speed){
        direction.y=0;
    }else if(relativePos.y>speed){
        direction.y=speed;
    }else{
        direction.y=-speed;
    }
    
    move(direction.x,direction.y);
    
    r = generateRotation(x, y);
}

float Missile::generateRotation(float _x, float _y){
    if(target==NULL || target->dead) return 0.0;
    
    float _percent = (target->getPosition().x-_x)/(target->getPosition().y-_y);
    if(_percent>maxRotation){
        _percent=maxRotation;
    }else if(_percent<-maxRotation){
        _percent=-maxRotation;
    }
    float _rotation =-asin(_percent) *180/3.141592;
    
    if(_rotation<0){
        _rotation=360+_rotation;
    }

    return _rotation;
}

void Missile::draw() {
    if(dead) return;
    spriteRenderer->draw();
    targetRenderer->draw();
}

bool Missile::hitTest(BasicObject *ship){
    //hit the ship
    if(x < ship->x+ship->width/2 && x > ship->x-ship->width/2 &&
       y < ship->y+ship->height/2 && y > ship->y-ship->height/2
       ){
        if(ship->getColor() == this->color){ 
            if(ship->derez()){   //if ship is the same color & on last life, destroy it
                SpawnManager::getInstance()->notifyShipDestroyed();
                ship->kill();
                //SoundManager::getInstance()->missileSuccess.play();
            }
        }else{
            SpawnManager::getInstance()->resetColorStreak();
            //SoundManager::getInstance()->missileFailure.play();
        }
        ship->targeted=false;
        if(derez()){
            dead=true;
        }
        return true;
    }else{
        return false;
    }
    
}