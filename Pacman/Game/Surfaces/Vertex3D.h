//
//  Vertex3D.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 03.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Vertex_H_
#define __Vertex_H_

namespace Surfaces {

struct Vertex3D {
public:
    GLKVector3 position;        ///< Позиция вершины в 3D-пространстве
    GLKVector3 normal;          ///< Нормаль вершины
    GLKVector2 texCoord;        ///< Текстурные координаты вершины
    GLKVector4 color;           ///< Цвет вершины

public:
    Vertex3D();
    Vertex3D(GLKVector3 position);
    Vertex3D(GLKVector3 position, GLKVector3 normal);
    Vertex3D(GLKVector3 position, GLKVector3 normal, GLKVector2 texCoord);
    Vertex3D(GLfloat px, GLfloat py, GLfloat pz);
    Vertex3D(GLfloat px, GLfloat py, GLfloat pz, GLfloat nx, GLfloat ny, GLfloat nz);

    static const GLsizei positionSize() { return sizeof(position); }
    static const GLvoid *positionPtr() { return (char *)0; }
    static const GLsizei normalSize() { return sizeof(normal); }
    static const GLvoid *normalPtr() { return (char *)0 + positionSize(); }
    static const GLsizei texCoordSize() { return sizeof(texCoord); }
    static const GLvoid *texCoordPtr() { return (char *)0 + positionSize() + normalSize(); }
    static const GLsizei colorSize() { return sizeof(color); }
    static const GLvoid *colorPtr() { return (char *)0 + positionSize() + normalSize() + texCoordSize(); }
};

} // namespace Surfaces

#endif //__Vertex_H_
