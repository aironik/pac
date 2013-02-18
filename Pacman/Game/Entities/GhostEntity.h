//
//  GhostEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 18.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __GhostEntity_H_
#define __GhostEntity_H_

#include "Entity.h"


namespace Entities {

class GhostEntity : public Entity {
public:
    typedef std::shared_ptr<GhostEntity> SharedPtr;

public:
    GhostEntity();
    virtual ~GhostEntity();
};

} // namespace Entities

#endif //__GhostEntity_H_
