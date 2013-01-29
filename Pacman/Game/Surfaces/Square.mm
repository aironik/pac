//
//  Square.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 29.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Square.h"

namespace Surfaces {

void Square::generateVertexes() {
    const GLsizeiptr vertexCount = 6;
    const size_t bufferSize = sizeof(GLfloat) * vertexCount * (2 * getComponentsCount());
    GLfloat *vertexData = (GLfloat *)malloc(bufferSize);
    GLfloat vertexDataSrc[] = {
        // Data layout for each line below is:
        // positionX, positionY, positionZ,     normalX, normalY, normalZ,
        0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,
        0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, 0.5f, 0.5f,          1.0f, 0.0f, 0.0f,
    };
    memcpy(vertexData, vertexDataSrc, bufferSize);

    setVertexes(vertexData, vertexCount);
}
} // namespace Surfaces