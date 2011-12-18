//
//  ScreenManager.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Handles the switching of screen states
//

#ifndef RGBlaster_ScreenManager_h
#define RGBlaster_ScreenManager_h

#import "GameScreen.h"
#import "MenuScreen.h"
#import "HelpScreen.h"
#import "AboutScreen.h"
#import "SoundManager.h"

class ScreenManager{
public:
    ScreenManager();
    ~ScreenManager();
    
    int currentScreen;
    
    GameScreen *gameScreen;
    MenuScreen *menuScreen;
    HelpScreen *helpScreen;
    AboutScreen *aboutScreen;
    
    void switchScreens(int screen);
    
    void update();
    void draw();
    
private:
    
    
};


#endif
