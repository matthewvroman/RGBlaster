//
//  Blaster.mm
//  RGBlaster
//
//  Created by Matthew Vroman on 11/3/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Blaster object that sits at the bottom of the screen
//               Allows for targeting & missile firing

#import "Blaster.h"
#import "SoundManager.h"

Blaster::Blaster(){
    
    enabled=true;
    
    lastTouch=nil;
    
    //how many pixels the user must swipe for the blaster to rotate
    leeway=75;
    
    ofAddListener(ofEvents.mousePressed, this, &Blaster::_mousePressed);
	ofAddListener(ofEvents.mouseReleased, this, &Blaster::_mouseReleased);
    
    /*SPRITE DRAWING*/
    //int _numLayers, int _tilesPerLayer, int _defaultLayer, int _tileSize
    setSpriteTexture("sprites/blaster_sprite.png", 512, 74);
    sprite->animation = defaultAnimation;
    
    colorWheelRenderer = new ofxSpriteSheetRenderer(1,100,0,74);
    colorWheelRenderer->loadTexture("sprites/colorWheel_sprite.png", 512, GL_NEAREST);
    
    colorWheelSprite = new basicSprite(); // create a new sprite
    colorWheelSprite->pos.set(0,0); //set its position
    colorWheelSprite->speed=1; //set its speed
    colorWheelSprite->animation = defaultAnimation; //set its animation to the walk animation we declared
    colorWheelSprite->animation.frame_duration = 5; //adjust its frame duration based on how fast it is walking (faster = smaller)
    colorWheelSprite->animation.index = 0; //change the start index of our sprite. we have 4 rows of animations and our spritesheet is 8 tiles wide, so our possible start indicies are 0, 8, 16, and 24
    
	ofEnableAlphaBlending(); // turn on alpha blending. important!
    
    //default color/res at the start of the game
    color = RED;
    resolution=BIT8;
    
    updateSpriteSheet();
    
    type = BLASTER;
    
    spawner = nil;
    
    finger = new Finger();
    
    tilesPerRow=6;
    
    width=height=74;
    
    setPosition(386, 995);
    
    r=currentR=0;
    
    rotationSpeed=10;
    maxRotation=0.85;
    
    missileSpawnPos=currentMissileSpawnPos=ofVec2f(386,930);
    
    switchingColor=false;
    
    maxMissilesOnScreen=75;
    
    missiles.reserve(maxMissilesOnScreen);
}

Blaster::~Blaster(){
    ofRemoveListener(ofEvents.mousePressed, this, &Blaster::_mousePressed);
	ofRemoveListener(ofEvents.mouseReleased, this, &Blaster::_mouseReleased);
    delete finger; 
    delete colorWheelRenderer;
    delete colorWheelSprite;
}

void Blaster::_mousePressed(ofMouseEventArgs &touch) {
    if(touch.y>this->y-this->height){
        lastTouch.x=touch.x;
        lastTouch.y=touch.y;
    }else{
        lastTouch=nil;
    }
    
}

//Swap colors if the swipe moved far enough from touchDown to touchUp
void Blaster::_mouseReleased(ofMouseEventArgs &touch) {
    if(lastTouch!=nil){
        //left
        if(touch.x<lastTouch.x-leeway){
            color=Color(int(color)+1);
            if(int(color)>2)
                color=Color(0);
            r=-90;
            currentR=0;
            switchingColor=true;
            SoundManager::getInstance()->spin.play();
        }
        if(touch.x>lastTouch.x+leeway){
            color=Color(int(color)-1);
            if(int(color)<0)
                color=Color(2);
            r=90;
            currentR=0;
            switchingColor=true;
            SoundManager::getInstance()->spin.play();
        }
    }
    
}

void Blaster::setSpawner(SpawnManager *_spawner){
    spawner = _spawner;
}

void Blaster::switchColor(){
    updateSpriteSheet();
    finger->setColor(color);
}

