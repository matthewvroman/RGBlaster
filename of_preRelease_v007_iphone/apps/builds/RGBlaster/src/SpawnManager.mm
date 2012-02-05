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
    finger=nil;
    
    gameOver=false;
    
    currentFrame=0;
    spawnInterval=260; //in frames //game runs at 60fps
    spawnDecrementer=5;
    
    difficulty=1;
    
    numWaves=0;
    nextDifficultyIncrease=3;
    
    maxMovementLevel=0;
    maxResolution=0;
    maxColor=0;
    maxShips=5;
    maxShipSpeed=1.5;
    maxMultiplier=1;
    colorStreak=0;
    chanceToSpawnMulticore=0.0;
    coresPerShip=1;
    colorsPerMulticoreShip=1;
    coresShouldFlash=false;
    coreFlashSpeed=2;
    
    
    powerUpName = "";
    
    powerUp=-1;
    
    //power ups last for 10s
    powerUpLength=10;
    
    powerUpTimer=powerUpEndTime=0;
    
    //spawnGroup();
    //Resolution _res=BIT8, int _numCores=3, int _numColors=3, bool _flashingColors=false, float _switchTime=1.0)
    MulticoreShip *shipTest = new MulticoreShip(150, 150, maxShipSpeed, BIT8,3,1,false,1);
    activeMulticoreShips.push_back(shipTest);
}

SpawnManager* SpawnManager::getInstance(){
    if(!instance)
        instance = new SpawnManager;
    return instance;
}

void SpawnManager::setHUD(HUD *_hud){
    hud = _hud;
}

void SpawnManager::setFinger(Finger *_finger){
    finger = _finger;
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
        hud->increaseHealth(10);
        SoundManager::getInstance()->missileSuccess.play();
        incrementColorStreak(1);
    }
}

void SpawnManager::incrementColorStreak(int _incremenet){
    colorStreak+=_incremenet;
    
    if(colorStreak==45){
        generatePowerUp();
    }
}

void SpawnManager::generatePowerUp(){
    
    //remove previous power up so we can replace it
    removePowerUp();
    
    //powerUp=2;
    powerUp = (int)ofRandom(2);
    applyPowerUp();
    
    if(notifier!=nil){
        notifier->displayNotification(powerUpName);
    }
    
    resetColorStreak();
    
    hud->setPowerUpCountString(powerUpLength);
}

void SpawnManager::applyPowerUp(){
    powerUpName = "";
    switch (powerUp) {
        case 0:
            //slow time
            powerUpName = "Slow Time";
            for (short i=0; i<activeGroups.size(); i++) {
                activeGroups.at(i)->speed=1;
            }
            break;
        case 1:
            //reticule radius increase
            powerUpName = "Range Up";
            if(finger!=nil){
                finger->powerUp();
            }
            break;
        case 2:
            //mono color
            powerUpName = "Mono Color";
            
            break;
            
        default:
            powerUpName = "";
            break;
    }
}

void SpawnManager::removePowerUp(){
    cout << "removing power up" << endl;
    powerUpName = "";
    switch (powerUp) {
        case 0:
            //slow time
            powerUpName = "Slow Time";
            for (short i=0; i<activeGroups.size(); i++) {
                activeGroups.at(i)->resetSpeed();
            }
            break;
        case 1:
            //reticule radius increase
            powerUpName = "Range Up";
            if(finger!=nil){
                finger->powerDown();
            }
            break;
        case 2:
            //mono color
            powerUpName = "Mono Color";
            
            break;
        default:
            powerUpName = "";
            break;
    }
    
    powerUp=-1;
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
    removeAllMulticoreShips();
}

