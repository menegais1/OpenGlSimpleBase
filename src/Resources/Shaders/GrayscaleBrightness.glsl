#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float t;
uniform float brightness;

void main()
{

    vec4 color = texture(texture1, TexCoord);
    float grayscale =  color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
    FragColor = vec4(grayscale, grayscale, grayscale, 1) + brightness;
}