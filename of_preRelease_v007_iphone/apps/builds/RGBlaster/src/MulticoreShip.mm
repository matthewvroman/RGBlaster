//
//  MulticoreShip.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 1/31/12.
//  Copyright (c) 2012 RGBeast. All rights reserved.
//

#include <iostream>
#include "MulticoreShip.h"
#include "SpawnManager.h"

MulticoreShip::~MulticoreShip(){
    
}

//called from constructor
void MulticoreShip::initCores(){
    cout << "new multicore ship" << endl;
    spriteRenderer=AtlasHandler::getInstance()->multicoreShipRenderer;
    
    dead=destroyed=false;
    
    scale=2.5;
    
    speed=2;
    
    addCore(0, -20);
    addCore(-45, -10);
    addCore(45,-10);
    
    
}
                           
void MulticoreShip::addCore(float _x, float _y){
    Core *tCore = new Core(x+_x,y+_y,1,RED,BIT8);
    cores.push_back(tCore);
}

//remove a ship from the vector
void MulticoreShip::removeCore(int _pos){
    //cout << "remove from vector" << endl;
    if(_pos!=cores.size()-1){
        //Temporarily store our last element in the vector
        Core *holder=cores[cores.size()-1];
        
        //move the ship we want to delete to the endof the position
        cores[cores.size()-1]=cores[_pos];
        
        //put the old last element in the TBDeleted spot
        cores[_pos]=holder;
        
    }
    
    //spawn explosion
    Explosion *explosion = new Explosion(cores[cores.size()-1]->getPosition().x,cores[cores.size()-1]->getPosition().y, cores[cores.size()-1]->getColor(), cores[cores.size()-1]->getRes());
    explosions.push_back(explosion);
    
    //delete the ship
    delete cores[cores.size()-1];
    
    //resize the vector
    cores.pop_back();
    
    //if we're out of cores then create a huge explosion for the ship
    if(cores.size()==0 && !destroyed){
        //spawn explosion
        Explosion *explosion = new Explosion(this->getPosition().x,this->getPosition().y, this->getColor(), this->getRes(),10);
        explosions.push_back(explosion);
        destroyed=true;
    }
}

//remove a ship from the vector
void MulticoreShip::removeExplosion(int _pos){
    if(_pos!=cores.size()-1){
        //Temporarily store our last element in the vector
        Explosion *holder=explosions[explosions.size()-1];
        
        //move the ship we want to delete to the endof the position
        explosions[explosions.size()-1]=explosions[_pos];
        
        //put the old last element in the TBDeleted spot
        explosions[_pos]=holder;
        
    }
    
    //delete the explosion
    delete explosions[explosions.size()-1];
    
    //resize the vector
    explosions.pop_back();
    
    //check if our group should still exist
    if(explosions.size()==0 && cores.size()==0 ){
        dead=true;
        enabled=false;
    }
    
}

void MulticoreShip::update(){
    if(!enabled) return;
    
    spriteRenderer->clear(); // clear the sheet
	spriteRenderer->update(ofGetElapsedTimeMillis()); //update the time in the renderer, this is necessary for animations to advance
    
    if(sprite!=NULL && !dead && !destroyed){
        spriteRenderer->addCenteredTile(&sprite->animation,0,0);
    }
    
    short i=0;
    while(i<cores.size()){
        cores[i]->update();
        
        //check pos
        if(cores[i]->getPosition().y>995){
            cores[i]->dead=true;
            cores[i]->enabled=false;
            SpawnManager::getInstance()->notifyShipCrashed(10);
        }
        
        if(cores[i]->dead){
            removeCore(i);
        }
        i++;
    }
    
    short ctr=0;
    while(ctr < explosions.size()){
        if(explosions[ctr]->dead){
            //remove explosion
            removeExplosion(ctr);
        }
        explosions[ctr]->update();
        ctr++;
    }
    
    
    move(0,speed);
    
    
}

void MulticoreShip::move(float _x, float _y){
    this->setPosition(x+_x,y+_y);
    short i=0;
    while(i<cores.size()){
        cores[i]->setPosition(cores[i]->x+_x, cores[i]->y+_y);
        i++;
    }
    
}

void MulticoreShip::draw(){
    if(!enabled) return;
    
    if(!destroyed){
        ofPushMatrix();
        ofTranslate(x,y);
        ofScale(scale, scale);
        spriteRenderer->draw();
        ofPopMatrix();
    }
    
    short i=0;
    while(i<cores.size()){
        cores[i]->draw();
        i++;
    }
    
    short ctr=0;
    while(ctr < explosions.size()){
        explosions[ctr]->draw();
        ctr++;
    }
}