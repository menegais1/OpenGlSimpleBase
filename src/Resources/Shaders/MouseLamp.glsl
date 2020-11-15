#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform vec2 mousePosition;
uniform float mouseThreshold;
float grayscale(vec4 color){
    return color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
}

//#define GRAYSCALE

void main()
{
    if (length(mousePosition - gl_FragCoord.xy) < mouseThreshold){
        FragColor = texture(texture1, TexCoord) - (length(mousePosition - gl_FragCoord.xy) / mouseThreshold);
    }
    else {
        #ifdef GRAYSCALE
        FragColor = vec4(grayscale(texture(texture1, TexCoord)));
        #else
        FragColor = vec4(0, 0, 0, 1);
        #endif
    }
}
