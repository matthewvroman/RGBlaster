//
//  World.cpp
//  RGBlaster
//
//  Created by Matthew Vroman on 10/25/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles the gameplay portion of the app
//               Handles calling the HUD, Blaster, and Spawn Manager

#include "World.h"

//constructor sets initial values
World::World(){
    
    resolution=Resolution(0);
    
    handler = AtlasHandler::getInstance();
    
    notifier = new Notifier();
    
    spawner = SpawnManager::getInstance();
    spawner->gameOver = false;
    spawner->resolution=Resolution(0);
    spawner->currentFrame=0;
    spawner->spawnInterval=260; //in frames //game runs at 60fps
    spawner->spawnDecrementer=5;
    spawner->difficulty=1;
    spawner->numWaves=0;
    spawner->nextDifficultyIncrease=4;
    spawner->maxMovementLevel=0;
    spawner->maxResolution=0;
    spawner->maxColor=0;
    spawner->maxShips=5;
    spawner->maxShipSpeed=5;
    spawner->maxMultiplier=1;
    spawner->setNotifier(notifier);
    
    spawnBlaster();
    
    hud = new HUD();
    
    spawner->setHUD(hud);
    
    motivator.loadImage("sprites/motivator.png");
    
    background8.loadImage("sprites/background-8bit.png");
    background16.loadImage("sprites/background-16bit.png");
    background32.loadImage("sprites/background-32bit.png");
    
    enabled=true;
    if(!SoundManager::getInstance()->backgroundMusic.getIsPlaying())
        SoundManager::getInstance()->backgroundMusic.play();
}

//delete any dynamically allocated memory
World::~World(){
    delete notifier;
    delete hud;
    delete blaster;
}

//spawn the blaster at the bottom of the screen
void World::spawnBlaster(){
    blaster = new Blaster();
    if(spawner!=nil)
        blaster->setSpawner(spawner);
}

void World::drawMotivator(){
    motivator.draw(384-motivator.width/2, 512-motivator.height/2);
}

//res up everything in the world
void World::rezUp(){
    if(resolution<2){
        resolution=Resolution(int(resolution)+1);
        spawner->setResolution(resolution);
        blaster->setResolution(resolution);
        notifier->displayNotification("RES UP!");
        SoundManager::getInstance()->resUp.play();
    }else{
        hud->resetHealth();
    }
    
}

//res down everything in the world
void World::rezDown(){

    if(resolution>0){
        resolution=Resolution(int(resolution)-1);
        spawner->setResolution(resolution);
        blaster->setResolution(resolution);
        notifier->displayNotification("RES DOWN!");
        hud->resetHealth();
        SoundManager::getInstance()->resDown.play();
    }else{
        hud->gameOver=true;
        spawner->notifyGameOver();
        SoundManager::getInstance()->gameOver.play();
        SoundManager::getInstance()->backgroundMusic.stop();
    }

}

//check the res status of the world
void World::checkRezStatus(){
    if(hud!=nil){
        if(hud->rezUp){
            rezUp();
            hud->rezUp=false;
        }
        if(hud->rezDown){
            rezDown();
            hud->rezDown=false;
        }
    }
}

//--------------------------------------------------------------

void World::update(){
    if(!enabled) return;
    handler->update();
    notifier->update();
    spawner->update();
    blaster->update();
    hud->update();
    checkRezStatus();
    
}

//draw the proper background based on current world resolution
void World::drawBackground(){
    switch (int(resolution)) {
        case 0:
            background8.draw(0,0);
            break;
        case 1:
            background16.draw(0,0);
            break;
        case 2:
            background32.draw(0,0);
            break;
        default:
            background8.draw(0,0);
            break;
    }
}


void World::draw(){
    if(!enabled) return;
    //drawBackground();
    notifier->draw();
    spawner->draw();
    blaster->draw();
    hud->draw();

}