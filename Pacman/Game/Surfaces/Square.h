//
//  Square.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 29.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Square_H_
#define __Square_H_

#include "Surface.h"


namespace Surfaces {

class Square : public Surface {
protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();
};

} // namespace Surfaces


#endif //__Square_H_
