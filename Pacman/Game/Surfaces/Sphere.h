//
//  Sphere.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Sphere_H_
#define __Sphere_H_

#include "Surface.h"


namespace Surfaces {

class Sphere : public Surface {
public:
    Sphere();

    virtual void update(NSTimeInterval time);

protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();

    virtual bool haveTexCoord() const { return true; }

};

} // namespace Surfaces

#endif //__Sphere_H_
