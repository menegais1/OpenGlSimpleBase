#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

void main()
{

    float circleSize = 0.5;
    float numCircles = 20;
    float dist = length(TexCoord - vec2(0.5, 0.5));
    if (dist > circleSize){
        FragColor = vec4(0, 0, 1, 1);
        return;
    }
    if (dist <0.1) FragColor = vec4(1, 0, 0, 1);
    else if (sin(dist * numCircles * 3.14) > 0)  FragColor = vec4(1, 1, 1, 1);
    else FragColor = vec4(0, 0, 0, 1);

}