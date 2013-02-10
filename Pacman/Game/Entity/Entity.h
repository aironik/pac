//
//  Entity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Entity_H_
#define __Entity_H_

#import <memory>
#import "Surface.h"
#import "Vector.h"


namespace Entities {

class Entity {
public:
    Entity();
    virtual ~Entity();

    void moveTo(const GLKVector2 &newPosition) { position = newPosition; }
    void setSpeed(const GLKVector2 &newSpeed) { speed = newSpeed; }
    virtual void update(NSTimeInterval timeInterval);

    virtual float dimensionsSize() const { return 1.0f; }
    bool isIntersect(const Entity &other);

protected:

protected:
    const Surfaces::Surface::SharedPtr &getModel() const { return model; }

private:
    Surfaces::Surface::SharedPtr model;

    Vector position;
    Vector direction;
    Vector speed;
};

} // namespace Entities

#endif //__Entity_H_
