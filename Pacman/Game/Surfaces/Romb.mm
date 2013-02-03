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

Romb::Romb(GLuint sectionsCount)
        : sectionsCount(sectionsCount)
{
}

void Romb::generateVertexes() {
    const GLuint vertexPerTriangle = 3;
    const GLuint trianglesPerSection = 2;
    const GLsizeiptr vertexesCount = vertexPerTriangle * trianglesPerSection * sectionsCount;


    GLKVector3 *const vertexDataSrc = (GLKVector3 *)malloc(sizeof(GLKVector3) * vertexesCount);
    GLKVector3 *vertexDataPtr = vertexDataSrc;

    for (GLuint i = 0; i < sectionsCount; ++i) {
        setTriangle(vertexDataPtr, i, GL_TRUE);
        setTriangle(vertexDataPtr, i, GL_FALSE);
    }

    setVertexes(vertexDataSrc, vertexesCount * 2 * 3);
}

void Romb::setTriangle(GLKVector3 *&vertexDataPtr, GLuint index, GLboolean isTop) {
    const float height = 1.5f;
    const float sign = isTop ? -1.0f : 1.0f;
    const GLKVector3 topVertex = GLKVector3Make(0.0f, sign * height , 0.0f);

    float alpha0 = index * 2 * M_PI / sectionsCount;
    float alpha1 = (index + 1) * 2 * M_PI / sectionsCount;

    const GLKVector3 vertex0 = GLKVector3Make(cosf(alpha0), 0.0f, sinf(alpha0));
    const GLKVector3 vertex1 = GLKVector3Make(cosf(alpha1), 0.0f, sinf(alpha1));

    GLKVector3 normal = GLKVector3CrossProduct(GLKVector3Subtract(vertex1, vertex0),
                                               GLKVector3Subtract(topVertex, vertex0));
    if (!isTop) {
        normal = GLKVector3Negate(normal);
    }

    vertexDataPtr[0] = topVertex;
    vertexDataPtr[1] = normal;
    vertexDataPtr[2] = vertex0;
    vertexDataPtr[3] = normal;
    vertexDataPtr[4] = vertex1;
    vertexDataPtr[5] = normal;
    vertexDataPtr += 6;
}


} // namespace Surfaces
