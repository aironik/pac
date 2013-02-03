//
//  Vertex.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 03.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Vertex_H_
#define __Vertex_H_

namespace Surfaces {

struct Vertex {
public:
    GLKVector3 position;        ///< Позиция вершины в 3D-пространстве
    GLKVector3 normal;          ///< Нормаль вершины
    GLKVector2 texCoord;        ///< Текстурные координаты вершины
    GLKVector4 color;           ///< Цвет вершины

public:
    Vertex();
    Vertex(GLKVector3 position);
    Vertex(GLKVector3 position, GLKVector3 normal);
    Vertex(GLKVector3 position, GLKVector3 normal, GLKVector2 texCoord);

    const GLsizei positionSize() const { return sizeof(position); }
    const GLvoid *positionPtr() const { return (char *)0; }
    const GLsizei normalSize() const { return sizeof(normal); }
    const GLvoid *normalPtr() const { return (char *)0 + positionSize(); }
    const GLsizei texCoordSize() const { return sizeof(texCoord); }
    const GLvoid *texCoordPtr() const { return (char *)0 + positionSize() + normalSize(); }
    const GLsizei colorSize() const { return sizeof(color); }
    const GLvoid *colorPtr() const { return (char *)0 + positionSize() + normalSize() + texCoordSize(); }
};

} // namespace Surfaces

#endif //__Vertex_H_
