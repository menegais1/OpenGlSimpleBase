#version 460 core

out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float t;
uniform float brightness;
uniform vec2 pixelSize;

#define KERNEL_SIZE 5
#define KERNEL_SIZE_LINEAR 25
float grayscale(vec4 color){
    return color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
}

vec4 convolution(vec4 kernel[KERNEL_SIZE_LINEAR], vec4 pixels[KERNEL_SIZE_LINEAR]){
    vec4 sum = vec4(0);
    for (int i =0; i< KERNEL_SIZE_LINEAR;i++){
        sum += kernel[i] * pixels[i];
    }
    return sum;
}

void main()
{
    vec4 matrix[KERNEL_SIZE_LINEAR];
    vec4 kernel[KERNEL_SIZE_LINEAR];
    int kernelSizeX = int(KERNEL_SIZE / 2.0);
    int kernelSizeY = int(KERNEL_SIZE / 2.0);
    vec2 minUV = TexCoord - pixelSize * vec2(kernelSizeX, kernelSizeY);
    vec2 maxUV = TexCoord + pixelSize * vec2(kernelSizeX, kernelSizeY);
    int i = 0;
    for (float x = minUV.x;x < maxUV.x + 0.001;x+=pixelSize.x){
        for (float y = minUV.y; y <= maxUV.y + 0.001;y+=pixelSize.y){
            matrix[i] = texture(texture1, vec2(x, y));
            kernel[i] = vec4(1.0/(KERNEL_SIZE_LINEAR));
            i++;
        }
    }

    vec4 blurColor = convolution(kernel, matrix);
    if (TexCoord.x < 0.5){
        FragColor = blurColor;
    } else {
        FragColor = texture(texture1, TexCoord);
    }
}
