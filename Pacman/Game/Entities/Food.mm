//
//  Food.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 18.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "Food.h"

#import "Sphere.h"


namespace Entities {

Food::Food() {
    Surfaces::Sphere::SharedPtr sphere = Surfaces::Sphere::SharedPtr::make_shared();

    ProgramGl::Program::SharedPtr program = ProgramGl::Program::createDefaultProgram();
    program->setDiffuseColor(GLKVector4Make(0.4f, 0.4f, 0.4f, 0.1f));

    ModelList model;

    Models::Model::SharedPtr body = Models::Model::SharedPtr::make_shared(sphere, program);
    body->setSizeScale(GLKVector3Make(0.2f, 0.2f, 0.2f));

    model.push_back(body);

    setModel(model);
}

Food::~Food() {
}

} // namespace Entities
