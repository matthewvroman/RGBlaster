//
//  Animations.h
//  RGBlaster
//
//  Created by Matthew Vroman on 11/15/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Handles animation variables for the different sprites

//create a new animation. This could be done optinally in your code andnot as a static, just by saying animation_t walkAnimation; defaultAnimation.index =0, defaultAnimation.frame=0 etc. I find this method the easiest though
static animation_t defaultAnimation = 
{	0,	/* .index			(int) - this is the index of the first animation frame. indicies start at 0 and go left to right, top to bottom by tileWidth on the spriteSheet		*/
	0,	/* .frame			(int) - this is the current frame. It's an internal variable and should always be set to 0 at init													*/
	1,	/* .totalframes		(int) - the animation length in frames																												*/			
	1,	/* .width			(int) - the width of each animation frame in tiles																									*/	
	1,	/* .height			(int) - the height of each animation frame in tiles																									*/	
	75,	/* .frameduration	(unsigned int) - how many milliseconds each frame should be on screen. Less = faster																*/	
	0,	/* .nexttick		(unsigned int) - the next time the frame should change. based on frame duration. This is an internal variable and should always be set to 0 at init	*/
	-1,	/* .loops			(int) - the number of loops to run. -1 equals infinite. This can be adjusted at runtime to pause animations, etc.									*/
	-1,	/* .finalindex		(int) - the index of the final tile to draw when the animation finishes. -1 is the default so total_frames-1 will be the last frame.				*/
	1	/* .frameskip		(int) - the incrementation of each frame. 1 should be set by default. If you wanted the animation to play backwards you could set this to -1, etc.	*/
};

static animation_t bit8Animation = {
    0,
    0,
    2,
    1,
    1,
    1000,
    0,
    -1,
    -1,
    1
};

static animation_t bit16Animation = {
    0,
    0,
    4,
    1,
    1,
    750,
    0,
    -1,
    -1,
    1
};

static animation_t bit32Animation = {
    0,
    0,
    8,
    1,
    1,
    250,
    0,
    -1,
    -1,
    1
};

static animation_t explodeAnimation = {
    0,
    0,
    8,
    1,
    1,
    75,
    0,
    -1,
    -1,
    1
};

static animation_t blasterAnimation = {
    0,
    0,
    3,
    1,
    1,
    75,
    0,
    -1,
    -1,
    1
};

static animation_t multicoreShipAnimation = {
    0,
    0,
    6,
    1,
    1,
    150,
    0,
    -1,
    -1,
    1
};
