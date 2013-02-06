//
//  Romb.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 30.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Romb_H_
#define __Romb_H_

#include "Surface.h"


namespace Surfaces {

class Romb : public Surface {
public:
    Romb();
    Romb(GLuint sectionsCount);

protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();

private:
    void setTriangle(GLKVector3 *&vertexDataPtr, GLuint index, GLboolean isTop);

private:
    GLuint sectionsCount;
};

} // namespace Surfaces

#endif //__Romb_H_
