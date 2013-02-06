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

    virtual void update(NSTimeInterval time);

protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();

    virtual bool haveTexCoord() const { return true; }

private:
    void generateVertexesCoordinates(size_t vertexesCount);
    void rotateVertexesAndNormals();
    void rotateVertexAndNormal(GLKVector3 &vertex, GLKVector3 &normal) const;

private:
    VertexList vertexDataOriginal;
};

} // namespace Surfaces

#endif //__Ribbon_H_
