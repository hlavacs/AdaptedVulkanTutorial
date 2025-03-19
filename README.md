The Adapted Vulkan Toturial shows how to draw an object using the Vulkan API. It is based on the origin Vulkan Tutorial, but has been adapted to include the following features:

* SDL2 instead of GLFW.
* Vulkan Memory Allocator (VMA).
* Volk function loader.
* Imgui.
* Slang instead of GLSL.

All features except Imgui are already part of the Vulkan SDK, and thus make sense to be used.

On Windows compile using MSVC and the compile.cmd file, or use CMake from VS Code or run (using MSVC generator)
```
cmake -B build
cmake --build build --config Debug
build\Debug\28_model_loading.exe
```

You need two prerequisites:

* The Vulkan SDK needs to be installed, and the environment variable VULKAN_SDK needs to point to it.
* You need to clone the IMGUI repo (https://github.com/ocornut/imgui) into some directory. In the file *compile.cmd* or *CMakeLists.txt*, set the IMGUI variable to this directory. 
* When using CMake, Imgui is automatically fetched from the Git repo (usually to build/_deps/imgui-src), no need to clone it.

Only the CPP files are needed, no need to compile it.

# Installing on MacOS

1. **Install Dependencies:**
   - **Xcode:** Make sure you have Xcode installed on your macOS. You can download it from the Mac App Store.
   - **Homebrew:** If you don't have Homebrew installed, you can install it by running the following command in your terminal:
     ```sh
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

2. **Install Vulkan SDK:**
   - Download the Vulkan SDK for macOS from the [LunarG website](https://vulkan.lunarg.com/sdk/home).
   - Install it to a directory VulkanSDK in your home directory.

3. **Install MoltenVK:**
   - You can install MoltenVK using Homebrew:
     ```sh
     brew install moltenvk
     ```

4. **Set VULKAN_SDK**
    - Edit .zprofile in your home directory to let VULKAN_SDK point to the VulkanSDK directory.
    ```sh
    export VULKAN_SDK="/Users/<YOURNAME>/VulkanSDK/1.4.309.0/macOS"
    ```

