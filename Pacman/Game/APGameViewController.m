//
//  APGameViewController.m
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 23.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "APGameViewController.h"

#import "APRenderer.h"


@interface APGameViewController () {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    float _rotation;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    GLKTextureInfo *_textureInfo;
}

@property (nonatomic, assign) BOOL win;
@property (nonatomic, assign) NSUInteger score;

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) GLKBaseEffect *effect;

@property (nonatomic, strong) APRenderer *renderer;

@end


@implementation APGameViewController

@synthesize win = _win;

#pragma mark - APGameResult Implementation

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    self.renderer = [[APRenderer alloc] init];
}

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
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

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];

    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.useConstantColor = GL_FALSE;
    self.effect.colorMaterialEnabled = GL_TRUE;
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    glEnable(GL_DEPTH_TEST);
    
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//    glEnableVertexAttribArray(GLKVertexAttribNormal);
//    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));

    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"texture" ofType:@"png"];
    _textureInfo = [GLKTextureLoader textureWithContentsOfFile:fileName options:nil error:NULL];
    self.effect.texture2d0.enabled = GL_TRUE;
    self.effect.texture2d0.name = _textureInfo.name;
    self.effect.texture2d0.target = GLKTextureTarget2D;
    self.effect.textureOrder = @[self.effect.texture2d0];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];

    self.effect = nil;
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
    // Compute the model view matrix for the object rendered with ES2
    modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    _rotation += self.timeSinceLastUpdate * 0.5f;

    [self.renderer update:self.timeSinceLastUpdate];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    // Render the object with GLKit
    [self.effect prepareToDraw];
    
    [self.renderer renderSphere];
//    [self.renderer renderRibbon];
//    [self.renderer renderCube];
//    [self.renderer renderSquare];
}


#pragma mark - APUserCommandDelegate protocol implementation

- (void)userCommand:(NSObject<APUserCommand> *)userCommand didChangeValue:(GLKVector2)value {

}

@end
