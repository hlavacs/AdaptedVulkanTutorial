
set IMGUI="C:\data\GitHub\ViennaVulkanEngine\extern\imgui"
echo %IMGUI%
set VULKAN=%VULKAN_SDK%
rem set VULKAN="C:\VulkanSDK\
echo %VULKAN%

cl 28_model_loading.cpp ^
    %IMGUI%/imgui.cpp ^
    %IMGUI%/imgui_demo.cpp ^
    %IMGUI%/imgui_draw.cpp ^
    %IMGUI%/backends/imgui_impl_sdl2.cpp ^
    %IMGUI%/backends/imgui_impl_vulkan.cpp ^
    %IMGUI%/imgui_tables.cpp ^
    %IMGUI%/imgui_widgets.cpp ^
    /EHsc /std:c++20  /DEBUG /Zi /Istb /I%IMGUI% ^
    /D IMGUI_IMPL_VULKAN_NO_PROTOTYPES ^
    /I%VULKAN%\include ^
    /I%VULKAN%\include\SDL2 ^
    /I%VULKAN%\include\volk ^
    %VULKAN%\Lib\SDL2.lib ^
    %VULKAN%\Lib\volk.lib ^
    /link /SUBSYSTEM:CONSOLE /OUT:28_model_loading.exe

