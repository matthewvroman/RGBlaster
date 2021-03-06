//
//  Group.cpp
//  RGBlaster
//
//  Created by Matthew Vroman on 10/28/11.
//  Last Modified: 12/13/11
//
//  Copyright (c) 2011 RGBeast.
//  Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//  Description: Manages a group of ships that move down the screen

#include <iostream>
#include "Group.h"
#include <math.h>
#import "SpawnManager.h"


Group::Group(){
    
    enabled=true;
    
    dead=false;
    
    x=y=a=0;
    
    speed=privSpeed=2;
    
    stats=Stats::getInstance();

    
}

//Group spawned from SpawnManager with arguments based on difficulty
Group::Group(int _numShips, Color _color, Resolution _res, MovementType _movement, float _speed){
    enabled=true;
    
    dead=false;
    
    expanding=false;
    
    a=r=0;
    
    y=-ofRandom(400);
    
    x=ofRandom(600)+100;
    
    speed=privSpeed=_speed;
    
    numShips=_numShips;
    
    color=_color;
    resolution=_res;
    
    //determine which movement pattern to use
    switch (_movement) {
        case 0:
            movement = _movement;
            break;
        case 1:
            movement = (int)floor(ofRandom(.3,_movement+1));
            break;
        case 2:
            movement = (int)floor(ofRandom(.6,_movement+1));;
            break;
        default:
            break;
    }
    
    //assign the correct sprite renderer
    string spriteSheet;
    if(color==BLUE)
        renderer=AtlasHandler::getInstance()->blueShipRenderer;
    else if(color==RED)
        renderer=AtlasHandler::getInstance()->redShipRenderer;
    else
        renderer=AtlasHandler::getInstance()->greenShipRenderer;

    
	ofEnableAlphaBlending(); // turn on alpha blending. important!

    
    addShips(numShips);
    
    stats=Stats::getInstance();
    

}

void Group::resetSpeed(){
    speed=privSpeed;
}

//deconstructor
Group::~Group(){
    //disable update/draw
    enabled=false;
    
    /*
    //delete all ships
    while(objects.size()>0){
        delete objects[objects.size()-1];
        objects.pop_back();
    }*/
    
    //clear the vector for good measure
    objects.clear();
    
}

//distribute the 'a' value of BasicObject evenly across each ship
void Group::distributeAngles(){
    int i=0;
    int firstA=0;
    while(i<objects.size()){
        objects[i]->a=firstA;
        firstA+=360/objects.size();
        i++;
    }
}

//add a ship with a custom sprite sheet
void Group::addShip(int _x, int _y, int _height, int _width){
    Ship *ship;
    if(color==BLUE)
        ship = new Ship(_x,_y,_height,_width,"sprites/blue_enemy_spriteSheet.png");
    else if(color==RED)
        ship = new Ship(_x,_y,_height,_width,"sprites/red_enemy_spriteSheet.png");
    else
        ship = new Ship(_x,_y,_height,_width,"sprites/green_enemy_spriteSheet.png");
        
    ship->setColor(color);
    ship->setResolution(resolution);
    
    objects.push_back(ship);
    
}

//add a group of ships
void Group::addShips(int _numShips){
    for(int i=0; i<_numShips; i++){
        addShip(this->x,this->y,48,48);
    }
    distributeAngles();
    
}

//position the entire group at _x & _y
void Group::updatePos(float _x, float _y){
    for(int ctr=0; ctr<objects.size(); ctr++){
        /*we use move instead of updatePos because the position
        of objects are relative to the groups position*/
        if(_x>=x && _y>=y){                       
            objects.at(ctr)->move(_x, _y);     //quad 1
        }else if(_x<=x && _y>=y){
            objects.at(ctr)->move(-_x,_y);     //quad 2
        }else if(_x<=x && _y<=y){
            objects.at(ctr)->move(-_x,-_y);    //quad 3
        }else if(_x>=x && _y<=y){
            objects.at(ctr)->move(_x, -_y);    //quad 4
        }
    }
    
    x=_x;
    y=_y;
}

//move the entire group left/right _x pixels and up/down _y pixels
void Group::move(float _x, float _y){
    x+=_x;
    y+=_y;
    
    short i=0;
    while(i<objects.size()){
    //for(int i=0; i<objects.size(); i++){
        objects.at(i)->move(_x, _y);
        i++;
    }
}

//move the group in a circular motion
void Group::circleMove(float _speed,int _radius){
    //start unexpanded
    if(r<_radius){
        r+=_speed;
    }else{
        r=_radius;
    }
    short i=0;
    while(i<objects.size()){
        objects.at(i)->circleMove(this->x, this->y, _speed, r);
        i++;
    }
    y+=_speed;
}

//move the group in and out from a central point
void Group::expandMove(float _speed,int _maxRadius){
    
    if(expanding){
        r+=_speed/2;
        if(r>=_maxRadius)
            expanding=false;
        
    }
    if(!expanding){
        r-=_speed/2;
        if(r<=0)
            expanding=true;
    }
    short i=0;
    while(i<objects.size()){
        if(objects.at(i)!=nil)
            objects.at(i)->expandMove(this->x, this->y, _speed/2, this->r);
        i++;
    }
    y+=_speed;
}

//move the group in and out from a central point while rotating around that center
void Group::expandCircleMove(float _speed, int _maxRadius){
    if(expanding){
        r+=_speed/2;
        if(r>=_maxRadius)
            expanding=false;
        
    }
    if(!expanding){
        r-=_speed/2;
        if(r<=0)
            expanding=true;
    }
    short i=0;
    while(i<objects.size()){
        objects.at(i)->circleMove(this->x, this->y, _speed/2, this->r);
        i++;
    }
    y+=_speed;

}

