//
//  RolyPolyModel.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "RolyPolyModel.h"

#include "Sphere.h"


namespace Models {

RolyPolyModel::RolyPolyModel() {
    SurfacesList surfaces;
    std::shared_ptr<Surfaces::Sphere> sphere = std::shared_ptr<Surfaces::Sphere>::make_shared();
    surfaces.push_back(sphere);
    setSurfaces(surfaces);
}

RolyPolyModel::~RolyPolyModel() {

}

} // namespace Models
