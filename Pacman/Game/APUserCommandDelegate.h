//
//  APUserCommandDelegate.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


@protocol APUserCommand;
@class APUserCommandValue;


@protocol APUserCommandDelegate<NSObject>

@required

- (void)userCommand:(NSObject<APUserCommand> *)userCommand didChangeValue:(GLKVector2)value;

@end
