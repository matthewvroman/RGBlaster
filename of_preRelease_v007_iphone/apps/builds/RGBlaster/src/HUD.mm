//
//  HUD.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/27/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles the in-game Heads-up Display

#include <iostream>
#import "HUD.h"
#import "SpawnManager.h"

HUD::HUD(){
    
    //old OF default is 96 - but this results in fonts looking larger than in other programs. 
	ofTrueTypeFont::setGlobalDpi(72);
    
    smallBlockFont.loadFont("fonts/visitor1.ttf", 18, true, true, false);
    
    blockFont.loadFont("fonts/ArcadeClassic.ttf", 36, true, true);
	blockFont.setLineHeight(18.0f);
	blockFont.setLetterSpacing(1.037);
    
    largeBlockFont.loadFont("fonts/ArcadeClassic.ttf",72,true,true);
    
    
    gameOver=false;
    rezUp=false;
    rezDown=false;
    
    setTime(0);
    setScore(0);
    setLives(1);
    setHealth(0,100);
    
    healthBarBackground.loadImage("sprites/health-bar-background.jpg");
    
}

HUD::~HUD(){
};

void HUD::update(){
    //fps is 60s, increment time by 1 every 60 frames
    if(!gameOver){
    
        timeCounter%=60;
        timeCounter++;
    
        if(timeCounter==60){
            incrementTime(1);
        }
    }
    
    
    //tween the health bar based on current health and current health bar width
    if(currentHealthBarWidth>tweenToHealthWidth && tweenToHealthWidth-3>=currentHealthBarWidth){
        currentHealthBarWidth-=3;
    }else{
        currentHealthBarWidth=tweenToHealthWidth;
    }
    
    if(currentHealthBarWidth<tweenToHealthWidth && tweenToHealthWidth+10<=currentHealthBarWidth){
        currentHealthBarWidth+=10;
    }else{
        currentHealthBarWidth=tweenToHealthWidth;
    }

}

//draw the HUD
void HUD::draw(){
    ofPushMatrix();
    
    //TOP HUD
    //r
    ofSetColor(255,0,0);
    blockFont.drawString("SCORE", 15, 30);
    
    //g
    ofSetColor(0,255,0);
    blockFont.drawString("TIME",325,30);
    
    //b
    ofSetColor(0,0,255);
    blockFont.drawString("HIGH SCORE",560,30);
    
    ofSetColor(255, 255, 255);
    blockFont.drawString(scoreString, 15, 56);
    blockFont.drawString(timeString, 325, 56);
    blockFont.drawString(highScoreString,560,56);
    
    //GAME OVER HUD
    if(gameOver){
        ofSetColor(255, 255,255);
        
        blockFont.drawString("GAME OVER",
                             centerFontPos(blockFont, "GAME OVER"),325);
        ofSetColor(255,0,0);
        blockFont.drawString("TOTAL SCORE " + scoreString,
                             centerFontPos(blockFont, "TOTAL SCORE " + scoreString),350);
        ofSetColor(0,255,0);
        blockFont.drawString("TOTAL TIME " + timeString,
                             centerFontPos(blockFont, "TOTAL TIME " + timeString),375);
        if(score==highScore){
            ofSetColor(0,0,255);
            blockFont.drawString("NEW HIGH SCORE!",
                            centerFontPos(blockFont, "NEW HIGH SCORE!"),400);
        }
    }
    
    //HEALTH BAR
    ofSetColor(255,255,255);
    healthBarBackground.draw(0,1024-healthBarBackground.height);
    
    ofFill();
    ofSetColor(255,255,255);
    ofRect(6, 1000, currentHealthBarWidth, 19);
    
    string resString="";
    switch (int(SpawnManager::getInstance()->resolution)){
        case 0:
            resString="8 BIT";
            break;
        case 1:
            resString="16 BIT";
            break;
        case 2:
            resString="32 BIT";
            break;
        default:
            resString="";
            break;
        
    }
    ofSetColor(0,0,0);
    smallBlockFont.drawString(resString + " RESOLUTION",306,1016);
    
    ofSetColor(255,255,0);
    smallBlockFont.drawString(resString + " RESOLUTION",305,1015);
    
    ofSetColor(255,255,255);
    
    ofPopMatrix();
}

//returns an X value that will position the string in the center of the screen
float HUD::centerFontPos(ofTrueTypeFont font,string _letters){
    return 384-font.stringWidth(_letters)/2;
}

//SETTERS
void HUD::setTime(int _time){
    time=_time;
    timeToString();
}

void HUD::setScore(int _score){
    score=_score;
    scoreToString();
    
    highScore=getHighScore();
    setHighScore(score);
}

void HUD::setLives(int _lives){
    lives=_lives;
    livesToString();
}

void HUD::setHealth(int _health, int _maxHealth){
    health=_health;
    maxHealth=_maxHealth;
    tweenToHealthWidth=(health/maxHealth)*maxHealthBarWidth;;
    currentHealthBarWidth=(health/maxHealth)*maxHealthBarWidth;
    maxHealthBarWidth=756;
}


void HUD::setHighScore(int _score){
    //set highscore to 0 if this is the first time
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"HighScore"];
    }
    
    if(_score>[[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"]){
        //set new highscore
        [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"HighScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        highScore=_score;
    }
    highScoreToString();
}

int HUD::getHighScore(){
    //set highscore to 0 if this is the first time
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"HighScore"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    
}

//GETTERS
int HUD::getTime(){
    return time;
}

int HUD::getScore(){
    return score;
}

int HUD::getLives(){
    return lives;
}


//INCREMENTERS
void HUD::incrementTime(int _increment){
    time+=_increment;
    timeToString();
    
}

void HUD::incrementScore(int _increment){
    score+=_increment;
    scoreToString();
}

void HUD::incrementLives(int _increment){
    lives+=_increment;
    livesToString();
}

void HUD::increaseHealth(float _healthGain){
    health+=_healthGain;
    tweenToHealthWidth=(health/maxHealth)*maxHealthBarWidth;
    if(health>=maxHealth){
        health=health-maxHealth;
        rezUp=true;
    }
}

//DECREMENTERS
void HUD::decrementLives(int _decrement){
    lives-=_decrement;
    livesToString();
}

void HUD::decreaseHealth(float _healthLoss){
    health-=_healthLoss;
    tweenToHealthWidth=(health/maxHealth)*maxHealthBarWidth;
    if(health<0){
        rezDown=true;
    }
}

//resets health to maximum
//used for derezzing
void HUD::resetHealth(){
    health=maxHealth;
    tweenToHealthWidth=(health/maxHealth)*maxHealthBarWidth;
    currentHealthBarWidth=tweenToHealthWidth;
}


//TO STRING METHODS
void HUD::timeToString(){
    timeString=ofToString(time);
    while(timeString.length()<4)
        timeString="0"+timeString;
}

void HUD::scoreToString(){
    scoreString=ofToString(score);
    while(scoreString.length()<5)
        scoreString="0"+scoreString;
}

void HUD::highScoreToString(){
    highScoreString=ofToString(highScore);
    while(highScoreString.length()<10)
        highScoreString="0"+highScoreString;
}

void HUD::livesToString(){
    livesString=ofToString(lives);
    while(livesString.length()<2)
        livesString="x0"+livesString;
}