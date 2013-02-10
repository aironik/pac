//
//  Vertex3D.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 03.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Vertex3D.h"

namespace Surfaces {

Vertex3D::Vertex3D()
        : position(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , normal(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex3D::Vertex3D(GLKVector3 aPosition)
        : position(aPosition)
        , normal(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex3D::Vertex3D(GLKVector3 aPosition, GLKVector3 aNormal)
        : position(aPosition)
        , normal(aNormal)
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex3D::Vertex3D(GLKVector3 aPosition, GLKVector3 aNormal, GLKVector2 aTexCoord)
        : position(aPosition)
        , normal(aNormal)
        , texCoord(aTexCoord)
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}
    
Vertex3D::Vertex3D(GLfloat px, GLfloat py, GLfloat pz)
        : position(GLKVector3Make(px, py, pz))
        , normal(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex3D::Vertex3D(GLfloat px, GLfloat py, GLfloat pz, GLfloat nx, GLfloat ny, GLfloat nz)
        : position(GLKVector3Make(px, py, pz))
        , normal(GLKVector3Make(nx, ny, nz))
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}


} // namespace Surfaces