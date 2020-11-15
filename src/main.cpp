#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "Backend/GraphicsLibrary.h"
#include "Backend/Shader.h"
#include "FileManagers/FileLoader.h"
#include "FileManagers/Bitmap/Bitmap.h"
#include "Backend/Texture2D.h"
#include "Backend/ObjectGL.h"
#include <glm/vec3.hpp>
#include "Callbacks.h"
#include "IMGui/imgui.h"

Shader defaultShader;
Texture2D texture1;
Texture2D texture2;
unsigned int VAO;
float t = 0;
float mouseThreshold = 0;
float textureScale = 1;
float brightness = 0;
glm::vec2 mousePosition;
int width = 500, height = 500;

void init() {

    unsigned int vertex = Shader::createVertexShader(FileLoader::getPath("Resources/Shaders/DefaultVertex.glsl"));
    unsigned int fragment = Shader::createFragmentShader(FileLoader::getPath("Resources/Shaders/DefaultFragment.glsl"));
    defaultShader = Shader(vertex, fragment);
    Bitmap *bmp1 = new Bitmap(FileLoader::getPath("Resources/Textures/dog.bmp"));
    Bitmap *bmp2 = new Bitmap(FileLoader::getPath("Resources/Textures/awesomeface.bmp"));
    texture1 = Texture2D(GL_RGBA, GL_RGBA, GL_FLOAT, bmp1->originalBitmapArray, bmp1->width, bmp1->height);
    texture2 = Texture2D(GL_RGBA, GL_RGBA, GL_FLOAT, bmp2->originalBitmapArray, bmp2->width, bmp2->height);


    float vertices[] = {
            // positions          // colors           // texture coords
            0.5f, 0.5f, 0.0f, 1.0f, 0.0f, 0.0f, 1.0f, 1.0f, // top right
            0.5f, -0.5f, 0.0f, 0.0f, 1.0f, 0.0f, 1.0f, 0.0f, // bottom right
            -0.5f, -0.5f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, // bottom left
            -0.5f, 0.5f, 0.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f  // top left
    };
    unsigned int indices[] = {
            0, 1, 3, // first triangle
            1, 2, 3  // second triangle
    };
    unsigned int VBO, EBO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

    // position attribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void *) 0);
    glEnableVertexAttribArray(0);
    // color attribute
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void *) (3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    // texture coord attribute
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void *) (6 * sizeof(float)));
    glEnableVertexAttribArray(2);
}

void mouseCursor(double x, double y) {
    mousePosition.x = x;
    mousePosition.y = width - y;
}

void draw() {

    ImGui::Begin("Debug", nullptr);
    ImGui::SliderFloat("Parameter T", &t, 0, 1);
    ImGui::SliderFloat("Parameter brightness", &brightness, -1, 1);
    ImGui::SliderFloat("Mouse Threshold", &mouseThreshold, 0, 100);
    ImGui::SliderFloat("Texture Scale", &textureScale, 0.1, 32);
    ImGui::LabelText("Mouse Position x", std::to_string(mousePosition.x).c_str());
    ImGui::LabelText("Mouse Position y", std::to_string(mousePosition.y).c_str());
    ImGui::End();
    defaultShader.activateShader();
    defaultShader.setUniform("t", t);
    defaultShader.setUniform("pixelSize", glm::vec2(1.0 / texture1.width, 1.0 / texture1.height));
    defaultShader.setUniform("textureSize", glm::vec2( texture1.width,texture1.height));
    defaultShader.setUniform("scaleSize", glm::vec2( texture1.width * textureScale,texture1.height * textureScale));
    defaultShader.setUniform("brightness", brightness);
    defaultShader.setUniform("mousePosition", mousePosition);
    defaultShader.setUniform("mouseThreshold", mouseThreshold);
    defaultShader.setUniform("texture1", 0);
    defaultShader.setUniform("texture2", 1);
    texture1.activateTexture(0);
    texture2.activateTexture(1);
    glBindVertexArray(VAO);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
}

int main(void) {
    auto window = GraphicsLibrary::init(width, height, "Backend");
    init();
    while (!glfwWindowShouldClose(window)) {

        GraphicsLibrary::render(window);

    }

    glfwTerminate();
    return 0;
}
