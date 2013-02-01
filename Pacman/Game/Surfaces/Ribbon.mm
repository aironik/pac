//
//  Ribbon.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 31.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Ribbon.h"


namespace Surfaces {

Ribbon::Ribbon()
        : time(0.0)
{
    setMode(GL_TRIANGLE_STRIP);
}

void Ribbon::generateVertexes() {
    update();
}

void Ribbon::update(NSTimeInterval timeInterval) {
    time += timeInterval;
    update();
}

void Ribbon::update() {
    const GLuint trianglesPerRobon = 10;
    const GLsizeiptr vertexesCount = trianglesPerRobon + 2;

    GLKVector3 *const vertexDataSrc = (GLKVector3 *)malloc(sizeof(GLKVector3) * vertexesCount * 2);
    GLKVector3 *vertexDataPtr = vertexDataSrc;

    const float startXPoint = 10.0f - time;
    const GLint startIndex = startXPoint;
    const GLint lengthIndex = vertexesCount;
    const GLint endIndex = startIndex + lengthIndex;
    float length = 5.0f;
    float width = 1.0f;

    for (GLint i = 0; i < vertexesCount; ++i) {
        float sign = i % 2 ? 1.0f : -1.0f;
        GLKVector3 vertex = GLKVector3Make(length * i * (1.0f / lengthIndex) - length / 2.0f, sign * width, 0);
        GLKVector3 normal = GLKVector3Make(0.0f, 0.0f, -1.0f);

        float alpha = 0.0f;
        if (i > startXPoint && i < endIndex) {
            alpha = M_PI * (1.0f * (i - startXPoint) / lengthIndex);
        } else if (i >= endIndex) {
            alpha = M_PI;
        }
        GLKMatrix3 rotateMatrix = GLKMatrix3RotateX(GLKMatrix3Identity, alpha);
        vertex = GLKMatrix3MultiplyVector3(rotateMatrix, vertex);
        normal = GLKMatrix3MultiplyVector3(rotateMatrix, normal);

        vertexDataPtr[0] = vertex;
        vertexDataPtr[1] = normal;
        vertexDataPtr +=2;
    }
    setCopyVertexes(vertexDataSrc, vertexesCount);
}

}