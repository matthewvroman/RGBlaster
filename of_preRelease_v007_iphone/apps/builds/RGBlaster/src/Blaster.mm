//
//  Blaster.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/3/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Blaster object that sits at the bottom of the screen
//               Allows for targeting & missile firing

#import "Blaster.h"
#import "SoundManager.h"

Blaster::Blaster(){
    
    enabled=true;
    
    lastTouch=nil;
    
    //how many pixels the user must swipe for the blaster to rotate
    leeway=75;
    
    ofAddListener(ofEvents.touchDown, this, &Blaster::touchDown);
	ofAddListener(ofEvents.touchUp, this, &Blaster::touchUp);
    
    /*SPRITE DRAWING*/
    //int _numLayers, int _tilesPerLayer, int _defaultLayer, int _tileSize
    setSpriteTexture("sprites/blaster_sprite.png", 768, 192);
    
	ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    //default color/res at the start of the game
    color = RED;
    resolution=BIT8;
    
    updateSpriteSheet();
    
    type = BLASTER;
    
    spawner = nil;
    
    finger = new Finger();
    targetOverlay = finger->target;
    
    width=192;
    height=192;
    
    setPosition(384, 1000);
}

Blaster::~Blaster(){
    ofRemoveListener(ofEvents.touchDown, this, &Blaster::touchDown);
	ofRemoveListener(ofEvents.touchUp, this, &Blaster::touchUp);
    delete finger; 
}

void Blaster::touchDown(ofTouchEventArgs &touch) {

    //hit test that requires you to touch the blaster at start of swipe
    /*if(touch.x < this->x+this->width/2 && touch.x > this->x-this->width/2 &&
       touch.y < this->y+this->height/2 && touch.y > this->y-this->height/2){*/
    
    //hit test that requires you to just be at the same y coordinates as the blaster
    if(touch.y < this->y+this->height/2 && touch.y > this->y-this->height/2){
        lastTouch.x=touch.x;
        lastTouch.y=touch.y;
        
    }else{
        lastTouch=nil;
    }
    
}

//Swap colors if the swipe moved far enough from touchDown to touchUp
void Blaster::touchUp(ofTouchEventArgs &touch) {
    if(lastTouch!=nil){
        if(touch.x<lastTouch.x-leeway){
            color=Color(int(color)+1);
            if(int(color)>2)
                color=Color(0);
            SoundManager::getInstance()->spin.play();
        }
        if(touch.x>lastTouch.x+leeway){
            color=Color(int(color)-1);
            if(int(color)<0)
                color=Color(2);
            SoundManager::getInstance()->spin.play();
                
        }
        updateSpriteSheet();
        finger->setColor(color);
        targetOverlay->changeColor(color);
    }
    
}

void Blaster::addTarget(BasicObject *target){
    if(!target->targeted){
        targets.push_back(target);
        target->targeted = true;
    }
}

void Blaster::setSpawner(SpawnManager *_spawner){
    spawner = _spawner;
}

//check finger collisions & spawn a missile if there'sa hit
void Blaster::update(){
    if(!enabled) return;
    if(finger->down && spawner != nil){
        for(short i=0; i<spawner->activeGroups.size(); i++){
            for(short j=0; j<spawner->activeGroups[i]->objects.size(); j++){
                if(finger->hitTest(*spawner->activeGroups[i]->objects[j])){
                    float _x=this->getPosition().x;
                    float _y=this->getPosition().y;
                    Missile *missile = new Missile(_x,_y,color,resolution,spawner->activeGroups[i]->objects[j]);
                    missiles.push_back(missile);
                }
            }
        }
    }
    
    targetOverlay->update();
    
    finger->update();
    
    for(short i=0; i<missiles.size(); i++){
        missiles.at(i)->update();
        if(missiles.at(i)->dead){
            removeMissile(i);
        }
    }
    
    BasicObject::update();
}

void Blaster::removeMissile(int _pos){
    if(_pos!=missiles.size()-1){
        //Temporarily store our last element in the vector
        Missile *holder=missiles[missiles.size()-1];
        
        //move the element we want to delete to the endof the position
        missiles[missiles.size()-1]=missiles[_pos];
        
        //put the old last element in the TBDeleted spot
        missiles[_pos]=holder;
    }
    
    delete missiles[missiles.size()-1];
    
    //resize the vector
    missiles.pop_back();
}

void Blaster::draw(){
    if(!enabled) return;
    
    targetOverlay->draw();
    
    finger->draw();
    
    for(short i=0; i<missiles.size(); i++){
        missiles.at(i)->draw();
    }
    
    spriteRenderer->draw();
}

void Blaster::switchColor(){
    switch(color){
        case RED:
            color = GREEN;
            break;
        case GREEN:
            color = BLUE;
            break;
        case BLUE:
            color = RED;
            break;
    }
    SoundManager::getInstance()->spin.play();
    finger->setColor(color);
    updateSpriteSheet();
}

void Blaster::setResolution(Resolution _res){
    resolution=_res;
    updateSpriteSheet();
}

//update sprite sheet to accurately reflect color & res
void Blaster::updateSpriteSheet(){
    sprite->animation.index = 4*int(resolution)+int(color);
}