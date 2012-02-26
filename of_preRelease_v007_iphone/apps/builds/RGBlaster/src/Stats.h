//
//  Stats.h
//  RGBlaster
//
//  Created by Matthew Vroman on 2/20/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#ifndef RGBlaster_Stats_h
#define RGBlaster_Stats_h

#import <GameKit/GameKit.h>
#import "GKAchievementHandler.h"

#include <string>
using namespace std;

struct stat{
    string sIdentifier;
    int currPoints;
    int pointsNeeded;
};

class Stats{
public:
    
    static Stats* instance;
    static Stats* getInstance();    
    
    ~Stats();
    
    int totalRedKilled;
    int totalGreenKilled;
    int totalBlueKilled;
    int totalKilled;
    
    int colorBlind;
    
    int totalPoints;
    int totalGamesPlayed;
    
    int totalTimePlayed;
    
    int totalPowerUpsUsed;
    
    int totalResolutionChanges;
    
    void setStat(NSString* _statName, int newValue);
    
    int getStat(NSString* _statName);
    
    void incrementStat(string _statName, int increment);
    
    
    //gamecenter
    bool isAvailable();
	void authenticateLocalPlayer();
    
	void reportScore(string _category, int _score);
	void reportAchievement(string _ach, float percent);
    
	bool isAuthenticated;
    void updateStats();
    
    void retrieveAchievementMetadata();
    NSMutableDictionary *achievementsDescDictionary;
    
    
private:
    Stats();
    void setDefault(NSString* _statName);
    void retrieveStats();
    
    
};

#endif
