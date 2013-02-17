//
//  Labyrinth.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __Labyrinth_H_
#define __Labyrinth_H_

#include <memory>

#import "Entity.h"
#import "GameResultDelegate.h"
#import "RolyPolyEntity.h"


namespace Word {

class Labyrinth {
public:
    typedef std::shared_ptr<Labyrinth> SharedPtr;
public:
    virtual ~Labyrinth();

    static SharedPtr createLabyrinth(int wordNumber);

    void setGameResultDelegate(GameResultDelegate::SharedPtr aGameResultDelegate);

    virtual void update(NSTimeInterval timeInterval);
    void draw() const;

    void handleUserInput(const GLKVector2 &direction);

private:
    typedef std::vector<Entities::Entity::SharedPtr> EntitiesList;

private:
    Labyrinth();

    void setRolyPoly(const Entities::RolyPolyEntity::SharedPtr rolyPoly);
    void addWall(const Entities::Entity::SharedPtr wall);
    void addWalls(const EntitiesList &walls);
    void addGhost(const Entities::Entity::SharedPtr ghost);
    void addGhosts(const EntitiesList &ghosts);
    void addFood(const Entities::Entity::SharedPtr food);
    void addFood(const EntitiesList &food);

    void handleCollisions();
    void handleCollisionsFood();
    void handleCollisionsGhosts();
    void handleSwitchSpeed();
    void handleSwitchSpeedRolyPoly();
    void handleSwitchSpeedGhosts();

private:
    EntitiesList walls;
    EntitiesList ghosts;
    EntitiesList food;
    Entities::RolyPolyEntity::SharedPtr rolyPoly;
    GameResultDelegate::WeakPtr gameResultDelegate;

    GLKVector2 nextSpeed;
};

} // namespace Word

#endif //__Labyrinth_H_
