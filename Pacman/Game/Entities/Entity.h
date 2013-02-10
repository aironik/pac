//
//  Entity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Entity_H_
#define __Entity_H_

#include <memory>
#include "Surface.h"
#include "Vector.h"


namespace Entities {

class Entity {
public:
    Entity();
    virtual ~Entity();

    void moveTo(const GLKVector2 &newPosition) { position = newPosition; }
    void setSpeed(const GLKVector2 &newSpeed) { speed = newSpeed; }
    virtual void update(NSTimeInterval timeInterval);

    virtual float dimensionsSize() const { return 1.0f; }
    bool isIntersect(const Entity &other) const;

    virtual void draw() const;

protected:
    typedef std::vector<Surfaces::Surface::SharedPtr> Model;

protected:
    const Model &getModel() const { return model; }

private:
    Model model;

    Vector position;
    Vector direction;
    Vector speed;
};

} // namespace Entities

#endif //__Entity_H_
