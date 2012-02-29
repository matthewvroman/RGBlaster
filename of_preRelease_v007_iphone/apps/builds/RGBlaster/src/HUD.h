//
//  HUD.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/27/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles the in-game Heads-up Display

#ifndef RGBlaster_HUD_h
#define RGBlaster_HUD_h

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#import "Stats.h"

class HUD{
public:
    
    //constructor
    HUD();
    
    //deconstructor
    ~HUD();
    
    //OF Methods
    void update();
    void draw();
    
    //setters
    void setScore(int);
    void setTime(int);
    void setLives(int);
    void setHealth(int,int);
    void setHighScore(int);
    void resetHealth();
    void setPowerUpCountString(int);
    void setMultiplier(int);
    void resetMultiplier();
    
    //getters
    int getScore();
    int getTime();
    int getLives();
    int getHighScore();
    int getMultiplier();
    
    //incrementers
    void incrementTime(int);
    void incrementScore(int);
    void incrementLives(int);
    void increaseHealth(float);
    void incrementMultiplier(int);
    
    //decrementers
    void decrementLives(int);
    void increaseLife(int);
    void decreaseLife(int);
    void decreaseHealth(float);
    
    bool gameOver;
    bool rezUp;
    bool rezDown;
    
    
private:
    
    //external fonts
    ofTrueTypeFont smallBlockFont;
    ofTrueTypeFont blockFont;
    ofTrueTypeFont largeBlockFont;
    ofTrueTypeFont notificationBlockFont;
    
    ofImage healthBarBackground;
    
    //private vars
    int score;
    int highScore;
    int time;
    int lives;
    int timeCounter;
    
    int scoreMultiplier;
    
    float health;
    float maxHealth;
    
    float tweenToHealthWidth;
    float currentHealthBarWidth;
    float maxHealthBarWidth;
    
    float centerFontPos(ofTrueTypeFont&,string);
    
    string scoreString;
    string highScoreString;
    string timeString;
    string livesString;
    string powerUpCountString;
    string multiplierString;
    
    //private methods
    void timeToString();
    void scoreToString();
    void livesToString();
    void highScoreToString();
    void multiplierToString();
    
    int saturation;
    bool saturationUp;
};


#endif
