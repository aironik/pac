//
//  APMainViewController.m
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 23.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "APMainViewController.h"
#import "APGameViewController.h"


@interface APMainViewController ()

@property (nonatomic, strong) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@end


#pragma mark - Implementation

@implementation APMainViewController

- (IBAction)close:(UIStoryboardSegue *)segue
{
    APGameViewController *sourceViewController = (APGameViewController *)segue.sourceViewController;
    NSAssert([sourceViewController isKindOfClass:[APGameViewController class]], @"Unknown source segue class.");

    [self updateGameResult:sourceViewController];
}

- (void)updateGameResult:(id<APGameResult>)gameResult
{
    NSString *resultString = nil;
    NSString *scoreFormat = NSLocalizedString(@"Scory: %d", @"Строка на главном эеране для отображения очков.");
    NSString *scoreString = [NSString stringWithFormat:scoreFormat, [gameResult score]];
    if ([gameResult win]) {
        resultString = NSLocalizedString(@"Win!!!", @"Строка на главном экране, которая появляется при победе.");
    } else {
        resultString = NSLocalizedString(@"Fail 👻", @"Строка на главном экране, которая появляется при победе.");
    }
    self.resultLabel.text = resultString;
    self.scoreLabel.text = scoreString;
}



@end