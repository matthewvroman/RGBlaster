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
    
    authenticateLocalPlayer();
    
    retrieveStats();
}

Stats::~Stats(){
    
    delete instance;
}

/**************************
//GAMECENTER INTEGRATION//
*************************/

/*
 Created on 11/11/10 by
 Marc Sallent - http://wechoosefun.com/
 */
bool Stats::isAvailable(){
        return false;
}



void Stats::authenticateLocalPlayer(){
    /*if (isAvailable()) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            if (error == nil)
            {
                // Insert code here to handle a successful authentication.
                //NSLog(@"succesfully authenticated");
                isAuthenticated=true;
                retrieveAchievements();
                retrieveAchievementMetadata();
            }
            else
            {
                // Your application can process the error parameter to report the error to the player.
                //NSLog(@"failed to authenticate");
                isAuthenticated=false;
            }
        }];
    }*/
}

//static GKAchievement *gkA;
//static GKAchievementDescription* a;

void Stats::retrieveAchievements(){
   /* achievementsDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [GKAchievement loadAchievementsWithCompletionHandler:
     ^(NSArray *achievements, NSError *error) {
         if(error!=nil){
             NSLog(@"Error %@", error);
         }else{
             if (achievements!=nil) {
                 for(gkA in achievements){
                     [achievementsDictionary setObject:gkA forKey:gkA.identifier];
                     //NSLog(@"%@: %f : %i", gkA.identifier, gkA.percentComplete, gkA.completed);
                 }
             }
         }
     }];*/
}

void Stats::retrieveAchievementMetadata(){
   /* achievementsDescDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [GKAchievementDescription loadAchievementDescriptionsWithCompletionHandler:
     ^(NSArray *descriptions, NSError *error) {
         if (error != nil) {
             NSLog(@"Error %@", error);
             
         } else {        
             if (descriptions != nil){
                 for (a in descriptions) {
                     [achievementsDescDictionary setObject: a forKey: a.identifier];
                     //NSLog(@"Identity: %@",a.identifier);
                 }
             }
         }
     }];*/
}

void Stats::reportScore(std::string _category, int _score){
   /* if (!isAuthenticated) {
        authenticateLocalPlayer();
    }
    
    //std::cout << "Trying to report score to: " << _category << " with score: " << _score << std::endl;
		int64_t score = static_cast<int64_t>(_score);
		NSString * category = [NSString stringWithUTF8String: _category.c_str()];
		GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
		scoreReporter.value = score;
        
        //NSLog(@"Reporting score of %lld to %@",score,category);
		[scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
			if (error != nil){
				// handle the reporting error
                NSLog(@"Error reporting score");
			}
		}];*/
}

void Stats::reportAchievement(std::string _ach, float percent){
  /*  if (!isAuthenticated) {
        authenticateLocalPlayer();
    }
        
    if(isAuthenticated){
        //convert from 1.00 to 100%
        percent*=100;
        
		NSString * identifier = [NSString stringWithUTF8String: _ach.c_str()];
        
        GKAchievement *achievement = [achievementsDictionary objectForKey:identifier];
        if(achievement==nil){
            //NSLog(@"achievement is nil.. create new one");
            achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
        }
        achievement.showsCompletionBanner = NO;
    
        //NSLog(@"%@: %i",identifier,achievement.isCompleted);
        if (achievement && !achievement.isCompleted)
        {
            //NSLog(@"reporting achievement: %@", identifier);
            if(percent>100){
                percent=100;
            }
            achievement.percentComplete = percent;
            if(achievement.percentComplete==100){
                //Show banners manually
                GKAchievementDescription *desc = [achievementsDescDictionary objectForKey:identifier]; //Update pull achievement description for dictionary
                [[GKAchievementHandler defaultHandler] notifyAchievement:desc];  //Display to user
            }
            [achievement reportAchievementWithCompletionHandler:^(NSError *error)
             {
                 if (error != nil){
                     NSLog(@"Error reporting achievement");
                 }
             }];
        }
    }else{
        //NSLog(@"can't report achievement: we aren't logged into gamecenter");
    }*/
}

void Stats::reportScoreAchievement(int _score){/*
    //NSLog(@"reporting score achievements with score of: %i", _score);
    reportAchievement("Score_01", float(_score)/5000.0f); 
    reportAchievement("Score_02", float(_score)/10000.0f); 
    reportAchievement("Score_03", float(_score)/25000.0f); 
    reportAchievement("Score_04", float(_score)/50000.0f); */
}


void Stats::retrieveStats(){
    /*
    totalRedKilled = getStat(@"totalRedKilled");
    totalGreenKilled = getStat(@"totalRedKilled");
    totalBlueKilled = getStat(@"totalBlueKilled");
    
    totalKilled = totalRedKilled+totalBlueKilled+totalGreenKilled;
    
    totalPoints = getStat(@"totalPoints");
    totalGamesPlayed = getStat(@"totalGamesPlayed");
    
    totalTimePlayed = getStat(@"totalTimePlayed");
    
    totalPowerUpsUsed = getStat(@"totalPowerUpsUsed");
    
    totalResolutionChanges = getStat(@"totalResolutionChanges");
    
    colorBlind = getStat(@"colorBlind");*/
}