void SpawnManager::update(){
    if(!gameOver){
        if(currentFrame>=spawnInterval){
            //spawn group
            spawnEnemy();
        
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
        
        short j=0;
        while(j<activeMulticoreShips.size()){
            activeMulticoreShips[j]->update();
            if(activeMulticoreShips[j]!=nil && activeMulticoreShips[j]->dead)
                removeMulticoreShip(j);
            j++;
        }
        
        //if we have a power up
        if(powerUp>=0){
            //start counting
            powerUpTimer%=60;
            powerUpTimer++;
            
            //increment our timer every second
            if(powerUpTimer==60){
                powerUpEndTime+=1;
                
                hud->setPowerUpCountString(powerUpLength-powerUpEndTime);
                
                //remove the power up once we hit the limit
                if(powerUpEndTime==powerUpLength){
                    removePowerUp();
                    powerUpEndTime=0;
                }
            }
        }
    }
}

void SpawnManager::spawnEnemy(){
    float _randNum = ofRandom(1);
    if(_randNum<chanceToSpawnMulticore){
        spawnMulticoreShip();
    }else{
        spawnGroup();
    }
    
    //increase difficulty every 5 waves
    numWaves++;
    if(numWaves>=nextDifficultyIncrease){
        increaseDifficulty();
        numWaves=0;
        //nextDifficultyIncrease*=nextDifficultyIncrease;
    }
    
    applyPowerUp();
}

void SpawnManager::spawnMulticoreShip(){
    MulticoreShip *coreShip = new MulticoreShip(ofRandom(600)+100,0,maxShipSpeed-1,resolution, coresPerShip,colorsPerMulticoreShip, coresShouldFlash);
    activeMulticoreShips.push_back(coreShip);
}

void SpawnManager::spawnGroup(){

    Group *group = new Group(maxShips, Color(int(ofRandom(0, maxColor))), resolution, MovementType(int(maxMovementLevel)),maxShipSpeed);
    
    activeGroups.push_back(group);

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

void SpawnManager::removeMulticoreShip(int _pos){
    if(_pos!=activeGroups.size()-1){
        //Temporarily tore our last element in the vector
        MulticoreShip *holder=activeMulticoreShips[activeMulticoreShips.size()-1];
        
        //move the ship we want to delete to the endof the position
        activeMulticoreShips[activeMulticoreShips.size()-1]=activeMulticoreShips[_pos];
        
        //put the old last element in the TBDeleted spot
        activeMulticoreShips[_pos]=holder;
    }
    
    //delete the ship
    delete activeMulticoreShips[activeMulticoreShips.size()-1];
    
    //resize the vector
    activeMulticoreShips.pop_back();
    cout << "removed multicore ship" << endl;
    
    
}

void SpawnManager::removeAllGroups(){
    while(activeGroups.size()>0){
        delete activeGroups[activeGroups.size()-1];
        activeGroups.pop_back();
    }
}

void SpawnManager::removeAllMulticoreShips(){
    while(activeMulticoreShips.size()>0){
        delete activeMulticoreShips[activeMulticoreShips.size()-1];
        activeMulticoreShips.pop_back();
    }
}


void SpawnManager::increaseDifficulty(){
    difficulty++;
    
    switch(difficulty){
        case 1:
            maxColor=1;
            maxMovementLevel=0;
            maxShipSpeed=1.5;
            maxShips=5;
            break;
        case 2:
            maxMovementLevel=1;
        case 3:
            maxColor=2;
            break;
        case 4:
            maxMovementLevel=2;
            break;
        case 5:
            maxColor=3;
            break;
        case 6:
            maxShipSpeed=2;
            maxShips=7;
            break;
        case 7:
            chanceToSpawnMulticore=0.2;
            coresPerShip=2;
            colorsPerMulticoreShip=1;
            break;
        case 8:
            coresPerShip=2;
            colorsPerMulticoreShip=2;
            break;
        case 9:
            coresShouldFlash=YES;
            break;
        case 10:
            coresPerShip=3;
            coresShouldFlash=NO;
            chanceToSpawnMulticore=0.25;
            break;
        case 11:
            maxShips=9;
            colorsPerMulticoreShip=3;
            break;
        case 12:
            coresShouldFlash=YES;
            break;
        case 13:
            maxShipSpeed=2.25;
            break;
        case 14:
            coreFlashSpeed=1.85;
            chanceToSpawnMulticore=0.3;
            break;
        default:
            if(coreFlashSpeed>=0.25){
                coreFlashSpeed-=0.05;
            }
            if(maxShipSpeed<4.5){
                maxShipSpeed+=0.05;
            }
            if(chanceToSpawnMulticore<0.5){
                chanceToSpawnMulticore+=0.05;
            }
            break;
            
            
            /*
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
        case 6:
            maxShips=10;
            maxMultiplier=2;
        case 7:
            maxShips=10;
        case 8:
            maxShips=10;
        case 9:
            maxShips=12;
            maxMultiplier=3;
        case 10:
            maxShips=12;
        default:
            maxMovementLevel=2;
            maxColor=3;
            maxResolution=3;
            maxShips=14;
            maxMultiplier=4;
            break;
             */
    }
}


void SpawnManager::draw(){

    short i=0;
    while(i<activeGroups.size()){
        activeGroups[i]->draw();
        i++;
    }
    
    short j=0;
    while(j<activeMulticoreShips.size()){
        activeMulticoreShips[j]->draw();
        j++;
    }
}
