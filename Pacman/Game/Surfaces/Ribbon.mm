//
//  Ribbon.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 31.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Ribbon.h"

#include <algorithm>


namespace {
static const GLuint vertexTrialglesDelta = 2;
static const GLuint trianglesPerRobon = 8;
static const float startTorsionPosition = 6.0f;
static const float torsionSpeed = 2.0f;
static const float torsionLength = 5.0f;
} // namespace ::

namespace Surfaces {

Ribbon::Ribbon()
        : vertexDataOriginal(0)
{
    setDrawMode(GL_TRIANGLE_STRIP);
}

void Ribbon::update(NSTimeInterval time) {
    Surface::update(time);
    
    rotateVertexesAndNormals();
    rebindData();
}

void Ribbon::generateVertexes() {
    const GLsizeiptr vertexesCount = trianglesPerRobon + vertexTrialglesDelta;

    vertexDataOriginal.resize(vertexesCount);

    generateVertexesCoordinates(vertexesCount);

    update(0.0);
}

void Ribbon::destroyVertexes() {
    vertexDataOriginal.clear();
}

void Ribbon::generateVertexesCoordinates(size_t vertexesCount) {
    vertexDataOriginal.resize(vertexesCount);

    const float width2 = 1.0f;
    const float length = 5.0f;
    const float xStep = length / (vertexesCount - vertexTrialglesDelta - 1);
    const float xOffset = -(length / 2.0f + xStep);

    for (size_t i = 0; i < vertexesCount; ++i) {
        float y = i % 2 ? width2 : -width2;
        float texY = i % 2 ? 1.0f : -0.0f;
        float x = xOffset + i * xStep;
        float texX = ((float)i - 1) * xStep / length;
        GLKVector3 vertex = GLKVector3Make(x, y, 0.0f);
        GLKVector3 normal = GLKVector3Make(0.0f, 0.0f, -1.0f);
        GLKVector2 texCoord = GLKVector2Make(texX, texY);

        vertexDataOriginal[i].position = vertex;
        vertexDataOriginal[i].normal = normal;
        vertexDataOriginal[i].texCoord = texCoord;
    }
    // коорректируем координаты 1-й и последней точек
    vertexDataOriginal[0].position.x = -length / 2.0f;
    vertexDataOriginal[0].texCoord.x = 0.0f;
    vertexDataOriginal[vertexesCount - 1].position.x = length / 2.0f;
    vertexDataOriginal[vertexesCount - 1].texCoord.x = 1.0f;

    NSCAssert(vertexDataOriginal[0].position.x == vertexDataOriginal[1].position.x, @"impropper start calculating");
    NSCAssert(vertexDataOriginal[0].texCoord.x == vertexDataOriginal[1].texCoord.x, @"impropper start calculating");
    NSCAssert(abs(vertexDataOriginal[vertexesCount - 1].position.x - vertexDataOriginal[vertexesCount - 2].position.x) < 0.00001, @"impropper finis clating");
    NSCAssert(abs(vertexDataOriginal[vertexesCount - 1].texCoord.x - vertexDataOriginal[vertexesCount - 2].texCoord.x) < 0.00001, @"impropper finis clating");
}

void Ribbon::rotateVertexesAndNormals() {
    size_t count = vertexDataOriginal.size();
    NSCAssert(count, @"invoke generateVertexesCoordinates() before");
    VertexList vertexDataDst;
    vertexDataDst.resize(count);
    for (size_t i = 0; i < count; ++i) {
        Vertex3D vertex = vertexDataOriginal[i];
        rotateVertexAndNormal(vertex.position, vertex.normal);
        vertexDataDst[i] = vertex;
    }
    setVertexes(vertexDataDst);
}

void Ribbon::rotateVertexAndNormal(GLKVector3 &vertex, GLKVector3 &normal) const {
    const float startX = startTorsionPosition - getTimeInterval() * torsionSpeed;

    const float alpha = M_PI * std::max(0.0f, std::min((vertex.x - startX) / torsionLength, 1.0f));

    GLKMatrix3 rotateMatrix = GLKMatrix3RotateX(GLKMatrix3Identity, alpha);
    vertex = GLKMatrix3MultiplyVector3(rotateMatrix, vertex);
    normal = GLKMatrix3MultiplyVector3(rotateMatrix, normal);
}

}