//brings the userdefault stats up to speed
void Stats::updateStats(){
    /*
    //std::cout << "UPDATING ALL STATS!" << std::endl;
    setStat(@"totalRedKilled", totalRedKilled);
    setStat(@"totalGreenKilled", totalGreenKilled);
    setStat(@"totalBlueKilled", totalBlueKilled);
    
    setStat(@"colorBlind", colorBlind);

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //achievement ref name
    //achievemtn currNum
    //achievement maxNum
    //achievement complete
    
    reportAchievement("RedKills_01", float(totalRedKilled)/100.0f);     //RED ALERT

    reportAchievement("RedKills_02", float(totalRedKilled)/500.0f);     //RED RAMPAGE

    reportAchievement("RedKills_03", float(totalRedKilled)/1000.0f);    //RED DEAD
    

    reportAchievement("GreenKills_01", float(totalGreenKilled)/200.0f);     //GOING GREEN 

    reportAchievement("GreenKills_02", float(totalGreenKilled)/750.0f);     //GREEN GEEZER

    reportAchievement("GreenKills_03", float(totalGreenKilled)/1500.0f);    //SOYLENT GREEN



    reportAchievement("BlueKills_01", float(totalBlueKilled)/300.0f);     //BLUE'S CLUES

    reportAchievement("BlueKills_02", float(totalBlueKilled)/1000.0f);     //BLUE BLOODED

    reportAchievement("BlueKills_03", float(totalBlueKilled)/2000.0f);    //BLUE BOMBER

    

    reportAchievement("AllKill_01", float(totalKilled)/1000.0f);       //MATERIAL DEFENDER

    reportAchievement("AllKill_02", float(totalKilled)/5000.0f);       //CAPTAIN CANNON

    reportAchievement("AllKill_03", float(totalKilled)/10000.0f);      //MASTER BLASTER

    reportAchievement("AllKill_04", float(totalKilled)/20000.0f);      //LAST OF MASTER
    

    reportAchievement("ColorBlind01", float(colorBlind)/500.0f);       //COLOR BLIND
     */

}

void Stats::setDefault(NSString* _statName){
    /*
    if([[NSUserDefaults standardUserDefaults] objectForKey:_statName]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:_statName];
    }*/
}

void Stats::setStat(NSString* _statName, int newValue){
    //set stat
    //[[NSUserDefaults standardUserDefaults] setInteger:newValue forKey:_statName];
    
    
}

int Stats::getStat(NSString* _statName){
    /*
    //create the stat if it doesn't exist - default value is 0
    if([[NSUserDefaults standardUserDefaults] objectForKey:_statName]==nil){
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:_statName];
    }
    
    //NSLog(@"%@: %i",_statName, [[NSUserDefaults standardUserDefaults] integerForKey:_statName]);
    return [[NSUserDefaults standardUserDefaults] integerForKey:_statName];
     */
}

void Stats::incrementStat(std::string _statName, int increment){
/*
    //RED KILLS
    if(_statName=="totalRedKilled"){
        totalRedKilled+=increment;
        if(totalRedKilled==100){
            reportAchievement("RedKills_01", float(totalRedKilled)/100.0f);     //RED ALERT
        }if(totalRedKilled==500){
            reportAchievement("RedKills_02", float(totalRedKilled)/500.0f);     //RED RAMPAGE
        }if(totalRedKilled==1000){
            reportAchievement("RedKills_03", float(totalRedKilled)/1000.0f);    //RED DEAD
        }
    }
    
    //GREEN KILLS
    else if(_statName=="totalGreenKilled"){
        totalGreenKilled+=increment;
        if(totalGreenKilled==200){
            reportAchievement("GreenKills_01", float(totalGreenKilled)/200.0f);     //GOING GREEN 
        }if(totalGreenKilled==750){
            reportAchievement("GreenKills_02", float(totalGreenKilled)/750.0f);     //GREEN GEEZER
        }if(totalGreenKilled==1500){
            reportAchievement("GreenKills_03", float(totalGreenKilled)/1500.0f);    //SOYLENT GREEN
        }
    }
    
    //BLUE KILLS
    else if(_statName=="totalBlueKilled"){
        totalBlueKilled+=increment;
        if(totalBlueKilled==300){
            reportAchievement("BlueKills_01", float(totalBlueKilled)/300.0f);     //BLUE'S CLUES
        }if(totalBlueKilled==1000){
            reportAchievement("BlueKills_02", float(totalBlueKilled)/1000.0f);     //BLUE BLOODED
        }if(totalBlueKilled==2000){
            reportAchievement("BlueKills_03", float(totalBlueKilled)/2000.0f);    //BLUE BOMBER
        }
    }
    
    if(_statName=="totalRedKilled" || _statName=="totalGreenKilled" || _statName=="totalBlueKilled"){
        totalKilled=totalGreenKilled+totalBlueKilled+totalRedKilled;
        if(totalKilled==1000){
            reportAchievement("AllKill_01", float(totalKilled)/1000.0f);       //MATERIAL DEFENDER
        }
        if(totalKilled==5000){
            reportAchievement("AllKill_02", float(totalKilled)/5000.0f);       //CAPTAIN CANNON
        }
        if(totalKilled==10000){
            reportAchievement("AllKill_03", float(totalKilled)/10000.0f);      //MASTER BLASTER
        }
        if(totalKilled==20000){
            reportAchievement("AllKill_04", float(totalKilled)/20000.0f);      //LAST OF MASTER
        }
    }
    
    if(_statName=="colorBlind"){
        colorBlind+=increment;
        if(colorBlind==500){
            reportAchievement("ColorBlind01", float(colorBlind)/500.0f);       //COLOR BLIND
        }
    }
*/

}