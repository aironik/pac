//
//  Ribbon.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 31.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Ribbon_H_
#define __Ribbon_H_

#include "Surface.h"


namespace Surfaces {

class Ribbon : public Surface {
public:
    Ribbon();

    virtual void init();
    virtual void destroy();

    virtual void update(NSTimeInterval timeInterval);

protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();

private:
    void generateVertexesCoordinates(GLKVector3 *vertexDataSrc, GLsizeiptr vertexesCount) const;
    void rotateVertexesAndNormals();
    void rotateVertexAndNormal(GLKVector3 &vertex, GLKVector3 &normal) const;

private:
    NSTimeInterval time;
    GLKVector3 *vertexDataOriginal;
};

} // namespace Surfaces

#endif //__Ribbon_H_
