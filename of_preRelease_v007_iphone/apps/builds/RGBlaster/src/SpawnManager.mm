//
//  SpawnManager.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/10/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//

#include <iostream>
#include "SpawnManager.h"
SpawnManager* SpawnManager::instance = NULL;

SpawnManager::SpawnManager(){

    enabled=true;
    
    resolution=Resolution(0);
    
    hud=nil;
    notifier=nil;
    
    gameOver=false;
    
    currentFrame=0;
    spawnInterval=260; //in frames //game runs at 60fps
    spawnDecrementer=5;
    
    difficulty=1;
    
    numWaves=0;
    nextDifficultyIncrease=4;
    
    maxMovementLevel=0;
    maxResolution=0;
    maxColor=0;
    maxShips=5;
    maxShipSpeed=5;
    maxMultiplier=1;
    colorStreak=0;
    
    //spawnGroup();
}

SpawnManager* SpawnManager::getInstance(){
    if(!instance)
        instance = new SpawnManager;
    return instance;
}

void SpawnManager::setHUD(HUD *_hud){
    hud = _hud;
}

void SpawnManager::setResolution(Resolution _res){
    resolution=_res;
    //update each group as well
    short i=0;
    while(i<activeGroups.size()){
        activeGroups[i]->setResolution(resolution);
        i++;
    }

}

void SpawnManager::setNotifier(Notifier *_notifier){
    notifier=_notifier;
}

void SpawnManager::notifyShipDestroyed(){
    if(hud!=nil){
        hud->incrementScore(5*maxMultiplier*(resolution+1));
        hud->increaseHealth(1);
        SoundManager::getInstance()->missileSuccess.play();
        incrementColorStreak(1);
    }
}

void SpawnManager::incrementColorStreak(int _incremenet){
    colorStreak+=_incremenet;
    
    if(colorStreak==50){
        resetColorStreak();
        generatePowerUp();
    }
}

void SpawnManager::generatePowerUp(){
    if(notifier!=nil){
        //0-2
        int randPowerUp = (int)ofRandom(3);
        switch (randPowerUp) {
            case 0:
                //slow time
                break;
            case 1:
                //mono coor
                break;
            case 2:
                //reticule radius increase
                break;
            default:
                cout << "shouldn't happen" << endl;
                break;
        }
        
        notifier->displayNotification("POWER UP");
    }
}

void SpawnManager::decrementColorStreak(int _decrement){
    colorStreak-=_decrement;
}

void SpawnManager::resetColorStreak(){
    colorStreak=0;
}

void SpawnManager::notifyShipCrashed(int _dmg){
    hud->decreaseHealth(_dmg+maxMultiplier);
    SoundManager::getInstance()->explosion.play();
}

void SpawnManager::notifyGameOver(){
    gameOver=true;
    hud->setHighScore(hud->getScore());
    removeAllGroups();
}

void SpawnManager::update(){
    if(!gameOver){
        if(currentFrame>=spawnInterval){
            //spawn group
            spawnGroup();
        
            //reset frame counter
            currentFrame=0;
        
            //decrement time between spawns
            if(spawnInterval-spawnDecrementer>60)
                spawnInterval-=spawnDecrementer;
            else
                spawnInterval=60;
        
        }else{
            currentFrame++;
        }
        short i=0;
        while(i<activeGroups.size()){
            activeGroups[i]->update();
            if(activeGroups[i]!=nil && activeGroups[i]->dead)
                removeGroup(i);
            i++;
        }
    }
    
    
    
}

void SpawnManager::spawnGroup(){

    Group *group = new Group(maxShips, Color(int(ofRandom(0, maxColor))), resolution, MovementType(int(maxMovementLevel)));
    
    activeGroups.push_back(group);
    
    //increase difficulty every 5 waves
    numWaves++;
    if(numWaves>=nextDifficultyIncrease){
        increaseDifficulty();
        numWaves=0;
        //nextDifficultyIncrease*=nextDifficultyIncrease;
    }

}

void SpawnManager::removeGroup(int _pos){
    if(_pos!=activeGroups.size()-1){
        //Temporarily tore our last element in the vector
        Group *holder=activeGroups[activeGroups.size()-1];
        
        //move the ship we want to delete to the endof the position
        activeGroups[activeGroups.size()-1]=activeGroups[_pos];
        
        //put the old last element in the TBDeleted spot
        activeGroups[_pos]=holder;
    }
    
    //delete the ship
    delete activeGroups[activeGroups.size()-1];
    
    //resize the vector
    activeGroups.pop_back();
    
}

void SpawnManager::removeAllGroups(){
    while(activeGroups.size()>0){
        delete activeGroups[activeGroups.size()-1];
        activeGroups.pop_back();
    }
}


void SpawnManager::increaseDifficulty(){
    difficulty++;
    
    switch(difficulty){
        case 1:
            maxColor=1;
            maxShips=5;
            maxMultiplier=1;
            maxMovementLevel=0;
            break;
        case 2:
            maxResolution=1;
            maxColor=2;
            maxShips=6;
            maxMultiplier=1;
            maxMovementLevel=2;
            break;
        case 3:
            maxColor=3;
            maxShips=7;
            maxMultiplier=2;
            maxMovementLevel=2;
            break;
        case 4:
            maxColor=3;
            maxShips=8;
            maxMultiplier=2;
            break;
        case 5:
            maxResolution=3;
            maxShips=9;
            maxMultiplier=3;
            break;
        default:
            maxMovementLevel=2;
            maxColor=3;
            maxResolution=3;
            maxShips=10;
            maxMultiplier=4;
            break;
    }
}


void SpawnManager::draw(){
    short i=0;
    while(i<activeGroups.size()){
        activeGroups[i]->draw();
        i++;
    }
}
