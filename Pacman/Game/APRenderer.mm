//
//  APRenderer.m
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "APRenderer.h"

#import "Cube.h"
#import "Ribbon.h"
#import "Romb.h"
#import "Sphere.h"
#import "Square.h"
#import "Surface.h"

#import "Entity.h"
#import "RolyPolyEntity.h"
#import "WallEntity.h"

@interface APRenderer () {
    Entities::RolyPolyEntity::SharedPtr _rolyPoly;
    Entities::WallEntity::SharedPtr _wall;
}


@end


#pragma mark - Implementation

@implementation APRenderer

- (id)init {
    if (self = [super init]) {
        [self setupEntities];
    }
    return self;
}

- (void)dealloc {
    [self destroyEntities];
}

- (void)setupEntities {
    _rolyPoly = Entities::RolyPolyEntity::SharedPtr::make_shared();
    _wall = Entities::WallEntity::SharedPtr::make_shared();
}

- (void)destroyEntities {
    _wall.reset();
    _rolyPoly.reset();
}

- (void)update:(NSTimeInterval)timeInterval {
    _rolyPoly->update(timeInterval);
    _wall->update(timeInterval);
}

- (void)render {
    _rolyPoly->draw();
    _wall->draw();
}

- (void)setUserInput:(GLKVector2)direction {
    _rolyPoly->setSpeed(GLKVector2Make(direction.x * 0.5f, direction.y * 0.5f));
    _wall->setSpeed(GLKVector2Make(direction.x * 1.0f, direction.y * 1.0f));
}

@end