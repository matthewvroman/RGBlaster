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
//using namespace std;

class Stats{
public:
    
    static Stats* instance;
    static Stats* getInstance();    
    
    ~Stats();
    
    int totalRedKilled;
    int totalGreenKilled;
    int totalBlueKilled;
    int totalKilled;
    
    int totalPoints;
    int highScore;
    
    int colorBlind;
    
    int totalGamesPlayed;
    
    int totalTimePlayed;
    
    int totalPowerUpsUsed;
    
    int totalResolutionChanges;
    
    void setStat(NSString* _statName, int newValue);
    
    int getStat(NSString* _statName);
    
    void incrementStat(std::string _statName, int increment);
    
    
    //gamecenter
    bool isAvailable();
	void authenticateLocalPlayer();
    
	void reportScore(std::string _category, int _score);
	void reportAchievement(std::string _ach, float percent);
    void reportScoreAchievement(int _score);
    
	bool isAuthenticated;
    void updateStats();
    
    void retrieveAchievements();
    
    void retrieveAchievementMetadata();
    NSMutableDictionary *achievementsDictionary;
    NSMutableDictionary *achievementsDescDictionary;
    
    
private:
    Stats();
    void setDefault(NSString* _statName);
    void retrieveStats();
    
    
};

#endif
