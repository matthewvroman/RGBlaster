/***********************************************************************

 Copyright (c) 2008, 2009, Memo Akten, www.memo.tv
 *** The Mega Super Awesome Visuals Company ***
 * All rights reserved.
 *
 * ***********************************************************************/

// This is used to allow our button class to accept touches

#pragma once

#include "ofMain.h"

class ofxMSAInteractiveObject : public ofRectangle {
public:
	bool		enabled;				// set this to false to temporarily disable all events
	bool		verbose;
	
	// these are so the touchUp hitTest is measured from initial touch, not where finger currently is.
	// if it was the latter, dragging the finger outside the button and releasing does not fire the hitTest
	int			mTouchX;				
	int			mTouchY;

	ofxMSAInteractiveObject();			// constructor
	virtual ~ofxMSAInteractiveObject();	// destructor

	void enableAllEvents();				// enable all event callbacks
	void disableAllEvents();			// disable all event callbacks

	void enableTouchEvents();
	void disableTouchEvents();

	void enableAppEvents();				// call this if object should update/draw automatically	(default)
	void disableAppEvents();			// call this if object doesn't need to update/draw automatically

	void setPos(float _x, float _y);	// set position of object
	void setSize(float _w, float _h);	// set size of object
	void setPosAndSize(float _x, float _y, float _w, float _h);		// set pos and size

	bool isTouchDown();

	bool hitTest(int tx, int ty);		// returns true if given (x, y) coordinates (in screen space) are over the object (based on position and size)

	void killMe();						// if your object is a pointer, and you are done with it, call this

	// extend ofxMSAInteractiveObject and override all of any of the following methods
	virtual void setup()	{}	// called when app starts
	virtual void update()	{}	// called every frame to update object
    virtual void draw()		{}	// called every frame to draw object
	virtual void exit()		{}	// called when app quites
	
	virtual void onTouchDown(float x, float y)														{}
	virtual void onTouchUp(float x, float y)														{}
	virtual void onTouchMoved(float x, float y)														{}

	// you shouldn't need access to any of these unless you know what you are doing
	// (i.e. disable auto updates and call these manually)
	void _setup(ofEventArgs &e);
	void _update(ofEventArgs &e);
    void _draw(ofEventArgs &e);
	void _exit(ofEventArgs &e);
	
	void _touchisDown(ofTouchEventArgs &e);
	void _touchisUp(ofTouchEventArgs &e);
	void _touchisMoved(ofTouchEventArgs &e);
	
	
	bool currentlyTouched;

protected:
	ofRectangle	oldRect;
	
private:
	
};

