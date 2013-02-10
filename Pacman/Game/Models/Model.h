//
//  Model.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Model_H_
#define __Model_H_

#include <memory>
#include <vector>

#include "Surface.h"


namespace Models {

class Model {
public:
    typedef std::shared_ptr<Model> SharedPtr;

public:
    Model();
    virtual ~Model();

    virtual void update(NSTimeInterval timeInterval);
    virtual void draw() const;

protected:
    typedef std::vector<Surfaces::Surface::SharedPtr> SurfacesList;

protected:
    void setSurfaces(SurfacesList &aSurfaces) { this->surfaces = aSurfaces; }

private:
    SurfacesList surfaces;
};

} // namespace Models

#endif //__Model_H_
