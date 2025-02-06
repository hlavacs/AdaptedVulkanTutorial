The Adapted Vulkan Toturial shows how to draw an object using the Vulkan API. It is based on the origin Vulkan Tutorial, but has been adapted to include the following features:

* SDL2 instead of GLFW.
* Vulkan Memory Allocator (VMA).
* Volk function loader.
* Imgui.
* Slang instead of GLSL.

All features except Imgui are already part of the Vulkan SDK, and thus make sense to be used.

On windows compile using MSVC and the compile.cmd file, or use cmake from VScode or run
```
cmake -B build
cmake --build build --config Debug
```

You need two prerequisites:

* The Vulkan SDK needs to be installed, and the environment variable VULKAN_SDK needs to point to it.

* You need to clone the IMGUI repo (https://github.com/ocornut/imgui) into some directory. In the file *compile.cmd* or *CMakeLists.txt*, set the IMGUI variable to this directory. 
Only the CPP files are needed, no need to compile it.