//check finger collisions & spawn a missile if there'sa hit
void Blaster::update(){
    if(!enabled) return;
    
    finger->update();
    
    //determine rotation based on where the user is touching
    if(finger->down && finger->y < 930 && !switchingColor){
        float _percent = (finger->x-x)/(finger->y-y);
        if(_percent>maxRotation){
            _percent=maxRotation;
        }else if(_percent<-maxRotation){
            _percent=-maxRotation;
        }
        r=-asin(_percent) * 180.0 / 3.141592;
        if(r!=r){ //if NaN
            r=0;
        }
        
        currentMissileSpawnPos.x=missileSpawnPos.x+r;
        
    }else if(!finger->down && !switchingColor){
        r=0;
    }
    
    if(currentR>r+rotationSpeed){
        currentR-=rotationSpeed;
    }else if(currentR<r-rotationSpeed){
        currentR+=rotationSpeed;
    }else{
        currentR=r;
        if(switchingColor){
            currentR=0;
            switchingColor=false;
            switchColor();
        }
    }
    
    if(finger->down && spawner != nil && missiles.size()<maxMissilesOnScreen){
        for(short i=0; i<spawner->activeGroups.size(); i++){
            for(short j=0; j<spawner->activeGroups.at(i)->objects.size(); j++){
                if(finger->hitTest(spawner->activeGroups.at(i)->objects.at(j))){
                    //Missile *missile = new Missile(currentMissileSpawnPos.x,currentMissileSpawnPos.y,color,resolution,spawner->activeGroups.at(i)->objects.at(j));
                    spawner->activeGroups.at(i)->objects.at(j)->targeted=true;
                    missiles.push_back(new Missile(currentMissileSpawnPos.x,currentMissileSpawnPos.y,color,resolution,spawner->activeGroups.at(i)->objects.at(j)));
                    sprite->animation = blasterAnimation;
                    sprite->animation.index = tilesPerRow*int(resolution);
                }
            }
        }/*
         for(short i=0; i<spawner->activeMulticoreShips.size(); i++){
             for(short j=0; j<spawner->activeMulticoreShips[i]->cores.size(); j++){
                 if(finger->hitTest(spawner->activeMulticoreShips[i]->cores[j])){
                     Missile *missile = new Missile(currentMissileSpawnPos.x,currentMissileSpawnPos.y,color,resolution,spawner->activeMulticoreShips[i]->cores[j]);
                     missiles.push_back(missile);
                     
                     sprite->animation = blasterAnimation;
                     sprite->animation.index = tilesPerRow*int(resolution);
                 }
             }
         }*/
        
    }
    
    for(int k=0; k<missiles.size(); k++){
        missiles.at(k)->update();
        if(missiles.at(k)==NULL || missiles.at(k)->dead){
            removeMissile(k);
        }
    }
    
    if(lastGameOverCheck==false && spawner->gameOver==true){
        Explosion *explosion = new Explosion(this->x, this->y-45, this->color, this->resolution,14,true);
        Explosion *explosion2 = new Explosion(this->x-40, this->y-25, this->color, this->resolution,10,true);
        Explosion *explosion3 = new Explosion(this->x+40, this->y-25, this->color, this->resolution,10,true);
        explosions.push_back(explosion);
        explosions.push_back(explosion2);
        explosions.push_back(explosion3);
    }
    
    lastGameOverCheck=spawner->gameOver;
    
    for(short i=0; i<explosions.size(); i++){
        explosions.at(i)->update();
        if(explosions[i]->dead){
            //remove explosion
            removeExplosion(i);
        }
    }
    if(sprite!=NULL){
        if(sprite->animation.frame==2 || sprite->animation.frame==10 || sprite->animation.frame==18){
            sprite->animation = defaultAnimation;
            sprite->animation.index = tilesPerRow*int(resolution);
        }
    }
    
    spriteRenderer->clear(); // clear the sheet
	spriteRenderer->update(ofGetElapsedTimeMillis()); //update the time in the renderer, this is necessary for animations to advance
    
    if(sprite!=NULL && !dead){
        spriteRenderer->addCenteredTile(&sprite->animation,0,0);
    }
    
    colorWheelRenderer->clear();
    colorWheelRenderer->update(ofGetElapsedTimeMillis());
    if(colorWheelSprite!=NULL && !dead){
        //colorWheelRenderer->addCenteredTile(&colorWheelSprite->animation, 0, 0);
        colorWheelRenderer->addCenterRotatedTile(&colorWheelSprite->animation,0,0, -1, 1, F_NONE, 1.0, 0, saturation,saturation,saturation,255); 
    }

    
    //BasicObject::update();
}

//remove a ship from the vector
void Blaster::removeExplosion(int _pos){
    
    Explosion *holder;
    if(_pos!=explosions.size()-1){
        //Temporarily store our last element in the vector
        holder=explosions[explosions.size()-1];
        
        //move the ship we want to delete to the endof the position
        explosions[explosions.size()-1]=explosions[_pos];
        
        //put the old last element in the TBDeleted spot
        explosions[_pos]=holder;
    }
    
    
    //delete the explosion
    delete explosions[explosions.size()-1];
    
    //resize the vector
    explosions.pop_back();
    
}

void Blaster::removeMissile(int _pos){
    
    Missile *holder;
    if(_pos!=missiles.size()-1){
        //Temporarily store our last element in the holder
        holder=missiles[missiles.size()-1];
       
        //move the element we want to delete to the endof the position
        missiles[missiles.size()-1]=missiles[_pos];
        
        //put the old last element in the TBDeleted spot
        missiles[_pos]=holder;
    }
    
    delete missiles[missiles.size()-1];
    
    //resize the vector
    missiles.pop_back();
    
}

void Blaster::draw(){
    if(!enabled) return;
    
    for(short i=0; i<explosions.size(); i++){
       explosions.at(i)->draw();
    }
    
    if(spawner->gameOver) return;
    
    finger->draw();
    
    for(short i=0; i<missiles.size(); i++){
        if(missiles.at(i)!=NULL)
            missiles.at(i)->draw();
    }
    
    ofPushMatrix();
    ofTranslate(x, y);
    ofScale(2,2);
    ofRotateZ(currentR);
    colorWheelRenderer->draw();
    spriteRenderer->draw();
    ofPopMatrix();

}

void Blaster::setResolution(Resolution _res){
    resolution=_res;
    updateSpriteSheet();
}

//update sprite sheet to accurately reflect color & res
void Blaster::updateSpriteSheet(){
    colorWheelSprite->animation.index = tilesPerRow*int(resolution)+int(color);
    sprite->animation.index = tilesPerRow*int(resolution);
}