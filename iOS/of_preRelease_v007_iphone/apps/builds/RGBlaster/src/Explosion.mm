//
//  Explosion.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 1/25/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#include <iostream>
#import "Explosion.h"

Explosion::Explosion(int posX, int posY, Color _color, Resolution _res,float _scale,bool _gray){
    
    spriteRenderer=AtlasHandler::getInstance()->explosionRenderer;
    
    ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    sprite->pos.set(0,0); //set its position
    
    
    sprite->speed=1; //set its speed
    sprite->animation = explodeAnimation; //set its animation to the walk animation we declared
    sprite->animation.index = (48*int(_res)+16*int(_color));
    if(_gray){
        sprite->animation.index=(160+16*int(_res));
    }
    //sprite->animation.index = (int(_color)*16)*(3*_res);
    speed=3;
    
    scale=_scale;
    
    this->setPosition(posX, posY);
    
    type = MISSILE;
    
    dead = false;
    
    enabled=true;
    
    
}

Explosion::~Explosion(){
    //remove self-contained calls to update & draw
    enabled=false;
    
}

void Explosion::update(){
    if(!enabled || dead) return;
    if(sprite!=NULL && !dead){
        //positioning is handled in the draw func
        spriteRenderer->addCenteredTile(&sprite->animation, x,y,-1,F_NONE,scale,saturation,saturation,saturation,255);
        if(sprite->animation.frame==7){
            dead=true;
        }
    }
    
    move(0, -speed);

    //if we're dead, remove body
    if(dead){
        enabled=false;
    }
}

void Explosion::draw(){
    if(!enabled || dead) return;
    
    spriteRenderer->draw();
}
