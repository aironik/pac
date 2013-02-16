//
//  Entity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Entity.h"

#include "Vector2D.h"


namespace Entities {

Entity::Entity() {
}

Entity::~Entity() {
}

void Entity::moveTo(const GLKVector2 &newPosition) {
    position = newPosition;
}

void Entity::setSpeed(const GLKVector2 &newSpeed) {
    speed = newSpeed;
}

void Entity::update(NSTimeInterval timeInterval) {
    position += speed * timeInterval;

    for (ModelList::const_iterator it = model.begin(); it != model.end(); ++it) {
        Models::Model::SharedPtr m = *it;
        m->setCenterOffset(position.upSize(-4.0f));
        m->update(timeInterval);
    }
}

void Entity::draw() const {
    for (ModelList::const_iterator it = model.begin(); it != model.end(); ++it) {
        (*it)->draw();
    }
}

bool Entity::isIntersect(const Entity &other) const {
    return dimensionsSize() + other.dimensionsSize() < position.distance(other.position);
}

} // namespace Entities
