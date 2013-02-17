//
//  Food.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 18.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __Food_H_
#define __Food_H_

#include "Entity.h"


namespace Entities {

class Food : public Entity {
public:
    typedef std::shared_ptr<Food> SharedPtr;

public:
    Food();
    virtual ~Food();
};

} // namespace Entities

#endif //__Food_H_
