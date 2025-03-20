The Adapted Vulkan Toturial shows how to draw an object using the Vulkan API. It is based on the origin Vulkan Tutorial, but has been adapted to include the following features:

* SDL2 instead of GLFW.
* Vulkan Memory Allocator (VMA).
* Volk function loader.
* Imgui.
* Slang instead of GLSL.

All features except Imgui are already part of the Vulkan SDK, and thus make sense to be used.

# Installing on Windows 

## Prerequisites:

You need these tools for compiling:
* Install MSVC and possibly Clang with it. When you compile from a command prompt, make sure to use "x64 Native Tools Command Prompt".
* It is recommended to ue MS Visual Studio Code, see section below, so install it also.
* Install the Vulkan SDK, the environment variable VULKAN_SDK needs to point to it. On Windows this should be done automatially.
* When using CMake, Imgui is automatically fetched from the Git repo (usually to build/_deps/imgui-src), no need to clone it.
* When using the script on Windows, you need to clone the ImGUI repo (https://github.com/ocornut/imgui) into some directory. In the file *compile.cmd* set the ImGUI variable to this directory. 
* Only the ImGUI CPP files are needed, no need to compile it.

## Compiling using CMake

Best to use **MS Visual Studio Code** for everything, see below. If you do not want to use it, run the following commands in a "x64 Native Tools Command Prompt" from the project directory:

```
cmake -B build
cmake --build build --config Debug
build\Debug\28_model_loading.exe
```

Here you do not need to install ImGUI manually, since Cmake will download it automatically. 

## Compiling with the Script

On Windows compile using MSVC and the compile.cmd file. Make sure to first clone the ImGUI repo and edit the script to let point the IMGUI variable to its directory. Then run the script.


# Installing on MacOS

1. **Install Dependencies:**
   - **Xcode:** Make sure you have Xcode installed on your macOS. You can download it from the Mac App Store.
   - **Homebrew:** If you don't have Homebrew installed, you can install it by running the following command in your terminal:
     ```sh
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

2. **Install Vulkan SDK:**
   - Download the Vulkan SDK for macOS from the [LunarG website](https://vulkan.lunarg.com/sdk/home).
   - Install it to a directory "VulkanSDK" in your home directory.

3. **Install MoltenVK:**
   - You can install MoltenVK using Homebrew:
     ```sh
     brew install moltenvk
     ```

4. **Set VULKAN_SDK**
   - Edit .zprofile in your home directory to let the environment variable VULKAN_SDK point to the VulkanSDK directory.
     ```sh
     export VULKAN_SDK="/Users/<YOURNAME>/VulkanSDK/1.4.309.0/macOS"
     ```
   - Log off and on again to apply the changes.

5. **Configuring and Compiling**
   - Use cmake directly to configure and compile
   - Or use MS Visual Studio Code, see below (recommended).

# Using MS Visual Studio Code

If you want to use MS Visual Studio Code (available for most platforms), install it for your platform. Also install the extensions Cmake an Cmake Tools. Then you can access all cmake features by clicking on Menu View / Command Palette... and enter cmake. You will be presented the cmake options which you can choose from in this sequence:
* Cmake: Select a Kit (Apple Clang)
* Cmake: Select Variant (Debug)
* Cmake: Configure
* Cmake: Build

For debugging select debug as variant, compile it, then choose the "Run and Debug" option on the left toolbar. In the drop down menu next to the green triangle choose your platform / compiler / variant:
* MSVC on Windows  - select "(Windows) debug"
* Clang on Windows - select "Clang Launch"
* Clang on MacOS - select "MacClang Launch"

Click on the green triangle to start the program.
