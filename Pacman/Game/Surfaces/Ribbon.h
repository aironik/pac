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
    virtual void update(NSTimeInterval timeInterval);

protected:
    virtual void generateVertexes();

private:
    void update();

private:
    NSTimeInterval time;

};

} // namespace Surfaces

#endif //__Ribbon_H_
