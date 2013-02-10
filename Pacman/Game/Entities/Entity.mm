//
//  Entity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Entity.h"

#include "Vector.h"


namespace Entities {

Entity::Entity() {
}

Entity::~Entity() {
}

void Entity::update(NSTimeInterval timeInterval) {
    position += speed * timeInterval;
    for (Model::iterator it = model.begin(); it != model.end(); ++it) {
        (*it)->update(timeInterval);
    };
}

void Entity::draw() const {
    NSCAssert(model.begin() == model.end(), @"No surfaces for draw!");
    for (Model::const_iterator it = model.begin(); it != model.end(); ++it) {
        (*it)->draw();
    };
}

bool Entity::isIntersect(const Entity &other) const {
    return dimensionsSize() + other.dimensionsSize() < position.distance(other.position);
}

} // namespace Entities
