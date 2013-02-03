//
//  Surface.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Surface.h"

#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#include "assert.h"

const GLuint k3Dimensional = 3;

namespace Surfaces {

Surface::Surface()
        : name(0)
        , vertexesCount(0)
        , vertexes(NULL)
        , mode(GL_TRIANGLES)
{
}

Surface::~Surface() {
    destroy();
}

void Surface::init() {
    generateVertexes();

    genName();
    bind();

    genBuffer();
    refreshBuffer();
    
    unbind();
}

void Surface::destroy() {
    deleteBuffer();
    deleteName();
    deleteVertexes();

    destroyVertexes();
}


void Surface::bind() {
    if (!name) {
        init();
    }
    glBindVertexArrayOES(name);
}

void Surface::unbind() {
    glBindVertexArrayOES(0);
}

void Surface::draw() {
    glDrawArrays(getMode(), 0, getVertexesCount());
}

void Surface::setVertexes(GLvoid *vertexes, GLsizeiptr vertexesCount) {
    deleteVertexes();

    this->vertexes = vertexes;
    this->vertexesCount = vertexesCount;

    updateBuffer();
}

void Surface::setCopyVertexes(GLvoid *vertexesSrc, GLsizeiptr vertexesCount) {
    const size_t bufferSize = sizeof(GLfloat) * vertexesCount * (2 * getDimensionCount());
    GLfloat *vertexData = (GLfloat *)malloc(bufferSize);

    memcpy(vertexData, vertexesSrc, bufferSize);

    setVertexes(vertexData, vertexesCount);
}

void Surface::deleteVertexes() {
    if (vertexes != NULL) {
        free(vertexes);
        vertexes = NULL;
    }
    vertexesCount = 0;
}

void Surface::genName() {
    glGenVertexArraysOES(1, &name);
}

const GLint Surface::getName() const {
    assert(name && "init before");
    return name;
}

void Surface::deleteName() {
    glDeleteVertexArraysOES(1, &name);
    name = 0;
}

void Surface::genBuffer() {
    glGenBuffers(1, &buffer);
}

void Surface::bindBuffer() {
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
}

void Surface::updateBuffer() {
    if (buffer) {
        const GLsizei positionSize = sizeof(GLfloat) * getDimensionCount();
        const GLvoid *positionPtr = (char *)NULL;
        const GLsizei normalsSize = haveNormals() ? (sizeof(GLfloat) * getDimensionCount()) : 0;
        const GLvoid *normalsPtr = haveNormals() ? ((char *)NULL + positionSize) : 0;
        const GLsizeiptr vertexSize = positionSize + normalsSize;
        const GLsizeiptr bufferSize = getVertexesCount() * vertexSize;

        glBufferData(GL_ARRAY_BUFFER, bufferSize, getVertexes(), GL_STATIC_DRAW);

        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, getDimensionCount(), GL_FLOAT, getIsNormalized(),
                              vertexSize, positionPtr);
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, getDimensionCount(), GL_FLOAT, getIsNormalized(),
                              vertexSize, normalsPtr);
    }
}

void Surface::refreshBuffer() {
    bindBuffer();
    updateBuffer();
}

void Surface::deleteBuffer() {
    glDeleteBuffers(1, &buffer);
    buffer = 0;
}

} // namespace Surfaces
