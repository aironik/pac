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
    const GLsizeiptr componentsCount = vertexPerTriangle * trianglesPerSection * sectionsCount;


    GLKVector3 *const vertexDataSrc = (GLKVector3 *)malloc(sizeof(GLKVector3) * componentsCount * 2);
    GLKVector3 *vertexDataPtr = vertexDataSrc;

    float height = 1.5f;
    const GLKVector3 topVertex = GLKVector3Make(0.0f, -height , 0.0f);
    const GLKVector3 bottomVertex = GLKVector3Make(0.0f, height , 0.0f);
    for (GLuint i = 0; i < sectionsCount; ++i) {
        float alpha0 = i * 2 * M_PI / sectionsCount;
        float alpha1 = (i + 1) * 2 * M_PI / sectionsCount;

        const GLKVector3 vertex0 = GLKVector3Make(cosf(alpha0), 0.0f, sinf(alpha0));
        const GLKVector3 vertex1 = GLKVector3Make(cosf(alpha1), 0.0f, sinf(alpha1));

        GLKVector3 normal1 = GLKVector3CrossProduct(GLKVector3Subtract(vertex1, vertex0),
                                                   GLKVector3Subtract(topVertex, vertex0));
        vertexDataPtr[0] = topVertex;
        vertexDataPtr[1] = normal1;
        vertexDataPtr[2] = vertex0;
        vertexDataPtr[3] = normal1;
        vertexDataPtr[4] = vertex1;
        vertexDataPtr[5] = normal1;
        vertexDataPtr += 6;

        GLKVector3 normal2 = GLKVector3CrossProduct(GLKVector3Subtract(vertex0, vertex1),
                                                   GLKVector3Subtract(bottomVertex, vertex1));
        vertexDataPtr[0] = bottomVertex;
        vertexDataPtr[1] = normal2;
        vertexDataPtr[2] = vertex1;
        vertexDataPtr[3] = normal2;
        vertexDataPtr[4] = vertex0;
        vertexDataPtr[5] = normal2;
        vertexDataPtr += 6;
    }

    setCopyVertexes(vertexDataSrc, componentsCount * 2 * 3);
}

} // namespace Surfaces
