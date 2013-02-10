//
//  APUserCommandViewController.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "APUserCommand.h"
#import "APUserCommandDelegate.h"


@interface APUserCommandViewController : UIViewController<APUserCommand>

@property (nonatomic, weak) NSObject<APUserCommandDelegate> *delegate;

@end
