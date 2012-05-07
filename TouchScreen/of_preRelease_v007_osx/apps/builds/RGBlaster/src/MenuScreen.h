//
//  MenuScreen.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the menu screen
//

#import "SoundManager.h"
#import "button.h"
#import "ofxInitialsBox.h"

class MenuScreen {
	
public:
    MenuScreen();
    ~MenuScreen();
	void update();
	void draw();

	float appIphoneScale;
    
    SoundManager *soundManager;
    
    ofImage logo;
    
    ofTrueTypeFont font;
    ofTrueTypeFont visitorFont;
    button *btn_start;
    button *btn_about;
    button *btn_help;
    
    int nextScreen;
    
    ofVec2f screenRes;
    
    ofxInitialsBox *test;
};


