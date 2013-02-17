//
//  GhostEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 18.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "GhostEntity.h"

#import "Sphere.h"


namespace Entities {

GhostEntity::GhostEntity() {
    Surfaces::Sphere::SharedPtr sphere = Surfaces::Sphere::SharedPtr::make_shared();

    ProgramGl::Program::SharedPtr program = ProgramGl::Program::createDefaultProgram();
    program->setDiffuseColor(GLKVector4Make(0.1f, 1.0f, 0.1f, 1.0f));

    ModelList model;
    model.push_back(Models::Model::SharedPtr::make_shared(sphere, program));
    setModel(model);
}

GhostEntity::~GhostEntity() {
}

} // namespace Entities
