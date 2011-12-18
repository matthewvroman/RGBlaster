/***********************************************************************
 
 Copyright (c) 2008, 2009, Memo Akten, www.memo.tv
 *** The Mega Super Awesome Visuals Company ***
 * All rights reserved.
 *
 * ***********************************************************************/ 

// This is used to allow our button class to accept touches


#include "ofxMSAInteractiveObject.h"
#include "ofMain.h"

ofxMSAInteractiveObject::ofxMSAInteractiveObject() {
	enabled			= true;
	verbose			= false;
	
	currentlyTouched= false;
	
	enableAppEvents();
	disableTouchEvents();
}

ofxMSAInteractiveObject::~ofxMSAInteractiveObject() {
	disableAllEvents();
}

void ofxMSAInteractiveObject::killMe() {
	delete this;
}

void ofxMSAInteractiveObject::enableAllEvents() {
	enableAppEvents();
	enableTouchEvents();
}

void ofxMSAInteractiveObject::disableAllEvents() {
	disableAppEvents();
	disableTouchEvents();
}

void ofxMSAInteractiveObject::enableTouchEvents() {
	ofAddListener(ofEvents.touchDown, this, &ofxMSAInteractiveObject::_touchisDown);
	ofAddListener(ofEvents.touchUp, this, &ofxMSAInteractiveObject::_touchisUp);
	ofAddListener(ofEvents.touchMoved, this, &ofxMSAInteractiveObject::_touchisMoved);
	
}

void ofxMSAInteractiveObject::disableTouchEvents() {
	ofRemoveListener(ofEvents.touchDown, this, &ofxMSAInteractiveObject::_touchisDown);
	ofRemoveListener(ofEvents.touchUp, this, &ofxMSAInteractiveObject::_touchisUp);
	ofRemoveListener(ofEvents.touchMoved, this, &ofxMSAInteractiveObject::_touchisMoved);
}

void ofxMSAInteractiveObject::enableAppEvents() {
	ofAddListener(ofEvents.setup, this, &ofxMSAInteractiveObject::_setup);
	ofAddListener(ofEvents.update, this, &ofxMSAInteractiveObject::_update);
	ofAddListener(ofEvents.draw, this, &ofxMSAInteractiveObject::_draw);
	ofAddListener(ofEvents.exit, this, &ofxMSAInteractiveObject::_exit);
}

void ofxMSAInteractiveObject::disableAppEvents() {
	ofRemoveListener(ofEvents.setup, this, &ofxMSAInteractiveObject::_setup);
	ofRemoveListener(ofEvents.update, this, &ofxMSAInteractiveObject::_update);
	ofRemoveListener(ofEvents.draw, this, &ofxMSAInteractiveObject::_draw);
	ofRemoveListener(ofEvents.exit, this, &ofxMSAInteractiveObject::_exit);
}

void ofxMSAInteractiveObject::setPos(float _x, float _y) {
	x = _x;
	y = _y;
}

void ofxMSAInteractiveObject::setSize(float _w, float _h) {
	width = _w;
	height = _h;
}

void ofxMSAInteractiveObject::setPosAndSize(float _x, float _y, float _w, float _h) {
	setPos(_x, _y);
	setSize(_w, _h);
}

bool ofxMSAInteractiveObject::hitTest(int tx, int ty) {
	return ((tx > x) && (tx < x + width) && (ty > y) && (ty < y + height));
}

void ofxMSAInteractiveObject::_setup(ofEventArgs &e) {
	if(!enabled) return;
	setup();
}

void ofxMSAInteractiveObject::_update(ofEventArgs &e) {
	if(!enabled) return;
	
	// check to see if object has moved, and if so update mouse events
	update();
}

void ofxMSAInteractiveObject::_draw(ofEventArgs &e) {
	if(!enabled) return;
	draw();
}

void ofxMSAInteractiveObject::_exit(ofEventArgs &e) {
	if(!enabled) return;
	exit();
}

void ofxMSAInteractiveObject::_touchisDown(ofTouchEventArgs &e) {
	float x = e.x;
	float y = e.y;
	mTouchX = x;
	mTouchY = y;
	
	if(hitTest(x, y)) {						// if mouse is over
		onTouchDown(x, y);
		currentlyTouched = true;
	} else {								// if mouse is not over
		// do nothing
	}
}

void ofxMSAInteractiveObject::_touchisUp(ofTouchEventArgs &e) {
	float x = e.x;
	float y = e.y;
	
	if(hitTest(x, y)) {
		onTouchUp(x, y);
		currentlyTouched = false;
	} else if(hitTest(mTouchX, mTouchY)) {
		// this uses original X and original Y onTouchDown
		// incase the finger slides off before releasing the button
		onTouchUp(x, y);
		currentlyTouched = false;
	}
}

void ofxMSAInteractiveObject::_touchisMoved(ofTouchEventArgs &e) {
	float x = e.x;
	float y = e.y;
	
	if ( currentlyTouched ) {
		onTouchMoved( x, y );
	}
}