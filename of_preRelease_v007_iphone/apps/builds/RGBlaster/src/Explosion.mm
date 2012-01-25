//
//  Explosion.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 1/25/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#include <iostream>
#import "Explosion.h"

Explosion::Explosion(int posX, int posY){
    
    spriteRenderer=AtlasHandler::getInstance()->explosionRenderer;
    
    ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    sprite = new basicSprite(); // create a new sprite
    
    sprite->pos.set(0,0); //set its position
    
    
    sprite->speed=1; //set its speed
    sprite->animation = explodeAnimation; //set its animation to the walk animation we declared
    sprite->animation.frame_duration = 5; //adjust its frame duration based on how fast it is walking (faster = smaller)
    sprite->animation.index = 0;
    
    speed=3;
    
    this->setPosition(posX, posY);
    
    type = MISSILE;
    
    dead = false;
    
    enabled=true;
    
    
}

Explosion::~Explosion(){
    //remove self-contained calls to update & draw
    enabled=false;
    
    //delete allocated memory
    delete sprite;
    
}

void Explosion::update(){
    if(!enabled) return;
    if(sprite!=NULL && !dead){
        //positioning is handled in the draw func
        spriteRenderer->addCenteredTile(&sprite->animation, 0,0);
    }
    
    move(0, -speed);
    if(sprite->animation.frame==7){
        dead=true;
    }

    //if we're dead, remove body
    if(dead){
        enabled=false;
    }
}

void Explosion::draw(){
    if(!enabled) return;
    
    ofPushMatrix();
    ofTranslate(x, y);
    ofScale(2,2);
    spriteRenderer->draw();
    ofPopMatrix();
}
