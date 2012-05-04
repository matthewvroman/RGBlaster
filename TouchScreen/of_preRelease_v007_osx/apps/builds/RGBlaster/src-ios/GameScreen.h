//
//  GameScreen.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the game screen
//

#import "World.h"
#import "SoundManager.h"

class GameScreen {
	
public:
	GameScreen();
    ~GameScreen();
	void update();
	void draw();

	float appIphoneScale;
    
    SoundManager *soundManager;
    
    World *world;
    
    button      btn_replay;
    button      btn_mainMenu;
    
    ofTrueTypeFont      font;
    
    int nextScreen;

};


