//
//  Structs.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles the basic structs used in the app

struct basicSprite {
	animation_t animation;	// a variable to store the animation this sprite uses
	ofPoint pos;			// the position on the screen this sprite will be drawn at
	float speed;			// the speed at which this sprite moves down the screen
    int tileSize;           // size of individual tiles in the sprite sheet
    int spriteSheetWidth;   // total width of the sprite sheet
};