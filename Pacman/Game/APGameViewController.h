//
//  APGameViewController.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 23.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "APGameResult.h"
#import "APUserInputDelegate.h"


@interface APGameViewController : GLKViewController <APGameResult, APUserInputDelegate>

- (void)finishWithWin;
- (void)finishWithLose;
- (void)addScore:(NSInteger)score;

@end
