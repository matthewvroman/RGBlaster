//
//  Target.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Assigns targets to individual ships

#include <iostream>
#import "Target.h"

Target::Target(){
    enabled=true;

    /*SPRITE DRAWING*/
    //int _numLayers, int _tilesPerLayer, int _defaultLayer, int _tileSize
    spriteRenderer = new ofxSpriteSheetRenderer(1, 1000, 0, 64);
    spriteRenderer->loadTexture("sprites/targeting_spriteSheet.png", 256, GL_NEAREST); // load the spriteSheetExample.png texture of size 256x256 into the sprite sheet. set it's scale mode to nearest since it's pixel art
	ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    sprite = new basicSprite(); // create a new sprite
    sprite->pos.set(0,0); //set its position
    sprite->speed=1; //set its speed
    sprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    sprite->animation.frame_duration = 5; //adjust its frame duration based on how fast it is walking (faster = smaller)
    sprite->animation.index = 0; //change the start index of our sprite. we have 4 rows of animations and our spritesheet is 8 tiles wide, so our possible start indicies are 0, 8, 16, and 24
    
    //reserve 10 spots for ships
    targets.reserve(10);
}

Target::~Target(){
    enabled=false;
    delete spriteRenderer;
}

void Target::changeColor(Color _color){
    sprite->animation.index = int(_color);
}

void Target::addTarget(BasicObject *ship){
    targets.push_back(ship);
    //play sfx
    SoundManager::getInstance()->targeted.play();
}

void Target::clearTargets(){
    short i=0;
    while(i<targets.size()){
        targets.at(i)->targeted=false;
        i++;
    }
    targets.clear();
}

void Target::update(){
    if(!enabled) return;
        
    spriteRenderer->clear(); // clear the sheet
	spriteRenderer->update(ofGetElapsedTimeMillis()); //update the time in the renderer, this is necessary for animations to advance
    short i=0;
    while(i<targets.size()){
        if(targets[i]!=NULL && !targets[i]->dead){
            spriteRenderer->addCenteredTile(
                                        &sprite->animation, 
                                        targets[i]->getPosition().x, 
                                        targets[i]->getPosition().y
                                        );
        }else{
            removeTarget(i);
        }
        
        i++;
    }

}

void Target::removeTarget(int _pos){
    
    if(_pos!=targets.size()-1){
        //Temporarily store our last element in the vector
        BasicObject *holder=targets[targets.size()-1];
        
        //move the ship we want to delete to the endof the position
        targets[targets.size()-1]=targets[_pos];
        
        //put the old last element in the TBDeleted spot
        targets[_pos]=holder;
        
    }
    
    //resize the vector
    targets.pop_back();
    
    
}

void Target::draw(){
    if(!enabled) return;
    spriteRenderer->draw();
}