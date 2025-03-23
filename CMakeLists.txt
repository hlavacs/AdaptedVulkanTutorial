cmake_minimum_required (VERSION 3.5.0)
project (
  "28_model_loading"
  VERSION 2.0.0
  DESCRIPTION "A game engine using the Vulkan API"
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
	#add_compile_options(/EHsc /DEBUG /Zi /Istb) #for assimp
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
	add_compile_options(-Wno-nullability-completeness)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	add_compile_options(-Wno-nullability-completeness)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	add_compile_options(-Wno-nullability-completeness)
endif()

find_package(Vulkan REQUIRED)
message("Vulkan_INCLUDE_DIR: " ${Vulkan_INCLUDE_DIR})
message("Vulkan_LIBRARY: " ${Vulkan_LIBRARY})

set(VULKAN $ENV{VULKAN_SDK}) #set to Vulkan SDK
message("VULKAN SDK: " ${VULKAN})
list(APPEND CMAKE_PREFIX_PATH ${VULKAN})
find_package(SDL2 REQUIRED)

message("Compiler: " ${CMAKE_CXX_COMPILER_ID})

#--------------------------------- Fetch ImGui ---------------------------------#
include(FetchContent) # enable Fetch Content

FetchContent_Declare(imgui
                     GIT_REPOSITORY https://github.com/ocornut/imgui.git 
                     GIT_TAG master)

FetchContent_MakeAvailable(Imgui)
add_library(imgui)
target_include_directories(imgui SYSTEM PUBLIC ${imgui_SOURCE_DIR} ${imgui_SOURCE_DIR}/backends)
target_include_directories(imgui SYSTEM PRIVATE ${Vulkan_INCLUDE_DIRS})
target_compile_definitions(imgui PRIVATE IMGUI_IMPL_VULKAN_NO_PROTOTYPES)
target_link_libraries(imgui SDL2::SDL2)
target_sources(imgui PRIVATE
	${imgui_SOURCE_DIR}/imgui.cpp
	${imgui_SOURCE_DIR}/imgui_draw.cpp
	${imgui_SOURCE_DIR}/imgui_widgets.cpp
	${imgui_SOURCE_DIR}/imgui_tables.cpp
	${imgui_SOURCE_DIR}/imgui_demo.cpp
	${imgui_SOURCE_DIR}/backends/imgui_impl_sdl2.cpp
	${imgui_SOURCE_DIR}/backends/imgui_impl_vulkan.cpp
)

FetchContent_Declare(vkbootstrap
                     GIT_REPOSITORY https://github.com/charles-lunarg/vk-bootstrap.git 
                     GIT_TAG main)
FetchContent_MakeAvailable(vkbootstrap)


set(TARGET 28_model_loading)

set(SOURCE
  28_model_loading.cpp
)

set(HEADERS )

add_executable(${TARGET} ${SOURCE} ${HEADERS})

target_include_directories(${TARGET} PRIVATE stb)
target_include_directories(${TARGET} PRIVATE ${Vulkan_INCLUDE_DIR}/volk)
target_include_directories(${TARGET} PRIVATE ${Vulkan_INCLUDE_DIR}/vma)
target_include_directories(${TARGET} SYSTEM PRIVATE ${Vulkan_INCLUDE_DIRS})
target_link_libraries(${TARGET} PRIVATE SDL2::SDL2 vk-bootstrap::vk-bootstrap imgui)
