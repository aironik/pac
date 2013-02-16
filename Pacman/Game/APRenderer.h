//
//  APRenderer.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//



@interface APRenderer : NSObject

- (void)renderCube;
- (void)renderRibbon;
- (void)renderRomb;
- (void)renderSquare;
- (void)renderSphere;

- (void)update:(NSTimeInterval)timeInterval;
- (void)render;

- (void)setDirection:(GLKVector2)direction;

@end
