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
    //cout << "new multicore ship" << endl;
    spriteRenderer=AtlasHandler::getInstance()->multicoreShipRenderer;
    
    dead=destroyed=false;
    
    scale=2.5;
    
    //we can't have more colors than cores
    if(numColors>numCores){
        numColors=numCores;
    }
    
    this->setColor(Color(int(ofRandom(0, 3))));
    
    //middle core
    if(numCores==1 || numCores>2){
        addCore(0, -25);
    }
    
    if(numCores>=2){
        //left & right cores
        addCore(-35, -10);
        addCore(35,-10);
    }
    
    sprite->animation = multicoreShipAnimation;
    
    
}
                           
void MulticoreShip::addCore(float _x, float _y){
    
    //make sure the colors added are balanced
    Color _coreColor;
    if(numCores>1){
        switch(numColors){
            case 1:
                if(cores.size()==0){
                     _coreColor=Color(int(ofRandom(0, 3)));
                }
                break;
            //2 colors
            case 2:
                if(cores.size()==0){
                    _coreColor=this->getColor();
                }else{
                    _coreColor=this->incrementColor(this->getColor()); //+1
                }
                break;
            case 3:
                if(cores.size()==0){
                    _coreColor=this->getColor();
                }else{
                    this->setColor(this->incrementColor(this->getColor())); //+1
                    _coreColor=this->getColor();
                }
                break;
        }
    }else{
        _coreColor=Color(int(ofRandom(0, 3)));
    }
    
    Core *tCore = new Core(x+_x,y+_y,1,_coreColor,this->getRes());
    cores.push_back(tCore);
}

Color MulticoreShip::incrementColor(Color _color){
    int _colorPos=int(_color);
    _colorPos++;
    if(_colorPos>=3){
        _colorPos=0;
    }
    return Color(_colorPos);
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
        
        //TODO: GRAY EXPLOSION
        Explosion *explosion = new Explosion(this->getPosition().x,this->getPosition().y, RED, resolution,10,true);
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
    
    //spriteRenderer->clear(); // clear the sheet
	//spriteRenderer->update(ofGetElapsedTimeMillis()); //update the time in the renderer, this is necessary for animations to advance
    if(flashingColors){
        timeCounter++;
    
        if(timeCounter>=switchSpeed){
            timeCounter=0;
            for(short i=0; i<cores.size(); i++){
                cores[i]->setColor(this->incrementColor(cores[i]->getColor()));
            }
        }
    }

    
    if(sprite!=NULL && !dead && !destroyed){
        //spriteRenderer->addCenteredTile(&sprite->animation,0,0);
        spriteRenderer->addCenteredTile(&sprite->animation, x,y,-1,F_NONE,scale);
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
        spriteRenderer->draw();
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