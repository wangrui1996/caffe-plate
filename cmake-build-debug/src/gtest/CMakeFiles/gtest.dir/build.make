# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/rui/softs/clion-2018.3.4/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/rui/softs/clion-2018.3.4/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/rui/repos/warpctc-caffe

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rui/repos/warpctc-caffe/cmake-build-debug

# Include any dependencies generated for this target.
include src/gtest/CMakeFiles/gtest.dir/depend.make

# Include the progress variables for this target.
include src/gtest/CMakeFiles/gtest.dir/progress.make

# Include the compile flags for this target's objects.
include src/gtest/CMakeFiles/gtest.dir/flags.make

src/gtest/CMakeFiles/gtest.dir/gtest-all.cpp.o: src/gtest/CMakeFiles/gtest.dir/flags.make
src/gtest/CMakeFiles/gtest.dir/gtest-all.cpp.o: ../src/gtest/gtest-all.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rui/repos/warpctc-caffe/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/gtest/CMakeFiles/gtest.dir/gtest-all.cpp.o"
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gtest.dir/gtest-all.cpp.o -c /home/rui/repos/warpctc-caffe/src/gtest/gtest-all.cpp

src/gtest/CMakeFiles/gtest.dir/gtest-all.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gtest.dir/gtest-all.cpp.i"
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/rui/repos/warpctc-caffe/src/gtest/gtest-all.cpp > CMakeFiles/gtest.dir/gtest-all.cpp.i

src/gtest/CMakeFiles/gtest.dir/gtest-all.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gtest.dir/gtest-all.cpp.s"
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/rui/repos/warpctc-caffe/src/gtest/gtest-all.cpp -o CMakeFiles/gtest.dir/gtest-all.cpp.s

# Object files for target gtest
gtest_OBJECTS = \
"CMakeFiles/gtest.dir/gtest-all.cpp.o"

# External object files for target gtest
gtest_EXTERNAL_OBJECTS =

lib/libgtest-d.a: src/gtest/CMakeFiles/gtest.dir/gtest-all.cpp.o
lib/libgtest-d.a: src/gtest/CMakeFiles/gtest.dir/build.make
lib/libgtest-d.a: src/gtest/CMakeFiles/gtest.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rui/repos/warpctc-caffe/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library ../../lib/libgtest-d.a"
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest && $(CMAKE_COMMAND) -P CMakeFiles/gtest.dir/cmake_clean_target.cmake
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gtest.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/gtest/CMakeFiles/gtest.dir/build: lib/libgtest-d.a

.PHONY : src/gtest/CMakeFiles/gtest.dir/build

src/gtest/CMakeFiles/gtest.dir/clean:
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest && $(CMAKE_COMMAND) -P CMakeFiles/gtest.dir/cmake_clean.cmake
.PHONY : src/gtest/CMakeFiles/gtest.dir/clean

src/gtest/CMakeFiles/gtest.dir/depend:
	cd /home/rui/repos/warpctc-caffe/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rui/repos/warpctc-caffe /home/rui/repos/warpctc-caffe/src/gtest /home/rui/repos/warpctc-caffe/cmake-build-debug /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest /home/rui/repos/warpctc-caffe/cmake-build-debug/src/gtest/CMakeFiles/gtest.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/gtest/CMakeFiles/gtest.dir/depend

