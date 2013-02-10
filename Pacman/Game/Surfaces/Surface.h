//
//  Surface.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Surface_H_
#define __Surface_H_

#include <vector>

#include "Vertex3D.h"

extern const GLuint k3Dimensional;

namespace Surfaces {

class Surface {
public:
    typedef std::shared_ptr<Surface> SharedPtr;
    typedef std::vector<Vertex3D> VertexList;

public:
    Surface();
    virtual ~Surface();

    void init();
    void destroy();
    void draw();
    virtual void update(NSTimeInterval timeInterval);        ///<

protected:
    virtual void generateVertexes() = 0;
    virtual void destroyVertexes() = 0;

    void rebindData();

    size_t getVertexesCount() const { return vertexes.size(); }
    const VertexList &getVertexes() const { return vertexes; }
    void setVertexes(const VertexList &vertexes);
    void setDrawMode(GLenum drawMode) { this->drawMode = drawMode; }
    GLenum getDrawMode() const { return drawMode; }
    float getTimeInterval() const { return timeInterval; }

    virtual bool haveNormals() const { return true; }
    virtual bool haveTexCoord() const { return false; }
    virtual bool haveColor() const { return false; }


private:
    void genName();
    void destroyName();
    void genBuffer();
    void destroyBuffer();
    void destroyData();
    void bind();
    void bindBuffer();

private:
    GLuint name;
    GLuint buffer;

    VertexList vertexes;
    GLenum drawMode;

    NSTimeInterval timeInterval;
};

} // namespace Surfaces


#endif //__Surface_H_
