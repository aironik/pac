//
//  APUserInputViewController.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "APUserInput.h"
#import "APUserInputDelegate.h"


@interface APUserInputViewController : UIViewController<APUserInput>

@property (nonatomic, weak) IBOutlet NSObject<APUserInputDelegate> *delegate;

@end
