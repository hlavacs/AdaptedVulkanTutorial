cmake_minimum_required (VERSION 3.5.0)
project (
  "28_model_loading"
  VERSION 2.0.0
  DESCRIPTION "A game engine using the Vulkan API"
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  	add_compile_options(/D IMGUI_IMPL_VULKAN_NO_PROTOTYPES)
	add_compile_options(/D_CRT_SECURE_NO_WARNINGS) #for assimp
	add_compile_options(/EHsc /std:c++20 /DEBUG /Zi /Istb) #for assimp
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	add_compile_options(-D IMGUI_IMPL_VULKAN_NO_PROTOTYPES)
	add_compile_options(-Wno-nullability-completeness)
	add_compile_options(-D_CRT_SECURE_NO_WARNINGS) #for assimp
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	add_compile_options(-D IMGUI_IMPL_VULKAN_NO_PROTOTYPES)
	add_compile_options(-Wno-nullability-completeness)
	add_compile_options(-D_CRT_SECURE_NO_WARNINGS) #for assimp
endif()

if (WIN32)
	set(SDKINCLUDE Include)
	set(SDKLIB Lib)
	set(SDL2LIB SDL2.lib)
  	set(VOLKLIB volk.lib)
elseif (APPLE)
	set(SDKINCLUDE include)
    set(SDKLIB lib)
	set(SDL2LIB libSDL2-2.0.dylib)
  	set(VOLKLIB libvolk.a)
elseif (UNIX)
	set(SDKINCLUDE include)
	set(SDKLIB lib)
	set(SDL2LIB libSDL2-2.0.a)
  	set(VOLKLIB libvolk.a)
endif()

find_package(Vulkan REQUIRED)
set(VULKAN $ENV{VULKAN_SDK}) #set to Vulkan SDK
message("VULKAN SDK: " ${VULKAN})
message("SDKINCLUDE: " ${SDKINCLUDE})
message("SDKLIB: " ${SDKLIB})

set(BUILD ${PROJECT_SOURCE_DIR}/build)  # engine include directory
set(INCLUDE ${PROJECT_SOURCE_DIR}/include)  # engine include directory

#--------------------------------- Fetch ImGui ---------------------------------#
include(FetchContent) # enable Fetch Content

FetchContent_Declare(imgui
                     GIT_REPOSITORY https://github.com/ocornut/imgui.git 
                     GIT_TAG master)
FetchContent_MakeAvailable(Imgui)
set(IMGUI ${imgui_SOURCE_DIR})

FetchContent_Declare(vkbootstrap
                     GIT_REPOSITORY https://github.com/charles-lunarg/vk-bootstrap.git 
                     GIT_TAG main)
FetchContent_MakeAvailable(vkbootstrap)


set(TARGET 28_model_loading)

set(SOURCE
  ${IMGUI}/imgui.cpp
  ${IMGUI}/imgui_demo.cpp
  ${IMGUI}/imgui_draw.cpp
  ${IMGUI}/backends/imgui_impl_sdl2.cpp
  ${IMGUI}/backends/imgui_impl_vulkan.cpp
  ${IMGUI}/imgui_tables.cpp
  ${IMGUI}/imgui_widgets.cpp
  28_model_loading.cpp
  )

set(HEADERS )

add_executable(${TARGET} ${SOURCE} ${HEADERS})

target_include_directories(${TARGET} PUBLIC stb)
target_include_directories(${TARGET} PUBLIC ${VULKAN}/${SDKINCLUDE})
target_include_directories(${TARGET} PUBLIC ${VULKAN}/${SDKINCLUDE}/SDL2)
target_include_directories(${TARGET} PUBLIC ${VULKAN}/${SDKINCLUDE}/volk)
target_include_directories(${TARGET} PUBLIC ${VULKAN}/${SDKINCLUDE}/glm)
target_include_directories(${TARGET} PUBLIC ${VULKAN}/${SDKINCLUDE}/vma)
target_include_directories(${TARGET} PUBLIC ${IMGUI})
target_include_directories(${TARGET} PUBLIC ${IMGUI}/backends)
target_include_directories(${TARGET} PUBLIC ${vkbootstrap_SOURCE_DIR}/src)

target_link_libraries (${TARGET} PUBLIC ${VULKAN}/${SDKLIB}/${SDL2LIB})
target_link_libraries (${TARGET} PUBLIC ${VULKAN}/${SDKLIB}/${VOLKLIB})
target_link_libraries (${TARGET} PUBLIC ${vkbootstrap_BINARY_DIR}/vk-bootstrap.lib)

