//
//  HelpScreen.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the help screen
//

#import "SoundManager.h"
#import "button.h"


class HelpScreen {
	
public:
    HelpScreen();
    ~HelpScreen();
	void update();
	void draw();

	float appIphoneScale;
    
    SoundManager *soundManager;
    
    ofTrueTypeFont font;
    ofTrueTypeFont aboutFont;
    button btn_back;
    
    ofImage help1;
    ofImage help2;
    ofImage help3;
    ofImage help4;
    ofImage help5;
    ofImage help6;
    ofImage help7;
    
    int nextScreen;
    
    ofVec2f screenRes;
};


