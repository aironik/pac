//
//  FoodEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 18.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "FoodEntity.h"

#include "Romb.h"


namespace Entities {

FoodEntity::FoodEntity() {
    Surfaces::Romb::SharedPtr sphere = Surfaces::Romb::SharedPtr::make_shared();

    ProgramGl::Program::SharedPtr program = ProgramGl::Program::createDefaultProgram();
    program->setDiffuseColor(GLKVector4Make(0.6f, 0.4f, 0.8f, 1.0f));

    ModelList model;

    Models::Model::SharedPtr body = Models::Model::SharedPtr::make_shared(sphere, program);

    model.push_back(body);

    setModel(model);
}

FoodEntity::~FoodEntity() {
}

} // namespace Entities
