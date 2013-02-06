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
protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();
};

} // namespace Surfaces

#endif //__Sphere_H_
