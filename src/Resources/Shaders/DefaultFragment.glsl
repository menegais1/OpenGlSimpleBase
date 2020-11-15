#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform vec2 mousePosition;
uniform vec2 textureSize;
uniform vec2 scaleSize;
uniform float mouseThreshold;


void main()
{

    if (length(mousePosition - gl_FragCoord.xy) < mouseThreshold){
        vec2 newUV = (TexCoord * scaleSize) / textureSize;
        FragColor = texture(texture1, newUV);
    }
    else {
        FragColor = vec4(texture(texture1, TexCoord));
    }

}
