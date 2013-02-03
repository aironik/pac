//
//  Vertex.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 03.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Vertex.h"

namespace Surfaces {

Vertex::Vertex()
        : position(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , normal(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex::Vertex(GLKVector3 position)
        : position(position)
        , normal(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex::Vertex(GLKVector3 position, GLKVector3 normal)
        : position(position)
        , normal(normal)
        , texCoord(GLKVector2Make(0.0f, 0.0f))
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

Vertex::Vertex(GLKVector3 position, GLKVector3 normal, GLKVector2 texCoord)
        : position(position)
        , normal(normal)
        , texCoord(texCoord)
        , color(GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f))
{
}

} // namespace Surfaces