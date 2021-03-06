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
    spawner->setInitialValues();
    spawner->setNotifier(notifier);
    
    spawnBlaster();
    
    //give the spawner the blaster's finger object for power-ups
    spawner->setFinger(blaster->finger);
    
    hud = new HUD();
    
    spawner->setHUD(hud);
    
    background8=AtlasHandler::getInstance()->background8;
    background16=AtlasHandler::getInstance()->background16;
    background32=AtlasHandler::getInstance()->background32;
    
    
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
    hud->gameOver=true;
    spawner->notifyGameOver();
    SoundManager::getInstance()->gameOver.play();
    SoundManager::getInstance()->backgroundMusic.stop();
}

void World::derezAll(){
    hud->gameOver=true;
    spawner->notifyGameOver();
    SoundManager::getInstance()->resDown.play();
    SoundManager::getInstance()->gameOver.play();
    SoundManager::getInstance()->backgroundMusic.stop();

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
    
    blaster->update();
    spawner->update();
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
    drawBackground();
    notifier->draw();
    spawner->draw();
    blaster->draw();
    hud->draw();

}