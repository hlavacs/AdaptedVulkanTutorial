cmake_minimum_required (VERSION 3.5.0)
project (
  "28_model_loading"
  VERSION 2.0.0
  DESCRIPTION "A game engine using the Vulkan API"
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

message("Compiler: " ${CMAKE_CXX_COMPILER_ID})

add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
if (NOT CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
	add_compile_options(-Wno-nullability-completeness)
endif()

#--------------------------------- Find VulkanSDK ---------------------------------#
find_package(Vulkan REQUIRED)
message("Vulkan_INCLUDE_DIR: " ${Vulkan_INCLUDE_DIR})

#--------------------------------- Find SDL2 ---------------------------------#
set(VULKAN $ENV{VULKAN_SDK}) #set to Vulkan SDK
message("VULKAN SDK: " ${VULKAN})
if (APPLE)
	# Vulkan SDK on Mac does not provide SDL2Config.cmake
	add_library(SDL2::SDL2 SHARED IMPORTED)
	set_target_properties(SDL2::SDL2 PROPERTIES
	    INTERFACE_INCLUDE_DIRECTORIES ${VULKAN}/include/SDL2
		IMPORTED_LOCATION ${VULKAN}/lib/libSDL2-2.0.dylib
	)
else()
	# search SDL2 in Vulkan SDK and system packages
	list(APPEND CMAKE_PREFIX_PATH ${VULKAN})
	find_package(SDL2 REQUIRED)
endif()
# available now as SDL2::SDL2

#--------------------------------- Fetch ImGui ---------------------------------#
include(FetchContent) # enable Fetch Content
FetchContent_Declare(imgui
                     GIT_REPOSITORY https://github.com/ocornut/imgui.git 
                     GIT_TAG master)

FetchContent_MakeAvailable(Imgui)
# ImGui does not provide CMakeLists.txt
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

#--------------------------------- Fetch vk-bootstrap ---------------------------------#
FetchContent_Declare(vkbootstrap
                     GIT_REPOSITORY https://github.com/charles-lunarg/vk-bootstrap.git 
                     GIT_TAG main)
FetchContent_MakeAvailable(vkbootstrap)
# available now as vk-bootstrap::vk-bootstrap

#--------------------------------- Main Target ---------------------------------#
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
