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
}

bool Entity::isIntersect(const Entity &other) {
    return dimensionsSize() + other.dimensionsSize() < position.distance(other.position);
}

} // namespace Entities
