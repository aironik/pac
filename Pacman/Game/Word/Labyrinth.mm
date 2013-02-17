//
//  Labyrinth.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "Labyrinth.h"
#import "WallEntity.h"
#import "FoodEntity.h"


namespace {

struct UpdateUnaryFunction {
    UpdateUnaryFunction(NSTimeInterval aTimeInterval) : timeInterval(aTimeInterval) {}
    void operator()(Entities::Entity::SharedPtr obj) { obj->update(timeInterval); }

    NSTimeInterval timeInterval;
};

struct DrawUnaryFunction {
    void operator()(Entities::Entity::SharedPtr obj) { obj->draw(); }
};

} // namespace ::

namespace Word {

Labyrinth::Labyrinth()
        : nextSpeed(GLKVector2Make(0.0f, 0.0f))
{
}

Labyrinth::~Labyrinth() {
}

void Labyrinth::setGameResultDelegate(GameResultDelegate::SharedPtr aGameResultDelegate) {
    this->gameResultDelegate = aGameResultDelegate;
}

void Labyrinth::handleUserInput(const GLKVector2 &direction) {
    nextSpeed = direction;
}

void Labyrinth::update(NSTimeInterval timeInterval) {
    UpdateUnaryFunction f(timeInterval);
    std::for_each(walls.begin(), walls.end(), f);
    std::for_each(ghosts.begin(), ghosts.end(), f);
    std::for_each(food.begin(), food.end(), f);

    rolyPoly->update(timeInterval);

    handleCollisions();

    handleSwitchSpeed();
}

void Labyrinth::draw() const {
    DrawUnaryFunction f;

    rolyPoly->draw();

    std::for_each(walls.begin(), walls.end(), f);
    std::for_each(ghosts.begin(), ghosts.end(), f);
    std::for_each(food.begin(), food.end(), f);

}

void Labyrinth::setRolyPoly(const Entities::RolyPolyEntity::SharedPtr aRolyPoly) {
    rolyPoly = aRolyPoly;
}

void Labyrinth::addWall(const Entities::Entity::SharedPtr wall) {
    walls.push_back(wall);
}

void Labyrinth::addWalls(const EntitiesList &aWalls) {
    walls.insert(walls.end(), aWalls.begin(), aWalls.end());
}

void Labyrinth::addGhost(const Entities::Entity::SharedPtr ghost) {
    ghosts.push_back(ghost);
    handleSwitchSpeedGhosts();
}

void Labyrinth::addGhosts(const EntitiesList &aGhosts) {
    ghosts.insert(ghosts.end(), aGhosts.begin(), aGhosts.end());
    handleSwitchSpeedGhosts();
}

void Labyrinth::addFood(const Entities::Entity::SharedPtr aFood) {
    food.push_back(aFood);
}

void Labyrinth::addFood(const EntitiesList &aFood) {
    food.insert(food.end(), aFood.begin(), aFood.end());
}


void Labyrinth::handleCollisions() {
    handleCollisionsFood();     //< Мы съели нечто съедобное?
    handleCollisionsGhosts();    //< Или нас слопали?
}

void Labyrinth::handleCollisionsFood() {
    // TODO: write me
}

void Labyrinth::handleCollisionsGhosts() {
    // TODO: write me
}

void Labyrinth::handleSwitchSpeed() {
    // TODO: write me
    rolyPoly->setSpeed(nextSpeed);
}

void Labyrinth::handleSwitchSpeedRolyPoly() {

}

void Labyrinth::handleSwitchSpeedGhosts() {

}

Labyrinth::SharedPtr Labyrinth::createLabyrinth(int wordNumber) {
    // TODO: write me
    SharedPtr result = SharedPtr(new Labyrinth());
    // 0 - пусто
    // 1 - колобок
    // 2 - стена
    // 3 - еда
    // 4 - сторож
    const int width = 10;
    const int height = 7;
//    const char word[height][width] = {
//        {2, 0, 0, 0, 0, 0, 0, 0, 0, 2},
//        {2, 3, 3, 3, 3, 3, 3, 3, 0, 2},
//        {2, 0, 0, 0, 0, 0, 0, 0, 0, 2},
//        {2, 0, 0, 0, 0, 1, 0, 0, 0, 2},
//        {2, 0, 0, 0, 0, 0, 0, 0, 0, 2},
//        {2, 0, 3, 3, 3, 3, 3, 3, 3, 2},
//        {2, 0, 0, 0, 0, 0, 0, 0, 0, 2}
//    };
    const char word[height][width] = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 3, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    };
    for (int x = 0; x < width; ++x) {
        for (int y = 0; y < height; ++y) {
            const int xPos = x - width / 2;
            const int yPos = height / 2 - y;
            switch (word[y][x]) {
                case 0:
                    break;
                case 1: {
                    Entities::RolyPolyEntity::SharedPtr rolyPoly = Entities::RolyPolyEntity::SharedPtr::make_shared();
                    rolyPoly->moveTo(GLKVector2Make(xPos, yPos));
                    result->setRolyPoly(rolyPoly);
                    break;
                }
                case 2: {
                    Entities::WallEntity::SharedPtr wall = Entities::WallEntity::SharedPtr::make_shared();
                    wall->moveTo(GLKVector2Make(xPos, yPos));
                    result->addWall(wall);
                    break;
                }
                case 3: {
                    Entities::FoodEntity::SharedPtr food = Entities::FoodEntity::SharedPtr::make_shared();
                    food->moveTo(GLKVector2Make(xPos, yPos));
                    result->addFood(food);
                    break;
                    break;
                }
                case 4:
                    break;
            }
        }
    }
    return result;
}

} // namespace Word
