//
//  Program.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 13.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#include "Program.h"

#include <string.h>


namespace ProgramGl {

Program::SharedPtr Program::createDefaultProgram() {
    const GLchar *vertexShaderStr = NULL;
    const GLchar *fragmentShaderStr = NULL;

    NSString *vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    NSString *fragmentShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    vertexShaderStr = (GLchar *)[[NSString stringWithContentsOfFile:vertShaderPathname encoding:NSUTF8StringEncoding error:nil] UTF8String];
    fragmentShaderStr = (GLchar *)[[NSString stringWithContentsOfFile:fragmentShaderPathname encoding:NSUTF8StringEncoding error:nil] UTF8String];
    return SharedPtr::make_shared(vertexShaderStr, fragmentShaderStr);
}

Program::SharedPtr Program::sharedDefaultProgram() {
    static WeakPtr sharedInstance;
    SharedPtr result = sharedInstance.lock();
    if (!result) {
        result = createDefaultProgram();
        sharedInstance = result;
    }
    return result;
}


Program::Program(const GLchar *vertexShaderStr, const GLchar *fragmentShaderStr)
        : program(0)
        , modelViewProjectionMatrix(GLKMatrix4Identity)
        , projectionMatrix(GLKMatrix4Identity)
        , modelViewMatrix(GLKMatrix4Identity)
        , normalMatrix(GLKMatrix3Identity)
        , lightPosition(GLKVector3Make(0.0f, 0.0f, 0.0f))
        , diffuseColor(GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f))
{
    for (size_t i = 0; i < uniformCount; ++i) {
        uniformDataUpdated[i] = true;
    }

    GLuint vertShader = 0;
    GLuint fragShader = 0;

    try {
        program = glCreateProgram();

        vertShader = compileShader(vertexShaderStr, GL_VERTEX_SHADER);
        fragShader = compileShader(fragmentShaderStr, GL_FRAGMENT_SHADER);

        // Bind attribute locations.
        // This needs to be done prior to linking.
        glBindAttribLocation(program, GLKVertexAttribPosition, "position");
        glBindAttribLocation(program, GLKVertexAttribNormal, "normal");

        linkProgram();

        // Get uniform locations.
        uniformLocations[uniformModelViewProjectionMatrix] = glGetUniformLocation(program, "modelViewProjectionMatrix");
        uniformLocations[uniformNormalMatrix] = glGetUniformLocation(program, "normalMatrix");
        uniformLocations[uniformDiffuseColor] = glGetUniformLocation(program, "diffuseColor");
        uniformLocations[uniformLightPosition] = glGetUniformLocation(program, "lightPosition");

        // Release vertex and fragment shaders.
        deleteShader(vertShader);
        deleteShader(fragShader);

//        validateProgram();

        loadIdentity();
    }
    catch (char *e) {
        deleteShader(vertShader);
        deleteShader(fragShader);
        glDeleteProgram(program);
        throw;
    }
}

Program::~Program() {
    glDeleteProgram(program);
}

GLuint Program::compileShader(const GLchar *shaderStr, GLenum type) {
    GLuint result = glCreateShader(type);
    glShaderSource(result, 1, &shaderStr, NULL);
    glCompileShader(result);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(result, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc((size_t)logLength);
        glGetShaderInfoLog(result, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif

    GLint status;
    glGetShaderiv(result, GL_COMPILE_STATUS, &status);
    if (!status) {
        deleteShader(result);
        // TODO: handle error
        throw "error compile shader";
    }
    glAttachShader(program, result);
    return result;
}

void Program::deleteShader(GLuint shader) {
    if (shader) {
        glDetachShader(program, shader);
        glDeleteShader(shader);
    }
}

void Program::linkProgram() {
    glLinkProgram(program);

    GLint status;
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    if (!status) {
        glDeleteProgram(program);
        // TODO: handle error
        throw "error link program";
    }
}

void Program::validateProgram() {
    GLint status;
    GLint logLength;
    
    glValidateProgram(program);
    glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc((size_t)logLength);
        glGetProgramInfoLog(program, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(program, GL_VALIDATE_STATUS, &status);
    if (!status) {
        // TODO: handle error
        throw "error validate shader";
    }
}

void Program::loadIdentity() {
    // TODO: use other closed algorithm calculate projection matrix
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGSize size = window.bounds.size;
    float aspect = fabsf(size.height / size.width);
    GLKMatrix4 newProjectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 10.0f);
    setProjectionMatrix(newProjectionMatrix);

    setModelViewMatrix(GLKMatrix4Identity);

    setLightPosition(GLKVector3Make(3.0f, -1.0f, -5.0f));
    setDiffuseColor(GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f));
}

void Program::updateModelViewProjectionMatrix() {
    normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    uniformDataUpdated[uniformModelViewProjectionMatrix] = true;
}

void Program::setProjectionMatrix(GLKMatrix4 const &aProjectionMatrix) {
    this->projectionMatrix = aProjectionMatrix;
    updateModelViewProjectionMatrix();
}

void Program::setModelViewMatrix(const GLKMatrix4 &aModelViewMatrix) {
    this->modelViewMatrix = aModelViewMatrix;
    updateModelViewProjectionMatrix();
}

void Program::setDiffuseColor(GLKVector4 const &aDiffuseColor) {
    diffuseColor = aDiffuseColor;
    uniformDataUpdated[uniformDiffuseColor] = true;
}

void Program::setLightPosition(GLKVector3 const &aLightPosition) {
    this->lightPosition = aLightPosition;
    uniformDataUpdated[uniformLightPosition] = true;
}

void Program::apply() {
    glUseProgram(program);

    if (uniformDataUpdated[uniformModelViewProjectionMatrix]) {
        glUniformMatrix4fv(uniformLocations[uniformModelViewProjectionMatrix], 1, GL_FALSE, modelViewProjectionMatrix.m);
        glUniformMatrix3fv(uniformLocations[uniformNormalMatrix], 1, GL_FALSE, normalMatrix.m);
        uniformDataUpdated[uniformModelViewProjectionMatrix] = false;
    }
    if (uniformDataUpdated[uniformDiffuseColor]) {
        glUniform4fv(uniformLocations[uniformDiffuseColor], 1, diffuseColor.v);
        uniformDataUpdated[uniformDiffuseColor] = false;
    }
    if (uniformDataUpdated[uniformLightPosition]) {
        glUniform3fv(uniformLocations[uniformLightPosition], 1, lightPosition.v);
        uniformDataUpdated[uniformLightPosition] = false;
    }
}

} // ProgramGl
