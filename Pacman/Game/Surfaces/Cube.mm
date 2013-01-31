//
//  Cube.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Cube.h"


namespace Surfaces {

void Cube::generateVertexes() {
    const GLsizeiptr vertexesCount = 36;
    GLfloat vertexDataSrc[] = {
        // Data layout for each line below is:
        // positionX, positionY, positionZ,     normalX, normalY, normalZ,
        0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,
        0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
        0.5f, 0.5f, 0.5f,          1.0f, 0.0f, 0.0f,

        0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,
        -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
        0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
        0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
        -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
        -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,

        -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,
        -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
        -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
        -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
        -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
        -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,

        -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,
        0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
        -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
        -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
        0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
        0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,

        0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,
        -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
        0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
        0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
        -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
        -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,

        0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,
        -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
        0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
        0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
        -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
        -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f
    };
    setCopyVertexes(vertexDataSrc, vertexesCount);
}

} // namespace Surfaces
