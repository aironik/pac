//
//  WallEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __Wall_H_
#define __Wall_H_

#include "Entity.h"


namespace Entities {

class WallEntity: public Entity {
public:
    typedef std::shared_ptr<WallEntity> SharedPtr;

public:
    WallEntity();
    virtual ~WallEntity();
};

} // namespace Entities

#endif //__Wall_H_
