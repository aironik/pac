//
//  Shader.fsh
//  Pacman
//
//  Created by Oleg Lobachev on 01/23/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
