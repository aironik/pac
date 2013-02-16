//
//  Shader.vsh
//  Pacman
//
//  Created by Oleg Lobachev on 01/23/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;

varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec3 lightPosition;
uniform vec4 diffuseColor;

void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
//    vec3 eyeNormal = normalize(normalMatrix * position);

//    lightPosition = vec3(0.0, 0.0, 1.0);
    vec3 lightPosition1 = vec3(1.0, 1.0, 1.0);
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition1)));
    
    colorVarying = diffuseColor * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
}
