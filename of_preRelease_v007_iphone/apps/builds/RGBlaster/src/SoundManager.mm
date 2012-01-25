//
//  SoundManager.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Manages all the music & sfx in the game

//CONVERT TO CAF: afconvert -f caff -d LEI16 myAudio1.wav myAudio1.caf

#include <iostream>
#import "SoundManager.h"

SoundManager* SoundManager::instance = NULL;

SoundManager::SoundManager(){
    
    //load all the sounds and put them in the proper arrays
    /*
    mainMenuMusic.loadSound("sound/fuelship-theme.wav");
    backgroundMusic.loadSound("sound/the-voyage.wav");
    
    targeted.loadSound("sound/target_sfx.caf");
    explosion.loadSound("sound/explosion_sfx.caf");
    missileSuccess.loadSound("sound/missile-success.wav");
    missileFailure.loadSound("sound/missile-failure.wav");
    resUp.loadSound("sound/res_up_sfx.wav");
    resDown.loadSound("sound/res_down_sfx.wav");
    gameOver.loadSound("sound/game_over_sfx.wav");
    click.loadSound("sound/blip.wav");
    spin.loadSound("sound/blaster-spin.wav");
    */
    sfx.push_back(targeted);
    sfx.push_back(explosion);
    sfx.push_back(missileSuccess);
    sfx.push_back(missileFailure);
    sfx.push_back(resUp);
    sfx.push_back(resDown);
    sfx.push_back(gameOver);
    sfx.push_back(click);
    sfx.push_back(spin);
    
    music.push_back(mainMenuMusic);
    music.push_back(backgroundMusic);
    
    float sfxVolume=0.5;
    for(int i=0; i<sfx.size(); i++){
        sfx.at(i).setVolume(sfxVolume);
    }
    
    float musicVolume=0.85;
    for(int i=0; i<music.size(); i++){
        music.at(i).setVolume(musicVolume);
        music.at(i).setLoop(true);
    }
    
    backgroundMusic.setVolume(1.0);

}

//stop all music currently playing
void SoundManager::stopAll(){
    for(int i=0; i<sfx.size(); i++){
        if(sfx.at(i).getIsPlaying())
            sfx.at(i).stop();
    } 
    
    for(int i=0; i<music.size(); i++){
        if(music.at(i).getIsPlaying())
            music.at(i).stop();
    }
}

SoundManager* SoundManager::getInstance(){
    if(!instance){
        instance = new SoundManager;
    }
    return instance;
}