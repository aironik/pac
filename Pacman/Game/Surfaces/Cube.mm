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
    VertexList vertexDataSrc = {
            // Data layout for each line below is:
            // positionX, positionY, positionZ,     normalX, normalY, normalZ,
            Vertex3D(0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f),
            Vertex3D(0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f),
            Vertex3D(0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f),
            Vertex3D(0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f),
            Vertex3D(0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f),
            Vertex3D(0.5f, 0.5f, 0.5f,          1.0f, 0.0f, 0.0f),

            Vertex3D(0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f),
            Vertex3D(-0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f),
            Vertex3D(0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f),
            Vertex3D(0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f),
            Vertex3D(-0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f),
            Vertex3D(-0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f),

            Vertex3D(-0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f),
            Vertex3D(-0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f),
            Vertex3D(-0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f),
            Vertex3D(-0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f),
            Vertex3D(-0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f),
            Vertex3D(-0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f),

            Vertex3D(-0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f),
            Vertex3D(0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f),
            Vertex3D(-0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f),
            Vertex3D(-0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f),
            Vertex3D(0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f),
            Vertex3D(0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f),

            Vertex3D(0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f),
            Vertex3D(-0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f),
            Vertex3D(0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f),
            Vertex3D(0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f),
            Vertex3D(-0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f),
            Vertex3D(-0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f),

            Vertex3D(0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f),
            Vertex3D(-0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f),
            Vertex3D(0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f),
            Vertex3D(0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f),
            Vertex3D(-0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f),
            Vertex3D(-0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f)
    };
    setVertexes(vertexDataSrc);
}

void Cube::destroyVertexes() {
}

} // namespace Surfaces
