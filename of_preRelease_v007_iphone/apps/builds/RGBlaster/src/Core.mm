//
//  Core.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 2/1/12.
//  Copyright (c) 2012 RGBeast. All rights reserved.
//

#include <iostream>
#include "Core.h"

Core::~Core(){
    
}

//called from constructor
void Core::initCore(){
    cout << "INIT CORE" << endl;
    spriteRenderer=AtlasHandler::getInstance()->coreRenderer;
    
    sprite->animation=defaultAnimation;
    sprite->animation.index = 16*int(this->getRes())+int(this->getColor());
}
