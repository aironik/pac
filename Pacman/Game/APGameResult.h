//
//  APGameResult.h
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 23.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

@protocol APGameResult<NSObject>
@required

- (BOOL)win;
- (NSUInteger)score;

@end