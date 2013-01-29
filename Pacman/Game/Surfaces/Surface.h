//
//  Surface.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Surface_H_
#define __Surface_H_

#include <iostream>


namespace Surfaces {

class Surface {
public:
    Surface();
    virtual ~Surface();

    void init();
    void destroy();
    void bind();
    void unbind();
    void draw();

protected:
    virtual void generateVertexes() = 0;

    void setVertexes(GLvoid *vertexes, GLsizeiptr count);
    const GLsizeiptr &getVertexesCount() const { return vertexesCount; }
    const GLvoid *getVertexes() const { return vertexes; }
    /// @brief количество измерений (трехмерный мир)
    const GLint getComponentsCount() const { return 3; }
    const GLboolean getIsNormalized() const { return GL_FALSE; }
    const GLboolean haveNormals() const { return GL_TRUE; }
    void setMode(GLenum newMode) { mode = newMode; }
    const GLenum getMode() const { return mode; }

private:
    const GLint getName() const;

    void genName();
    void deleteName();

    void genBuffer();
    void bindBuffer();
    void updateBuffer();
    void deleteBuffer();

    void deleteVertexes();

private:
    GLuint name;
    GLuint buffer;

    GLsizeiptr vertexesCount;
    GLvoid *vertexes;
    GLenum mode;
};

} // namespace Surfaces


#endif //__Surface_H_
