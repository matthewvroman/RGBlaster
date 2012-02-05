//
//  ScreenManager.mm
//  RGBlaster
//
//  Created by Alex Miner on 12/02/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  DESCRIPTION:
//  Handles the switching of screen states
//

#include <iostream>
#include "ScreenManager.h"


ScreenManager::ScreenManager(){	
    
    // Initialize screen manager
    currentScreen = 0;
    switchScreens(currentScreen);
    
    mainBackground.loadImage("sprites/background-low.png");
    
}

ScreenManager::~ScreenManager(){
    cout << "removing screen manager" << endl;
}

void ScreenManager::update(){
    
    // Determines if a switch screen is needed
    switch (currentScreen) {
        case 0: // MENU
            menuScreen->update();
            if(currentScreen != menuScreen->nextScreen)
                switchScreens(menuScreen->nextScreen);
            break;
        case 1: // GAME
            gameScreen->update();
            if(currentScreen != gameScreen->nextScreen)
                switchScreens(gameScreen->nextScreen);
            break;
        case 2: // HELP
            helpScreen->update();
            if(currentScreen != helpScreen->nextScreen)
                switchScreens(helpScreen->nextScreen);
            break;
        case 3: // ABOUT
            aboutScreen->update();
            if(currentScreen != aboutScreen->nextScreen)
                switchScreens(aboutScreen->nextScreen);
            break;
        default:
            break;
    }
}

//--------------------------------------------------------------
void ScreenManager::draw(){
    
    ofSetColor( 255, 255, 255 );
    
    // Determine which screen object to draw
    switch (currentScreen) {
        case 0: // MENU
            mainBackground.draw(0,0);
            menuScreen->draw();
            break;
        case 1: // GAME
            gameScreen->draw();
            break;
        case 2: // HELP
            mainBackground.draw(0,0);
            helpScreen->draw();
            break;
        case 3: // ABOUT
            mainBackground.draw(0,0);
            aboutScreen->draw();
            break;
        default:
            break;
    }
}

//--------------------------------------------------------------
void ScreenManager::switchScreens(int screen){
    
    // Kill current screen
    if(screen != currentScreen){
        switch (currentScreen) {
            case 0:
                delete menuScreen;
                break;
            case 1:
                delete gameScreen;
                break;
            case 2:
                delete helpScreen;
                break;
            case 3:
                delete aboutScreen;
                break;
            default:
                break;
        }
    }
    
    // Create new screen
    switch (screen) {
        case 0:
            menuScreen = new MenuScreen();
            break;
        case 1:
            gameScreen = new GameScreen();
            break;
        case 2:
            helpScreen = new HelpScreen();
            break;
        case 3:
            aboutScreen = new AboutScreen();
            break;
        default:
            break;
    }
    
    // Assign current screen
    currentScreen = screen;
}