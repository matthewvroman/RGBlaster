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
void Core::initCore(float _s){
    cout << "INIT CORE" << endl;
    spriteRenderer=AtlasHandler::getInstance()->coreRenderer;
    
    scale=_s;
}
