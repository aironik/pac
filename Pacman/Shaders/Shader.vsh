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
    vec4 vertPosition = modelViewProjectionMatrix * position;

    vec3 lightPositionRel = vertPosition.xyz - lightPosition;

    float nDotVP = max(0.0, dot(normalize(vec3(-lightPositionRel.x, -lightPositionRel.y, lightPositionRel.z)), normalize(normal)));
    colorVarying = diffuseColor * nDotVP;
    
    gl_Position = vertPosition;
}
