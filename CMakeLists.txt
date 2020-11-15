cmake_minimum_required(VERSION 3.16)
project(FragmentExercises)

set(CMAKE_CXX_STANDARD 14)
add_executable(FragmentExercises
        Dependencies/glad/src/glad.c
        src/main.cpp
        src/Backend/GraphicsLibrary.h
        src/Backend/GraphicsLibrary.cpp
        src/Backend/ObjectGL.cpp
        src/Backend/ObjectGL.h
        src/Backend/Shader.cpp
        src/Backend/Shader.h
        src/Backend/Texture2D.cpp
        src/Backend/Texture2D.h
        src/FileManagers/Bitmap/Bitmap.cpp
        src/FileManagers/Bitmap/Bitmap.h
        src/FileManagers/FileLoader.cpp
        src/FileManagers/FileLoader.h
        src/IMGui/imconfig.h
        src/IMGui/imgui_demo.cpp
        src/IMGui/imgui_draw.cpp
        src/IMGui/imgui_impl_glfw.cpp
        src/IMGui/imgui_impl_glfw.h
        src/IMGui/imgui_impl_opengl3.cpp
        src/IMGui/imgui_impl_opengl3.h
        src/IMGui/imgui_internal.h
        src/IMGui/imgui_widgets.cpp
        src/IMGui/imgui.cpp
        src/IMGui/imgui.h
        src/IMGui/imstb_rectpack.h
        src/IMGui/imstb_textedit.h
        src/IMGui/imstb_truetype.h src/Callbacks.h)
include_directories(Dependencies/glad/include)
include_directories(Dependencies/glm)
find_package(OpenGL REQUIRED)

if (WIN32)
    include_directories(Dependencies/glfw-WIN_64/include)
    add_subdirectory(Dependencies/glfw-WIN_64)
    target_link_libraries(FragmentExercises glfw gdi32 ${OPENGL_LIBRARIES} ${GLFW_LIBRARIES})
endif ()

if (UNIX)

    include_directories(Dependencies/glfw/include)
    add_subdirectory(Dependencies/glfw)
    target_link_libraries(FragmentExercises glfw ${OPENGL_LIBRARIES} ${GLFW_LIBRARIES})
endif ()



