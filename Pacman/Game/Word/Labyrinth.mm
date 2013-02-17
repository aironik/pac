//
//  Labyrinth.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "Labyrinth.h"


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

    std::for_each(walls.begin(), walls.end(), f);
    std::for_each(ghosts.begin(), ghosts.end(), f);
    std::for_each(food.begin(), food.end(), f);

    rolyPoly->draw();
}

void Labyrinth::handleCollisions() {
    handleCollisionsFood();     //< Мы съели нечто съедобное?
    handleCollisionsGhost();    //< Или нас слопали?
}

void Labyrinth::handleCollisionsFood() {
    // TODO: write me
}

void Labyrinth::handleCollisionsGhost() {
    // TODO: write me
}

void Labyrinth::handleSwitchSpeed() {
    // TODO: write me
    rolyPoly->setSpeed(nextSpeed);
}

Labyrinth::SharedPtr Labyrinth::createLabyrinth(int wordNumber) {
    // TODO: write me
    SharedPtr result = SharedPtr::make_shared();
    return result;
}

} // namespace Word
