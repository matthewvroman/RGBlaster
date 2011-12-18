//
//  Notifier.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 12/12/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Draws a large string 'notification' that floats to the top of the screen

#include <iostream>
#import "Notifier.h"

Notifier::Notifier(){
    blockFont.loadFont("fonts/ArcadeClassic.ttf",100,true,true);
}

Notifier::~Notifier(){
    
}

//Create a new notification and add it to the vector
void Notifier::displayNotification(string _message){
    Notification newMessage;
    newMessage.message=_message;
    newMessage.x=384-blockFont.stringWidth(_message)/2;
    newMessage.y=1024;
    
    notifications.push_back(newMessage);
}

//Float the current notifications upwards
void Notifier::update(){
    
    short i=0;
    while(i<notifications.size()){
        notifications.at(i).y-=5;
        
        if(notifications.at(i).y<-200){
            removeNotification(i);
        }
        
        i++;
    }
    
}

//Remove a notification from the vector
void Notifier::removeNotification(int _pos){

    if(_pos!=notifications.size()-1){
        //Temporarily store our last element in the vector
        Notification holder=notifications[notifications.size()-1];
        
        //move the element we want to delete to the endof the position
        notifications[notifications.size()-1]=notifications[_pos];
        
        //put the old last element in the TBDeleted spot
        notifications[_pos]=holder;
    }
    
    //resize the vector
    notifications.pop_back();
    
}

//Draw notification strings
void Notifier::draw(){
        
    short i=0;
    while(i<notifications.size()){
        
        //black shadow
        ofSetColor(0,0,0);
        blockFont.drawString(notifications.at(i).message,notifications.at(i).x-2,notifications.at(i).y+2);
        
        //white text
        ofSetColor(255, 255, 255);
        blockFont.drawString(notifications.at(i).message,notifications.at(i).x,notifications.at(i).y);
        
        i++;
    }
}