//
//  button.h
//  RGBlaster
//
//  Created by Alex Miner on 11/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Button class used in GUI
//

#include "ofxMSAInteractiveObject.h"

class button : public ofxMSAInteractiveObject {
	
public:
	
	button();
	~button();
	void init( int _buttonId, bool _alive, string _buttonLabel, ofTrueTypeFont &font, float _offset );
	void setup();
	void update();
	void draw();
	void exit();
	void show();
	void hide();
	void onTouchDown( float x, float y );
	void onTouchMoved( float x, float y );
	void onTouchUp( float x, float y );
	void setLabel( string newLabel );
	
	ofTrueTypeFont	ArcadeClassic;				// the label font
	
	string			backgroundPath;			// the path of the background image
	string			buttonLabel;			// the label text

    float offset;
    
	int				buttonId;				// unique identifier (key)
	
	ofRectangle		labelBoundingBox;		// used to center the text
	
	bool			pressed;				// press sensor
	bool			alive;					// alive = white and clickable; dead = grey and not
	bool			breathing;				// current = white with black text
	bool			hideBtn;				// is the button hidden or not
	bool			touchedDown;			// diff than pressed because pressed is immediately reset
	
private:
	
};
