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
    
    sprite = new basicSprite(); // create a new sprite
    
    sprite->pos.set(0,0); //set its position
    
    
    sprite->speed=1; //set its speed
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    //spritesheet is loaded in as 256x256px, 32x32px tiles (256/32=8 tiles per row)
    sprite->animation.index = 8*int(resolution)+int(color);
    
    target=_target;
    
    speed=5;
    
    r=0;
    
    type = MISSILE;
    
    maxRotation=0.9;
    
    this->setPosition(posX, posY);
    
    dead = false;
    
    enabled=true;
    
    
}

Missile::~Missile(){
    
    //remove self-contained calls to update & draw
    enabled=false;

    //delete allocated memory
    delete sprite;
    
}


bool Missile::derez(){
    return true;
}

void Missile::update() {
    if(!enabled) return;
    
    //Get the targets position and adjust path accordingly
    if(target->dead==false){
        relativePos.set(target->getPosition()-this->getPosition());
    }else{
        dead=true;
        relativePos.set(this->getPosition());
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
    
    //float _modX=x+32*cos(deg2rad(r));
    //float _modY=y+32*sin(deg2rad(r));
    //cout << "R: " << r << endl;
    if(sprite!=NULL && !dead){
        //cout << _modX << ", " << _modY << endl;
        spriteRenderer->addCenterRotatedTile(&sprite->animation,x,y, -1, 1, F_NONE, 1.0, r, saturation,saturation,saturation,255); 
    }
    
    if(!dead){
        //check if we hit the target
        hitTest(*target);
    }else{
        enabled=false;
    }
    
}

float Missile::generateRotation(float _x, float _y){
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
    if(!enabled) return;
    
    spriteRenderer->draw();
}

bool Missile::hitTest(BasicObject &ship){
    //hit the ship
    if(x < ship.x+ship.width/2 && x > ship.x-ship.width/2 &&
       y < ship.y+ship.height/2 && y > ship.y-ship.height/2
       ){
        if(derez())
            dead=true;
        if(ship.getColor() == this->color){ 
            if(ship.derez()){   //if ship is the same color & on last life, destroy it
                SpawnManager::getInstance()->notifyShipDestroyed();
                ship.dead=true;
                SoundManager::getInstance()->missileSuccess.play();
            }
        }else{
            SpawnManager::getInstance()->resetColorStreak();
            SoundManager::getInstance()->missileFailure.play();
            Stats::getInstance()->incrementStat("colorBlind", 1);
        }
        return true;
    }else{
        return false;
    }
    
}