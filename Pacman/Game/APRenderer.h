//
//  APRenderer.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//



@interface APRenderer : NSObject

- (void)update:(NSTimeInterval)timeInterval;
- (void)render;

- (void)win;
- (void)lose;

- (void)setUserInput:(GLKVector2)direction;

@end
