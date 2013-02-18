//
//  Labyrinth.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "Labyrinth.h"

#include <cmath>

#include "FoodEntity.h"
#include "GhostEntity.h"
#include "WallEntity.h"


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

    updateConumingFood(timeInterval);

    rolyPoly->update(timeInterval);

    handleCollisions();
    handleSwitchSpeed();
    checkGameFinished();
}

void Labyrinth::updateConumingFood(NSTimeInterval timeInterval) {
    if (conumingFood) {
        Entities::Vector2D speed = (rolyPoly->getPosition() - conumingFood->getPosition());
        speed.normalize();
        speed *= (rolyPoly->getSpeed().length()) * 2.0f;
        conumingFood->setSpeed(speed.glkVector);

        conumingFood->update(timeInterval);
        if ((conumingFood->getPosition() - rolyPoly->getPosition()).length() < 0.1f) {
            conumingFood.reset();
            gameResultDelegate.lock()->gameScoreDidIncremened(1);
        }
    }
}

void Labyrinth::draw() const {
    DrawUnaryFunction f;
    std::for_each(walls.begin(), walls.end(), f);
    std::for_each(ghosts.begin(), ghosts.end(), f);
    std::for_each(food.begin(), food.end(), f);

    rolyPoly->draw();

    if (conumingFood) {
        conumingFood->draw();
    }
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
    handleCollisionsFood();         //< Мы съели нечто съедобное?
    handleCollisionsGhosts();       //< Или нас слопали?
}

void Labyrinth::handleCollisionsFood() {
    EntitiesList::const_iterator it = food.begin();
    for (; it != food.end(); ++it) {
        if (rolyPoly->isIntersect(*it)) {
            conumingFood = *it;
            food.erase(it);
            break;
        }
    }
}

void Labyrinth::handleCollisionsGhosts() {
    EntitiesList::const_iterator it = ghosts.begin();
    for (; it != ghosts.end(); ++it) {
        if (rolyPoly->isIntersect(*it)) {
            gameResultDelegate.lock()->gameLose();
        }
    }
}

void Labyrinth::checkGameFinished() {
    if (food.empty()) {
        gameResultDelegate.lock()->gameWin();
    }
}

void Labyrinth::handleSwitchSpeed() {
    handleSwitchSpeedRolyPoly();
    handleSwitchSpeedGhosts();
}

void Labyrinth::handleSwitchSpeedRolyPoly() {
    // TODO: write me
    bool speedChanging = (rolyPoly->getSpeed() == nextSpeed);
    if (checkEntityHangesWall(rolyPoly)) {
        if (speedChanging) {
            rolyPoly->setSpeed(nextSpeed);
        } else {
            rolyPoly->setSpeed(nextSpeed);
        }
        nextSpeed = GLKVector2Make(0.0f, 0.0f);
    }
    if (checkEntityOnCrossroads(rolyPoly)) {
        rolyPoly->setSpeed(nextSpeed);
    }
}

void Labyrinth::handleSwitchSpeedGhosts() {
    // TODO: write me
}

bool Labyrinth::checkEntityOnCrossroads(Entities::Entity::SharedPtr) {
    // TODO: write me
    return true;
}

bool Labyrinth::checkEntityHangesWall(Entities::Entity::SharedPtr entity) {
    EntitiesList::const_iterator it = walls.begin();
    for (; it != walls.end(); ++it) {
        Entities::Entity::SharedPtr wall = *it;
        if (entity->isIntersect(wall)) {
            Entities::Vector2D offset = (entity->getPosition() - wall->getPosition());
            float distance = entity->dimensionsSize() / 2.0f + wall->dimensionsSize() / 2.0f;
            offset *= offset.length() / distance;
            Entities::Vector2D expectedPosition = wall->getPosition() + offset;

            // округлим, причешем чтобы в нецелых поворотах отталкиваться от стенок
            Entities::Vector2D speed = entity->getSpeed();
            if (speed.length() < 0.01f) {
                // стоять-то мы можем тольько на целых значениях
                expectedPosition.x = std::round(expectedPosition.x);
                expectedPosition.y = std::round(expectedPosition.y);
            } else if (std::abs(speed.x) > std::abs(speed.y)) {
                // а ходим только по целым осям
                expectedPosition.x = std::round(expectedPosition.x);
            } else {
                expectedPosition.y = std::round(expectedPosition.y);
            }
            entity->moveTo(expectedPosition.glkVector);
            return true;
        }
    }
    return false;
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
    const char word[height][width] = {
        {2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
        {2, 4, 3, 3, 3, 3, 3, 3, 4, 2},
        {2, 3, 2, 2, 3, 2, 3, 2, 3, 2},
        {2, 3, 3, 3, 3, 1, 3, 3, 3, 2},
        {2, 3, 2, 2, 3, 2, 3, 2, 3, 2},
        {2, 4, 3, 3, 3, 3, 3, 3, 4, 2},
        {2, 2, 2, 2, 2, 2, 2, 2, 2, 2}
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
                }
                case 4: {
                    Entities::GhostEntity::SharedPtr ghost = Entities::GhostEntity::SharedPtr::make_shared();
                    ghost->moveTo(GLKVector2Make(xPos, yPos));
                    result->addGhost(ghost);
                    break;
                }
            }
        }
    }
    return result;
}

} // namespace Word
