//
//  APGameViewController.m
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 23.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "APGameViewController.h"

#import "APRenderer.h"


@interface APGameViewController ()

@property (nonatomic, assign) BOOL win;
@property (nonatomic, assign) NSUInteger score;

@property (nonatomic, strong) EAGLContext *context;

@property (nonatomic, strong) APRenderer *renderer;

@end


@implementation APGameViewController

@synthesize win = _win;

#pragma mark - APGameResult Implementation

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

- (void)dealloc {
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];

    self.renderer = [[APRenderer alloc] init];

    glEnable(GL_DEPTH_TEST);
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.context];

    self.renderer = nil;
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update {
    [self.renderer update:self.timeSinceLastUpdate];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    [self.renderer render];
//    [self.renderer renderSphere];
}


#pragma mark - APUserCommandDelegate protocol implementation

- (void)userCommand:(NSObject<APUserCommand> *)userCommand didChangeValue:(GLKVector2)value {

}

@end
