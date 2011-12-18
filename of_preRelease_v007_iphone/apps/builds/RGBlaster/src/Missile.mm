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

Missile::Missile(int posX, int posY, Color _color, Resolution _res, Ship *_target){
    enabled=true;
    
    color=_color;
    resolution=_res;
    
    
    spriteRenderer=AtlasHandler::getInstance()->missileRenderer;
    
    ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    sprite = new basicSprite(); // create a new sprite
    
    sprite->pos.set(0,0); //set its position
    
    
    sprite->speed=1; //set its speed
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    sprite->animation.frame_duration = 5; //adjust its frame duration based on how fast it is walking (faster = smaller)
    
    sprite->animation.index = int(color);
    
    target=_target;
    
    speed=10;
    
    type = MISSILE;
    
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
    
    if(sprite!=NULL && !dead){
        spriteRenderer->addCenteredTile(
                                        &sprite->animation, 
                                        this->getPosition().x, 
                                        this->getPosition().y
                                        );
    }
    
    //Get the targets position and adjust path accordingly
    if(target->dead!=true){
        relativePos = target->getPosition()-this->getPosition();
    }else{
        dead=true;
        relativePos=this->getPosition();
    }
    
    ofVec2f direction;
    if(relativePos.x<speed && relativePos.x >-speed){
        direction.x=0;
    }else if(relativePos.x>speed){
        direction.x=speed/2;
    }else{
        direction.x=-speed/2;
    }
    if(relativePos.y<speed && relativePos.y>-speed){
        direction.y=0;
    }else if(relativePos.y>speed){
        direction.y=speed;
    }else{
        direction.y=-speed;
    }
    
    move(direction.x,direction.y);
    
    //check if we hit the target
    hitTest(*target);
    
    //if we're dead, remove body
    if(dead){
        enabled=false;
    }
    
}

void Missile::draw() {
    if(!enabled) return;
    
    spriteRenderer->draw();
}

bool Missile::hitTest(Ship &ship){
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
            SoundManager::getInstance()->missileFailure.play();
        }
        return true;
    }else{
        return false;
    }
    
}