#include "testApp.h"

#include "testApp.h"
#include "AtlasHandler.h"
//Create a screen manager instance to handle the different screen states
//--------------------------------------------------------------
void testApp::setup(){	
	//ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT);
	
	//ipad doesn't need no scale ;) 
	//appIphoneScale = 1;
    
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
    ofPushMatrix();
    //ofScale(appIphoneScale, appIphoneScale);
    screenManager->draw();
    ofPopMatrix();
}

//--------------------------------------------------------------
void testApp::keyPressed(int key){

}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void testApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void testApp::dragEvent(ofDragInfo dragInfo){ 

}