//
//  RolyPolyEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __RolyPolyEntity_H_
#define __RolyPolyEntity_H_

#include "Entity.h"


namespace Entities {

class RolyPolyEntity : public Entity {
public:
    typedef std::shared_ptr<RolyPolyEntity> SharedPtr;

public:
    RolyPolyEntity();
    virtual ~RolyPolyEntity();
};

} // namespace Entities

#endif //__RolyPolyEntity_H_
