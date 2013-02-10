//
//  RolyPolyEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "RolyPolyEntity.h"

#include "RolyPolyModel.h"


namespace Entities {

RolyPolyEntity::RolyPolyEntity() {
    setModel(Models::RolyPolyModel::SharedPtr::make_shared());
}

RolyPolyEntity::~RolyPolyEntity() {

}

} // namespace Entities
