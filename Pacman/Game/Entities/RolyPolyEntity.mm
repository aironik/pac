//
//  RolyPolyEntity.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "RolyPolyEntity.h"

#include "Program.h"
#include "Sphere.h"


namespace Entities {

RolyPolyEntity::RolyPolyEntity() {
    Surfaces::Sphere::SharedPtr sphere = Surfaces::Sphere::SharedPtr::make_shared();
    sphere->init();

    ProgramGl::Program::SharedPtr program = ProgramGl::Program::createDefaultProgram();
    program->setDiffuseColor(GLKVector4Make(1.0f, 1.0f, 0.0f, 1.0f));

    Model model;
    model.push_back(SurfacePair(sphere, program));
    setModel(model);
}

RolyPolyEntity::~RolyPolyEntity() {
    Model model = getModel();
    for (Model::const_iterator it = model.begin(); it != model.end(); ++it) {
        it->first->destroy();
    }
}

} // namespace Entities
