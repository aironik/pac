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
#import "Romb.h"
#import "Sphere.h"
#import "Square.h"


@interface APRenderer () {
    Surfaces::Cube *_cube;
    Surfaces::Romb *_romb;
    Surfaces::Sphere *_sphere;
    Surfaces::Square *_square;
}


@end


#pragma mark - Implementation

@implementation APRenderer

- (id)init
{
    if (self = [super init]) {
        [self setupSurfaces];
    }
    return self;
}

- (void)dealloc
{
    [self destroySurfaces];
}

- (void)setupSurfaces
{
    [self setupCube];
    [self setupRomb];
    [self setupSquare];
    [self setupSphere];
}

- (void)destroySurfaces
{
    [self destroySphere];
    [self destroySquare];
    [self destroyRomb];
    [self destroyCube];
}

- (void)setupSphere
{
    _cube = new Surfaces::Cube();
    _cube->init();
}

- (void)destroySphere
{
    _cube->destroy();
    delete _cube;
    _cube = 0;
}

- (void)setupCube
{
    _sphere = new Surfaces::Sphere();
    _sphere->init();
}

- (void)destroyCube
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
    _sphere->bind();
    _sphere->draw();
    _sphere->unbind();
}

- (void)renderCube
{
    _cube->bind();
    _cube->draw();
    _cube->unbind();
}

- (void)renderSquare
{
    _square->bind();
    _square->draw();
    _square->unbind();
}

- (void)renderRomb
{
    _romb->bind();
    _romb->draw();
    _romb->unbind();

}

@end