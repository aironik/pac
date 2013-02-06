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
        , buffer(0)
        , drawMode(GL_TRIANGLES)
        , timeInterval(0.0f)
{
}

Surface::~Surface() {
    NSCAssert(!name,  @"invoke destroy before");
    NSCAssert(!buffer, @"invoke destroy before");
}

void Surface::init() {
    genName();
    genBuffer();

    generateVertexes();
    rebindData();
}

void Surface::destroy() {
    destroyData();
    destroyVertexes();

    destroyBuffer();
    destroyName();
}

void Surface::draw() {
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    if (haveNormals()) {
        glEnableVertexAttribArray(GLKVertexAttribNormal);
    } else {
        glDisableVertexAttribArray(GLKVertexAttribNormal);
    }

    if (haveTexCoord()) {
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    } else {
        glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
    }
    if (haveColor()) {
        glEnableVertexAttribArray(GLKVertexAttribColor);
    } else {
        glDisableVertexAttribArray(GLKVertexAttribColor);
    }
    bind();
    glDrawArrays(getDrawMode(), 0, getVertexesCount());
}

void Surface::update(NSTimeInterval timeInterval) {
    this->timeInterval += timeInterval;
}


void Surface::genName() {
    NSCAssert(!name, @"Already inited");

    glGenVertexArraysOES(1, &name);
}

void Surface::destroyName() {
    if (name) {
        glDeleteVertexArraysOES(1, &name);
        name = 0;
    }
}

void Surface::genBuffer() {
    NSCAssert(!buffer, @"Already inited");
    glGenBuffers(1, &buffer);
}

void Surface::destroyBuffer() {
    if (buffer) {
        glDeleteBuffers(1, &buffer);
        buffer = 0;
    }
}

void Surface::destroyData() {
    vertexes.clear();
}

void Surface::bind() {
    NSCAssert(name, @"invoke init before.");
    glBindVertexArrayOES(name);
}

void Surface::bindBuffer() {
    NSCAssert(name, @"invoke init before.");
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
}

void Surface::rebindData() {
    bind();
    bindBuffer();

    const GLsizeiptr bufferSize = getVertexesCount() * sizeof(Vertex3D);

    glBufferData(GL_ARRAY_BUFFER, bufferSize, &getVertexes().front(), GL_STATIC_DRAW);

    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, haveNormals(), sizeof(Vertex3D), Vertex3D::positionPtr());

    if (haveNormals()) {
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, haveNormals(), sizeof(Vertex3D), Vertex3D::normalPtr());
    }

    if (haveTexCoord()) {
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, haveNormals(), sizeof(Vertex3D), Vertex3D::texCoordPtr());
    }
    
    if (haveColor()) {
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex3D), Vertex3D::colorPtr());
    }
}

void Surface::setVertexes(const VertexList &vertexes) {
    destroyData();

    this->vertexes = vertexes;

    rebindData();
}


} // namespace Surfaces
