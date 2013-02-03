//
//  Ribbon.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 31.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Ribbon.h"

namespace {
static const GLuint vertexTrialglesDelta = 3;
static const GLuint trianglesPerRobon = 40;
static const float startTorsionPosition = 6.0f;
static const float torsionSpeed = 8.0f;
} // namespace ::

namespace Surfaces {

Ribbon::Ribbon()
        : time(0.0)
        , vertexDataOriginal(0)
{
    setMode(GL_TRIANGLE_STRIP);
}

void Ribbon::init() {

}

void Ribbon::destroy() {

}

void Ribbon::generateVertexes() {
    const GLsizeiptr vertexesCount = trianglesPerRobon + vertexTrialglesDelta;

    vertexDataOriginal = (GLKVector3 *)malloc(sizeof(GLKVector3) * vertexesCount * 2);

    generateVertexesCoordinates(vertexDataOriginal, vertexesCount);

    setCopyVertexes(vertexDataOriginal, vertexesCount);

    update(0.0);
}

void Ribbon::destroyVertexes() {
    free(vertexDataOriginal);
    vertexDataOriginal = 0;
}

void Ribbon::generateVertexesCoordinates(GLKVector3 *vertexData, GLsizeiptr vertexesCount) const {
    float length = 5.0f;
    float width2 = 1.0f;
    int lengthIndex = vertexesCount - vertexTrialglesDelta;

    const float firstX = -length / 2.0f;
    const float lastX = length / 2.0f;

    for (int i = -1; i < vertexesCount - 1; ++i) {
        float y = i % 2 ? width2 : -width2;
        float x = length * (i * (1.0f / lengthIndex) - 1.0f / 2.0f);
        x = std::max(firstX, std::min(x, lastX));
        GLKVector3 vertex = GLKVector3Make(x, y, 0.0f);
        GLKVector3 normal = GLKVector3Make(0.0f, 0.0f, -1.0f);

        vertexData[0] = vertex;
        vertexData[1] = normal;
        vertexData +=2;
    }
}

void Ribbon::update(NSTimeInterval timeInterval) {
    time += timeInterval;
    rotateVertexesAndNormals();
    refreshBuffer();
}

void Ribbon::rotateVertexesAndNormals() {
    GLsizeiptr count = getVertexesCount();
    GLKVector3 *vertexDataDst = (GLKVector3 *)getVertexes();
    GLKVector3 *vertexDataSrc = vertexDataOriginal;
    for (int i = 0; i < count; ++i) {
        GLKVector3 vertex = vertexDataSrc[0];
        GLKVector3 normal = vertexDataSrc[1];

        rotateVertexAndNormal(vertex, normal);

        vertexDataDst[0] = vertex;
        vertexDataDst[1] = normal;
        
        vertexDataSrc += 2;
        vertexDataDst +=2;
    }
}

void Ribbon::rotateVertexAndNormal(GLKVector3 &vertex, GLKVector3 &normal) const {
    const float torsionLength = 5.0f;
    const float startX = startTorsionPosition - time * torsionSpeed;

    const float alpha = M_PI * std::max(0.0f, std::min((vertex.x - startX) / torsionLength, 1.0f));

    GLKMatrix3 rotateMatrix = GLKMatrix3RotateX(GLKMatrix3Identity, alpha);
    vertex = GLKMatrix3MultiplyVector3(rotateMatrix, vertex);
    normal = GLKMatrix3MultiplyVector3(rotateMatrix, normal);
}

}