//move the group in a zig zag pattern
void Group::zigZagMove(float _speed, int _maxRadius){
    if(expanding){
        r+=_speed;
        if(r>=_maxRadius)
            expanding=false;
        
    }
    if(!expanding){
        r-=_speed;
        if(r<=-_maxRadius)
            expanding=true;
    }
    
    short i=0;
    ofVec2f _prevShipPos;
    short _middle = int(objects.size()/2);
    while(i<objects.size()){
        //if we're the middle
        if(i==int(objects.size()/2)){
            _prevShipPos = ofVec2f(this->x,this->y);
        }else if(i>_middle){
            _prevShipPos = objects.at(i-1)->getPosition();
        }else if(i<_middle){
            _prevShipPos = objects.at(i+1)->getPosition();
        }
        objects.at(i)->zigZagMove(_prevShipPos.x, this->y, _speed, this->r);
        i++;
    }
    
    y+=_speed;
}

void Group::swirlMove(float _speed, int _spacing){
    short _middle = int(objects.size()/2);
    short i=0;
    float _shipSpeed=_speed;
    //cout << "MIDDLE IS: " << _middle << endl;
    while(i<objects.size()){
        if(i==_middle){
            r=0;
            //cout << i << "HIT MIDDLE" << endl;
            _shipSpeed=_speed;
        }else{
            r+=_spacing;
            //cout << i << endl;
        }
        if(i>_middle){
            //r+=_spacing;
            _shipSpeed=(i-_middle);
        }else if(i<_middle){
            //r-=_spacing;
            _shipSpeed=(_middle-i);
        }
        objects.at(i)->circleMove(this->x, this->y, _shipSpeed, r);
        i++;
    }
    y+=_speed;
}

void Group::lineMove(float _speed, int _spacing){
    
    int _spacer=_spacing;
    
    short i=0;
    while(i<objects.size()){
        if(!objects[i]->dead){
            objects.at(i)->setPosition(this->x, this->y-_spacing);
        }
        i++;
        _spacing+=_spacer;
    }
    
    y+=_speed;
}

//remove a ship from the vector
void Group::removeFromVector(int _pos){
    //cout << "remove from vector" << endl;
    if(_pos!=objects.size()-1){
        //Temporarily store our last element in the vector
        Ship *holder=objects[objects.size()-1];
    
        //move the ship we want to delete to the endof the position
        objects[objects.size()-1]=objects[_pos];
        
        //put the old last element in the TBDeleted spot
        objects[_pos]=holder;
    
    }
    
    //spawn explosion
    Explosion *explosion = new Explosion(objects[objects.size()-1]->getPosition().x,objects[objects.size()-1]->getPosition().y, this->color, this->resolution);
    explosions.push_back(explosion);
    
    //delete the ship
    delete objects[objects.size()-1];
    
    //resize the vector
    objects.pop_back();
    
    if(this->color == RED){
        stats->incrementStat("totalRedKilled", 1);
    }else if(this->color == GREEN){
        stats->incrementStat("totalGreenKilled", 1);
    }else if(this->color == BLUE){
        stats->incrementStat("totalBlueKilled", 1);
    }
    
}

//remove a ship from the vector
void Group::removeExplosion(int _pos){
    
    if(_pos!=objects.size()-1){
        //Temporarily store our last element in the vector
        Explosion *holder=explosions[explosions.size()-1];
        
        //move the ship we want to delete to the endof the position
        explosions[explosions.size()-1]=explosions[_pos];
        
        //put the old last element in the TBDeleted spot
        explosions[_pos]=holder;
        
    }

    //delete the explosion
    delete explosions[explosions.size()-1];
    
    //resize the vector
    explosions.pop_back();
    
    //check if our group should still exist
    if(explosions.size()==0 && objects.size()==0){
        dead=true;
        enabled=false;
    }
    
}

void Group::update(){
    if(!enabled)return;
    
    switch (movement) {
        case 0:
            //lineMove(speed,40);
            //zigZagMove(speed,50);
            //swirlMove(speed, 50);
            circleMove(speed, 50);
            break;
        case 1:
            expandMove(speed, 100);
            break;
        case 2:
            expandCircleMove(speed, 150);
            break;
        default:
            zigZagMove(speed,15);
            break;
    }
    
    short i=0;
    while(i < objects.size()){
        //draw objects
        if(objects[i]->sprite!=NULL && !objects[i]->dead){
            renderer->addCenteredTile(&objects[i]->sprite->animation,objects[i]->x,objects[i]->y);
        }
        //check pos
        if(objects[i]->getPosition().y>995){
            SpawnManager::getInstance()->notifyShipCrashed(10);
            objects[i]->dead=true;
            objects[i]->enabled=false;
        }

        //check if dead
        if(objects[i]->dead)
            removeFromVector(i);
        
        i++;
        
    }
    
    short ctr=0;
    while(ctr < explosions.size()){
        if(explosions[ctr]->dead){
            //remove explosion
            removeExplosion(ctr);
        }
        explosions[ctr]->update();
        ctr++;
    }
}

void Group::setResolution(Resolution _res){
    resolution = _res;
    short i=0;
    while(i<objects.size()){
        objects[i]->setResolution(resolution);
        i++;
    }
}

void Group::draw(){
    if(!enabled)return;
    renderer->draw();
    
    short ctr=0;
    while(ctr < explosions.size()){
        explosions[ctr]->draw();
        ctr++;
    }
    
}

float Group::deg2rad(float _deg){
    return _deg*(3.1415926/180);
}


