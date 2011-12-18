//
//  testApp.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Main App that handles the initial update & draws
//

#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ScreenManager.h"

class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();

	float appIphoneScale;
    
    ScreenManager *screenManager;
};


