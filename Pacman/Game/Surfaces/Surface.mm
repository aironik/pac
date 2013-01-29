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


namespace Surfaces {

Surface::Surface()
        : name(0)
        , vertexesCount(0)
        , vertexes(NULL)
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
    bindBuffer();

    updateBuffer();

    unbind();
}

void Surface::destroy() {
    deleteBuffer();
    deleteName();
    deleteVertexes();
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

void Surface::setVertexes(GLvoid *vertexes, GLsizeiptr count) {
    deleteVertexes();

    this->vertexes = vertexes;
    this->vertexesCount = count;

    updateBuffer();
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
    glBufferData(GL_ARRAY_BUFFER, getVertexesCount(), getVertexes(), GL_STATIC_DRAW);

    const GLsizei positionSize = sizeof(GLfloat) * getComponentsCount();
    const GLvoid *positionPtr = (char *)NULL;
    const GLsizei normalsSize = haveNormals() ? (sizeof(GLfloat) * getComponentsCount()) : 0;
    const GLvoid *normalsPtr = haveNormals() ? ((char *)NULL + positionSize) : 0;

//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//    glEnableVertexAttribArray(GLKVertexAttribNormal);
//    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));

    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, getComponentsCount(), GL_FLOAT, getIsNormalized(),
                          normalsSize, positionPtr);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, getComponentsCount(), GL_FLOAT, getIsNormalized(),
                          positionSize, normalsPtr);
}

void Surface::deleteBuffer() {
    glDeleteBuffers(1, &buffer);
    buffer = 0;
}

//virtual void generateVertexes() = 0;
//virtual const GLfloat *getVertexes() const = 0;
//virtual const GLint &getVertexesCount() const = 0;


} // namespace Surfaces