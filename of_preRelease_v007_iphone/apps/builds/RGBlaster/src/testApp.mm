//
//  testApp.mm
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

#include "testApp.h"

//Create a screen manager instance to handle the different screen states
//--------------------------------------------------------------
void testApp::setup(){	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT);
	
	//ipad doesn't need no scale ;) 
	appIphoneScale = 1.0;

	ofBackground(0,0,0);
	
    ofSetVerticalSync(true);

	ofSetFrameRate(60);
    
    screenManager = new ScreenManager();

}


//--------------------------------------------------------------
void testApp::update(){
    screenManager->update();
    ofSoundUpdate();
}

//--------------------------------------------------------------
void testApp::draw(){
    screenManager->draw();
}
