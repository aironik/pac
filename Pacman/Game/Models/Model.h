//
//  Model.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Model_H_
#define __Model_H_

#include <memory>
#include <vector>

#include "Program.h"
#include "Surface.h"


namespace Models {

class Model {
public:
    typedef std::shared_ptr<Model> SharedPtr;

public:
    Model(Surfaces::Surface::SharedPtr surface, ProgramGl::Program::SharedPtr program);
    virtual ~Model();

    virtual void update(NSTimeInterval timeInterval);
    virtual void draw() const;

    void setSurfaceOffset(const GLKVector3 &offset);
    void setSurfaceRotation(const float angle, const GLKVector3 &rotation);

    void setCenterOffset(const GLKVector3 &position);
    void setCenterRotation(const float angle, const GLKVector3 &rotation);

    void setSizeScale(const GLKVector3 &scale);

private:
    void updateModelViewMatrix();

private:
    Surfaces::Surface::SharedPtr surface;
    ProgramGl::Program::SharedPtr program;

    // Положение данного объекта относительно центральной точки большой конструкции
    GLKVector3 surfaceOffset;
    GLKVector3 surfaceRotationVector;
    float surfaceRotationAngle;

    // Положение всей большой конструкции, частью которой является этот объект
    GLKVector3 centerOffset;
    GLKVector3 centerRotationVector;
    float centerRotationAngle;

    GLKVector3 sizeScale;

    GLKMatrix4 modelViewMatrix;
};

} // namespace Models

#endif //__Model_H_
