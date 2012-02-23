//
//  Stats.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 2/20/12.
//  Copyright (c) 2012 Bradley University. All rights reserved.
//

#include <iostream>
#include "Stats.h"

Stats* Stats::instance = NULL;

Stats* Stats::getInstance(){
    if(!instance)
        instance = new Stats;
    return instance;
}

Stats::Stats(){
    isAuthenticated=false;
	if (isAvailable()) {
		authenticateLocalPlayer();
	}
    authenticateLocalPlayer();
    retrieveStats();
}

/**************************
//GAMECENTER INTEGRATION//
*************************/

/*
 Created on 11/11/10 by
 Marc Sallent - http://wechoosefun.com/
 */
bool Stats::isAvailable(){
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    // The device must be running running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
}



void Stats::authenticateLocalPlayer(){
    if (isAvailable()) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            if (error == nil)
            {
                // Insert code here to handle a successful authentication.
                NSLog(@"succesfully authenticated");
                isAuthenticated=true;
            }
            else
            {
                // Your application can process the error parameter to report the error to the player.
                NSLog(@"failed to authenticate");
                isAuthenticated=false;
            }
        }];
    }
}

void Stats::reportScore(string _category, int _score){
        if (!isAuthenticated) {
            authenticateLocalPlayer();
        }
        cout << "Trying to report score to: " << _category << " with score: " << _score << endl;
		int64_t score = static_cast<int64_t>(_score);
		NSString * category = [NSString stringWithUTF8String: _category.c_str()];
		GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
		scoreReporter.value = score;
		[scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
			if (error != nil){
				// handle the reporting error
                NSLog(@"Error reporting score");
			}
		}];
}
void Stats::reportAchievement(string _ach, float percent){
        if (!isAuthenticated) {
            authenticateLocalPlayer();
        }
        
        //convert from 1.00 to 100%
        percent*=100;
        
		NSString * identifier = [NSString stringWithUTF8String: _ach.c_str()];
        GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
        if (achievement)
        {
            achievement.percentComplete = percent;
            [achievement reportAchievementWithCompletionHandler:^(NSError *error)
             {
                 if (error != nil){
                     NSLog(@"Error reporting achievement");
                 }
             }];
        }
}


void Stats::retrieveStats(){
    totalRedKilled = getStat(@"totalRedKilled");
    totalGreenKilled = getStat(@"totalRedKilled");
    totalBlueKilled = getStat(@"totalBlueKilled");
    
    totalKilled = totalRedKilled+totalBlueKilled+totalGreenKilled;
    
    totalPoints = getStat(@"totalPoints");
    totalGamesPlayed = getStat(@"totalGamesPlayed");
    
    totalTimePlayed = getStat(@"totalTimePlayed");
    
    totalPowerUpsUsed = getStat(@"totalPowerUpsUsed");
    
    totalResolutionChanges = getStat(@"totalResolutionChanges");
    
    colorBlind = getStat(@"colorBlind");
}

void Stats::setDefault(NSString* _statName){
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:_statName]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:_statName];
    }
}

void Stats::setStat(NSString* _statName, int newValue){
    //set stat
    [[NSUserDefaults standardUserDefaults] setInteger:newValue forKey:_statName];
    
}

void Stats::checkAchievementRequirements(NSString* _statName){
    //RED KILLS
    if([_statName isEqualToString:@"totalRedKilled"]){
        totalRedKilled=getStat(@"totalRedKilled");
        if(totalRedKilled<=100){
            reportAchievement("RedKills_01", float(totalRedKilled)/100.0f);     //RED ALERT
        }if(totalRedKilled<=500){
            reportAchievement("RedKills_02", float(totalRedKilled)/500.0f);     //RED RAMPAGE
        }if(totalRedKilled<=1000){
            reportAchievement("RedKills_03", float(totalRedKilled)/1000.0f);    //RED DEAD
        }
    }
    
    //GREEN KILLS
    if([_statName isEqualToString:@"totalGreenKilled"]){
        totalGreenKilled=getStat(@"totalGreenKilled");
        if(totalGreenKilled<=200){
            reportAchievement("GreenKills_01", float(totalGreenKilled)/200.0f);     //GOING GREEN 
        }if(totalGreenKilled<=750){
            reportAchievement("GreenKills_02", float(totalGreenKilled)/750.0f);     //GREEN GEEZER
        }if(totalGreenKilled<=1500){
            reportAchievement("GreenKills_03", float(totalGreenKilled)/1500.0f);    //SOYLENT GREEN
        }
    }
    
    //BLUE KILLS
    if([_statName isEqualToString:@"totalBlueKilled"]){
        totalBlueKilled=getStat(@"totalBlueKilled");
        if(totalBlueKilled<=300){
            reportAchievement("BlueKills_01", float(totalBlueKilled)/300.0f);     //BLUE'S CLUES
        }if(totalBlueKilled<=1000){
            reportAchievement("BlueKills_02", float(totalBlueKilled)/1000.0f);     //BLUE BLOODED
        }if(totalBlueKilled<=2000){
            reportAchievement("BlueKills_03", float(totalBlueKilled)/2000.0f);    //BLUE BOMBER
        }
    }
    
    if([_statName isEqualToString:@"totalRedKilled"] || [_statName isEqualToString:@"totalGreenKilled"] || [_statName isEqualToString:@"totalBlueKilled"]){
        totalKilled=totalGreenKilled+totalBlueKilled+totalRedKilled;
        if(totalKilled<1000){
            reportAchievement("AllKills_01", float(totalKilled)/1000.0f);       //MATERIAL DEFENDER
        }
        if(totalKilled<5000){
            reportAchievement("AllKills_02", float(totalKilled)/5000.0f);       //CAPTAIN CANNON
        }
        if(totalKilled<10000){
            reportAchievement("AllKills_03", float(totalKilled)/10000.0f);      //MASTER BLASTER
        }
        if(totalKilled<20000){
            reportAchievement("AllKills_04", float(totalKilled)/20000.0f);      //LAST OF MASTER
        }
    }
    
    if([_statName isEqualToString:@"colorBlind"]){
        colorBlind=getStat(@"colorBlind");
        if(colorBlind<=500){
            reportAchievement("ColorBlind01", float(colorBlind)/500.0f);       //COLOR BLIND
        }
    }

}

int Stats::getStat(NSString* _statName){
    //create the stat if it doesn't exist - default value is 0
    if([[NSUserDefaults standardUserDefaults] objectForKey:_statName]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:_statName];
    }
    
    NSLog(@"%@: %i",_statName, [[NSUserDefaults standardUserDefaults] integerForKey:_statName]);
    return [[NSUserDefaults standardUserDefaults] integerForKey:_statName];
}

void Stats::incrementStat(NSString* _statName, int increment){
    //if the stat doesn't exist set it to the increment
    if([[NSUserDefaults standardUserDefaults] objectForKey:_statName]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:increment forKey:_statName];
    }else{
        //add increment to previous stat
        [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:_statName]+increment forKey:_statName];
    }
    
    checkAchievementRequirements(_statName);
}

Stats::~Stats(){
    
}