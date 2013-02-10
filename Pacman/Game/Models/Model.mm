//
//  Model.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Model.h"

namespace Models {

Model::Model() {}
Model::~Model() {}

void Model::update(NSTimeInterval timeInterval) {
    for (SurfacesList::iterator it = surfaces.begin(); it != surfaces.end(); ++it) {
        (*it)->update(timeInterval);
    }
}

void Model::draw() const {
    NSCAssert(surfaces.begin() == surfaces.end(), @"Can't draw: no surfaces!");
    for (SurfacesList::const_iterator it = surfaces.begin(); it != surfaces.end(); ++it) {
        (*it)->draw();
    }
}

} // namespace Models
