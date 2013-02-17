//
//  WallEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "WallEntity.h"

#include "Cube.h"


namespace Entities {

WallEntity::WallEntity() {
    Surfaces::Cube::SharedPtr cube = Surfaces::Cube::SharedPtr::make_shared();

    ProgramGl::Program::SharedPtr program = ProgramGl::Program::createDefaultProgram();
    program->setDiffuseColor(GLKVector4Make(0.4f, 1.0f, 0.4f, 1.0f));

    ModelList model;
    model.push_back(Models::Model::SharedPtr::make_shared(cube, program));
    setModel(model);
}

WallEntity::~WallEntity() {
}

} // namespace Entities
