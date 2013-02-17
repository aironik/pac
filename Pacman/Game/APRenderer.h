//
//  APRenderer.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


@class APGameViewController;


@interface APRenderer : NSObject

@property (nonatomic, weak) APGameViewController *gameViewController;

- (void)update:(NSTimeInterval)timeInterval;
- (void)render;

- (void)win;
- (void)lose;
- (void)scoreDidIncremented:(NSInteger)score;

- (void)setUserInput:(GLKVector2)direction;

@end
