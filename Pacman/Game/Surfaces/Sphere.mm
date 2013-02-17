//
//  Sphere.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Sphere.h"

namespace Surfaces {

Sphere::Sphere() {
    setDrawMode(GL_TRIANGLE_STRIP);
}

void Sphere::update(NSTimeInterval time) {
    Surface::update(time);
}

void Sphere::generateVertexes() {
    VertexList vertexDataOriginal;
    const int alphaSectorsCount = 10;
    const int bettaSectorsCount = alphaSectorsCount * 2;
    const GLKVector3 position = GLKVector3Make(0.5f, 0.0f, 0.0f);

    const float alphaStep = M_PI / alphaSectorsCount;
    const float alphaStart = -M_PI_2;

    const float bettaStep = 2.0f * M_PI / bettaSectorsCount;
    const float bettaStart = 0.0f;

    for (int i = 1; i <= alphaSectorsCount; ++i) {
        float alpha1 = alphaStart + alphaStep * (i - 1);
        float alpha2 = alphaStart + alphaStep * i;

        for (int j = 0; j <= bettaSectorsCount; ++j) {
            float betta = bettaStart + bettaStep * j;

            GLKMatrix3 rotateMatrixH1 = GLKMatrix3RotateY(GLKMatrix3Identity, betta);
            GLKMatrix3 rotateMatrixH2 = GLKMatrix3RotateY(GLKMatrix3Identity, betta);
            GLKMatrix3 rotateMatrix1 = GLKMatrix3RotateZ(rotateMatrixH1, alpha1);
            GLKMatrix3 rotateMatrix2 = GLKMatrix3RotateZ(rotateMatrixH2, alpha2);

            Vertex3D position1(GLKMatrix3MultiplyVector3(rotateMatrix1, position));
            position1.normal = position1.position;
            position1.texCoord = GLKVector2Make((float)j * (1.0f / bettaSectorsCount), (float)(i - 1) * (1.0f / alphaSectorsCount));
            Vertex3D position2(GLKMatrix3MultiplyVector3(rotateMatrix2, position));
            position2.normal = position2.position;
            position2.texCoord = GLKVector2Make((float)j * (1.0f / bettaSectorsCount), (float)i * (1.0f / alphaSectorsCount));
            vertexDataOriginal.push_back(position1);
            vertexDataOriginal.push_back(position2);
        }
    }
    setVertexes(vertexDataOriginal);
}

void Sphere::destroyVertexes() {
}

} // namespace Surfaces
