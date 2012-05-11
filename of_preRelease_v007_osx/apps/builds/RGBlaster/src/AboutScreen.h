//
//  AboutScreen.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Creates the about screen
//

#import "SoundManager.h"
#import "button.h"


class AboutScreen {
	
public:
    AboutScreen();
    ~AboutScreen();
	void update();
	void draw();

	float appIphoneScale;
    
    SoundManager *soundManager;
        
    ofTrueTypeFont aboutFont;
    ofTrueTypeFont font;
    button btn_back;
    
    int nextScreen;
    
    ofVec2f screenRes;
};


