//
//  APUserCommandViewController.m
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "APUserCommandViewController.h"


@interface APUserCommandViewController ()

@property (nonatomic, assign) GLKVector2 value;

@end

#pragma mark - Implementation

@implementation APUserCommandViewController

- (IBAction)left:(id)sender {
    self.value = GLKVector2Make(-1.0f, 0.0f);
}

- (IBAction)right:(id)sender {
    self.value = GLKVector2Make(1.0f, 0.0f);
}

- (IBAction)top:(id)sender {
    self.value = GLKVector2Make(0.0f, -1.0f);
}

- (IBAction)bottom:(id)sender {
    self.value = GLKVector2Make(0.0f, 1.0f);
}

- (IBAction)stop:(id)sender {
    self.value = GLKVector2Make(0.0f, 0.0f);
}

- (void)setValue:(GLKVector2)value {
    if (!GLKVector2AllEqualToVector2(_value, value)) {
        _value = value;
        [self.delegate userCommand:self didChangeValue:self.value];
    }
}

@end
