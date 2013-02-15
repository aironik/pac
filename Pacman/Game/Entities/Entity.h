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

#include "Model.h"
#include "Program.h"
#include "Surface.h"
#include "Vector2D.h"


namespace Entities {

class Entity {
public:
    Entity();
    virtual ~Entity();

    virtual void moveTo(const GLKVector2 &newPosition);
    virtual void setSpeed(const GLKVector2 &newSpeed);
    virtual void update(NSTimeInterval timeInterval);

    virtual float dimensionsSize() const { return 1.0f; }
    bool isIntersect(const Entity &other) const;

    void draw() const;

protected:
    typedef std::vector<Models::Model::SharedPtr> ModelList;

protected:
    const ModelList &getModel() const { return model; }
    void setModel(const ModelList &newModel) { this->model = newModel; }
    const Vector2D &getPosition() const { return position; }

private:
    ModelList model;

    Vector2D position;
    Vector2D direction;
    Vector2D speed;
};

} // namespace Entities

#endif //__Entity_H_
