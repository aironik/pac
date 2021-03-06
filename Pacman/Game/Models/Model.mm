//
//  Model.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Model.h"

namespace Models {

Model::Model(Surfaces::Surface::SharedPtr aSurface, ProgramGl::Program::SharedPtr aProgram)
        : surface(aSurface)
        , program(aProgram)
        , surfaceOffset(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , surfaceRotationVector(GLKVector3Make(0.0f, 0.0f, 1.0f))
        , surfaceRotationAngle(0.0f)
        , centerOffset(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , centerRotationVector(GLKVector3Make(0.0f, 0.0f, 1.0f))
        , centerRotationAngle(0.0f)
        , sizeScale(GLKVector3Make(1.0f, 1.0f, 1.0f))
        , modelViewMatrix(GLKMatrix4Identity)
{
    surface->init();
}

Model::~Model() {
    surface->destroy();
}

void Model::update(NSTimeInterval timeInterval) {
    surface->update(timeInterval);
    program->setModelViewMatrix(modelViewMatrix);
}

void Model::draw() const {
    program->apply();
    surface->draw();
}

void Model::setSurfaceOffset(const GLKVector3 &offset) {
    surfaceOffset = offset;
    updateModelViewMatrix();
}

void Model::setSurfaceRotation(const float angle, const GLKVector3 &rotationVector) {
    NSCAssert(GLKVector3Length(rotationVector) > 0.0f, @"Rotation vactor can't be 0");
    surfaceRotationVector = rotationVector;
    surfaceRotationAngle = angle;
    updateModelViewMatrix();
}

void Model::setCenterOffset(const GLKVector3 &position) {
    centerOffset = position;
    updateModelViewMatrix();
}

void Model::setCenterRotation(const float angle, const GLKVector3 &rotationVector) {
    NSCAssert(GLKVector3Length(rotationVector) > 0.0f, @"Rotation vactor can't be 0");
    centerRotationVector = rotationVector;
    centerRotationAngle = angle;
    updateModelViewMatrix();
}

void Model::setSizeScale(const GLKVector3 &scale) {
    sizeScale = scale;
    updateModelViewMatrix();
}

void Model::updateModelViewMatrix() {
    GLKMatrix4 identity = GLKMatrix4Identity;

    GLKMatrix4 scale = GLKMatrix4ScaleWithVector3(identity, sizeScale);

    GLKMatrix4 surfaceRotated = GLKMatrix4RotateWithVector3(scale, surfaceRotationAngle, surfaceRotationVector);

    GLKMatrix4 surfaceTranslated = GLKMatrix4TranslateWithVector3(surfaceRotated, surfaceOffset);

    GLKMatrix4 centerRotated = GLKMatrix4RotateWithVector3(surfaceTranslated,
                                                           centerRotationAngle,
                                                           centerRotationVector);

    modelViewMatrix = GLKMatrix4TranslateWithVector3(centerRotated, centerOffset);
}

} // namespace Models
