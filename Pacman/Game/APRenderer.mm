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

@interface APRenderer () {
    Entities::RolyPolyEntity::SharedPtr _rolyPoly;

    Surfaces::Cube *_cube;
    Surfaces::Ribbon *_ribbon;
    Surfaces::Romb *_romb;
    Surfaces::Sphere *_sphere;
    Surfaces::Square *_square;
}


@end


#pragma mark - Implementation

@implementation APRenderer

- (id)init {
    if (self = [super init]) {
        [self setupSurfaces];

        [self setupEntities];
    }
    return self;
}

- (void)dealloc {
    [self destroyEntities];

    [self destroySurfaces];
}

- (void)setupSurfaces
{
    [self setupCube];
    [self setupRibbon];
    [self setupRomb];
    [self setupSquare];
    [self setupSphere];
}

- (void)destroySurfaces
{
    [self destroySphere];
    [self destroySquare];
    [self destroyRomb];
    [self destroyRibbon];
    [self destroyCube];
}

- (void)setupCube
{
    _cube = new Surfaces::Cube();
    _cube->init();
}

- (void)destroyCube
{
    _cube->destroy();
    delete _cube;
    _cube = 0;
}

- (void)renderCube
{
    _cube->draw();
}

- (void)setupSphere
{
    _sphere = new Surfaces::Sphere();
    _sphere->init();
}

- (void)destroySphere
{
    _sphere->destroy();
    delete _sphere;
    _sphere = 0;
}

- (void)setupSquare
{
    _square = new Surfaces::Square();
    _square->init();
}

- (void)destroySquare
{
    _square->destroy();
    delete _square;
    _square = 0;
}

- (void)setupRibbon
{
    _ribbon = new Surfaces::Ribbon();
    _ribbon->init();
}

- (void)destroyRibbon
{
    _ribbon->destroy();
    delete _ribbon;
    _ribbon = 0;
}

- (void)setupRomb
{
    _romb = new Surfaces::Romb();
    _romb->init();
}

- (void)destroyRomb
{
    _romb->destroy();
    delete _romb;
    _romb = 0;
}

- (void)renderSphere
{
    _sphere->draw();
}

- (void)renderSquare
{
    _square->draw();
}

- (void)renderRomb
{
    _romb->draw();
}

- (void)renderRibbon
{
    _ribbon->draw();
}



- (void)setupEntities {
    _rolyPoly = Entities::RolyPolyEntity::SharedPtr::make_shared();
}

- (void)destroyEntities {
    _rolyPoly.reset();
}

- (void)update:(NSTimeInterval)timeInterval {
    _cube->update(timeInterval);
    ((Surfaces::Surface *)_ribbon)->update(timeInterval);
    _romb->update(timeInterval);
    _sphere->update(timeInterval);
    _square->update(timeInterval);

    _rolyPoly->update(timeInterval);
}

- (void)render {
    _rolyPoly->draw();
}

@end