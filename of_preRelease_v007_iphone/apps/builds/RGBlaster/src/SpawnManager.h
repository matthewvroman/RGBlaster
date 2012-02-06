//
//  SpawnManager.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/10/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Handles the spawning and message passing of groups and enemies
//

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "Group.h"
#import "Ship.h"
#import "MulticoreShip.h"
#import "HUD.h"
#import "SoundManager.h"
#import "Notifier.h"
#import "Finger.h"

class SpawnManager{

public:
    
    int difficulty;
    int nextDifficultyIncrease;
    
    int spawnDecrementer;
    int currentFrame;
    int spawnInterval;
    
    int maxColor;
    int maxResolution;
    int maxShips;
    float maxShipSpeed;
    int maxMultiplier;
    int maxMovementLevel;
    int coresPerShip;
    int colorsPerMulticoreShip;
    bool coresShouldFlash;
    float coreFlashSpeed;
    
    int numWaves;
    
    bool gameOver;
    
    Resolution resolution;
    
    void setResolution(Resolution);
    
    void setHUD(HUD *_hud);
    
    void setFinger(Finger *_finger);
    
    void setInitialValues();
    
    //Missile.mm needs to find us
    static SpawnManager* getInstance();
    static SpawnManager* instance;
    
    void notifyShipDestroyed();
    void notifyShipCrashed(int _dmg);
    void notifyGameOver();
    
    vector<Group*>activeGroups;
    vector<MulticoreShip*>activeMulticoreShips;
    
    void update();
    void draw();
    
    void removeGroup(int _pos);
    void removeMulticoreShip(int _pos);
    
    void removeAllGroups();
    void removeAllMulticoreShips();
    
    void spawnEnemy();
    
    void spawnMulticoreShip();
    void spawnGroup();
    
    void increaseDifficulty();
    
    void incrementColorStreak(int);
    void decrementColorStreak(int);
    void resetColorStreak();
    
    void generatePowerUp();
    void removePowerUp();
    void applyPowerUp();
    
    void setNotifier(Notifier *_notifier);
    
private:
    //singleton has a private constructor called by getInstance()
    SpawnManager();
    HUD *hud;
    Notifier *notifier;
    Finger *finger;
    
    bool enabled;
    
    int colorStreak;
    
    float chanceToSpawnMulticore;
    
    string powerUpName;
    int powerUp;
    int powerUpLength;
    int powerUpTimer;
    int powerUpEndTime;
    
};
