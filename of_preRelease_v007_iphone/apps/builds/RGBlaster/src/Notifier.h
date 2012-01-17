//
//  Notifier.h
//  RGBlaster
//
//  Created by Matthew Vroman on 12/12/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Draws a large string 'notification' that floats to the top of the screen

#ifndef RGBlaster_Notifier_h
#define RGBlaster_Notifier_h

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

struct Notification{
    string message;
    float x;
    float y;
};

class Notifier{
public:
    //constructor
    Notifier();
    
    //destructor
    ~Notifier();
    
    //OF cascading methods
    void update();
    void draw();
    
    //adds a new notification to the vector
    void displayNotification(string);
    
    
private:
    
    vector<Notification>notifications;
    
    ofTrueTypeFont  blockFont;
    ofTrueTypeFont  smallBockFont;
    
    void removeNotification(int);
};

#endif
