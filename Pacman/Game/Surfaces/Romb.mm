//
//  Romb.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 30.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Romb.h"

namespace Surfaces {

Romb::Romb()
        : sectionsCount(4)
{
}

Romb::Romb(GLuint aSectionsCount)
        : sectionsCount(aSectionsCount)
{
}

void Romb::generateVertexes() {
    VertexList vertexDataOriginal;

    const GLKVector3 position = GLKVector3Make(0.3f, 0.0f, 0.0f);
    const GLKVector3 topPosition = GLKVector3Make(0.0f, 0.0f, -0.3f);
    const GLKVector3 bottomPosition = GLKVector3Make(0.0f, 0.0f, 0.3f);

    const float alphaStep = 2 * M_PI / sectionsCount;

    for (GLuint i = 0; i < sectionsCount; ++i) {
        GLKMatrix3 rotateMatrix1 = GLKMatrix3RotateZ(GLKMatrix3Identity, alphaStep * i);
        GLKMatrix3 rotateMatrix2 = GLKMatrix3RotateZ(GLKMatrix3Identity, alphaStep * (i + 1));

        GLKVector3 position1 = GLKMatrix3MultiplyVector3(rotateMatrix1, position);
        GLKVector3 position2 = GLKMatrix3MultiplyVector3(rotateMatrix2, position);
        GLKVector3 normal1 = GLKVector3CrossProduct(GLKVector3Subtract(position2, position1), GLKVector3Subtract(topPosition, position1));
        GLKVector3 normal2 = GLKVector3CrossProduct(GLKVector3Subtract(bottomPosition, position2), GLKVector3Subtract(position1, position2));

        vertexDataOriginal.push_back(Vertex3D(topPosition, normal1));
        vertexDataOriginal.push_back(Vertex3D(position1, normal1));
        vertexDataOriginal.push_back(Vertex3D(position2, normal1));

        vertexDataOriginal.push_back(Vertex3D(position2, normal2));
        vertexDataOriginal.push_back(Vertex3D(position1, normal2));
        vertexDataOriginal.push_back(Vertex3D(bottomPosition, normal2));
    }

    setVertexes(vertexDataOriginal);
}

void Romb::destroyVertexes() {
}

} // namespace Surfaces
