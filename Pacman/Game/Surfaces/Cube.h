//
//  Cube.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#ifndef __Cube_H_
#define __Cube_H_

#include "Surface.h"


namespace Surfaces {

class Cube : public Surface {
protected:
    virtual void generateVertexes();
    virtual void destroyVertexes();

    virtual bool haveNormals() const { return true; }
    
};

} // namespace Surfaces

#endif //__Cube_H_
