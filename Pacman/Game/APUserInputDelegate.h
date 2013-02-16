//
//  APUserInputDelegate.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


@protocol APUserInput;
@class APUserCommandValue;


@protocol APUserInputDelegate<NSObject>

@required

- (void)userInput:(NSObject<APUserInput> *)userCommand didChangeValue:(GLKVector2)value;

@end
