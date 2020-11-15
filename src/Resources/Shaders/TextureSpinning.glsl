#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float t;

//Return 1 if v2 is left from v1 and -1 if v2 is right from v1
int angleOrientation(vec2 v1, vec2 v2)
{
    return (v1.x * v2.y - v1.y * v2.x) > 0 ? 1 : -1;
}
void main()
{
    vec2 vector = vec2(cos(t * 3.14 * 2), sin(t*3.14 * 2));
    int orientation = angleOrientation(vector, TexCoord - vec2(0.5, 0.5));
    if (orientation == 1){
        FragColor = texture(texture1, TexCoord);
    } else {
        FragColor = texture(texture2, TexCoord);

    }
}