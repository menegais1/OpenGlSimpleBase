#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float t;

void main()
{
    if ((int((TexCoord * 1000).x / 100)) % 2 == 0){
        FragColor = texture(texture1, TexCoord);
    } else {
        FragColor = texture(texture2, TexCoord);
    }
}