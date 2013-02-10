//
//  RolyPolyModel.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __RolyPolyModel_H_
#define __RolyPolyModel_H_

#include <memory>

#include "Model.h"


namespace Models {

class RolyPolyModel : public Model {
public:
    typedef std::shared_ptr<RolyPolyModel> SharedPtr;

public:
    RolyPolyModel();
    virtual ~RolyPolyModel();
};

} // namespace Models

#endif //__RolyPolyModel_H_
