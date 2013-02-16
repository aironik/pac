//
//  Program.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 13.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//


#ifndef __Program_H_
#define __Program_H_

#include <memory>


namespace ProgramGl {

class Program {
public:
    typedef std::shared_ptr<Program> SharedPtr;
    typedef std::weak_ptr<Program> WeakPtr;

public:
    static SharedPtr createDefaultProgram();
    static SharedPtr sharedDefaultProgram();

    Program(const GLchar *vertexShaderStr, const GLchar *fragmentShaderStr);
    ~Program();

    void loadIdentity();
    void setProjectionMatrix(const GLKMatrix4 &projectionMatrix);
    void setModelViewMatrix(const GLKMatrix4 &modelViewMatrix);
    void setDiffuseColor(const GLKVector4 &diffuseColor);
    void setLightPosition(const GLKVector3 &lightPosition);

    void apply();

    void validateProgram();

private:
    Program() {}
    GLuint compileShader(const GLchar *shaderStr, GLenum type);
    void deleteShader(GLuint shader);
    void linkProgram();

    void updateModelViewProjectionMatrix();

private:
    enum {
        uniformModelViewProjectionMatrix = 0,
        uniformNormalMatrix,
        uniformDiffuseColor,
        uniformLightPosition,

        uniformCount
    };

private:
    GLuint program;
    GLint uniformLocations[uniformCount];
    bool uniformDataUpdated[uniformCount];


    GLKMatrix4 modelViewProjectionMatrix; ///< projectionMatrix * modelViewMatrix
    GLKMatrix4 projectionMatrix;
    GLKMatrix4 modelViewMatrix;
    GLKMatrix3 normalMatrix;

    GLKVector3 lightPosition;
    GLKVector4 diffuseColor;
};

} // ProgramGl

#endif //__Program_H_
