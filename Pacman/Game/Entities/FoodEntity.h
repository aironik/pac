//
//  FoodEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 18.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __FoodEntity_H_
#define __FoodEntity_H_

#include "Entity.h"


namespace Entities {

class FoodEntity : public Entity {
public:
    typedef std::shared_ptr<FoodEntity> SharedPtr;

public:
    FoodEntity();
    virtual ~FoodEntity();
};

} // namespace Entities

#endif //__FoodEntity_H_
