# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/xp/xpgit/yubot/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/xp/xpgit/yubot/build

# Include any dependencies generated for this target.
include rtc_pak/CMakeFiles/client.dir/depend.make

# Include the progress variables for this target.
include rtc_pak/CMakeFiles/client.dir/progress.make

# Include the compile flags for this target's objects.
include rtc_pak/CMakeFiles/client.dir/flags.make

rtc_pak/CMakeFiles/client.dir/src/client.cpp.o: rtc_pak/CMakeFiles/client.dir/flags.make
rtc_pak/CMakeFiles/client.dir/src/client.cpp.o: /home/xp/xpgit/yubot/src/rtc_pak/src/client.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/xp/xpgit/yubot/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object rtc_pak/CMakeFiles/client.dir/src/client.cpp.o"
	cd /home/xp/xpgit/yubot/build/rtc_pak && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/client.dir/src/client.cpp.o -c /home/xp/xpgit/yubot/src/rtc_pak/src/client.cpp

rtc_pak/CMakeFiles/client.dir/src/client.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/client.dir/src/client.cpp.i"
	cd /home/xp/xpgit/yubot/build/rtc_pak && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/xp/xpgit/yubot/src/rtc_pak/src/client.cpp > CMakeFiles/client.dir/src/client.cpp.i

rtc_pak/CMakeFiles/client.dir/src/client.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/client.dir/src/client.cpp.s"
	cd /home/xp/xpgit/yubot/build/rtc_pak && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/xp/xpgit/yubot/src/rtc_pak/src/client.cpp -o CMakeFiles/client.dir/src/client.cpp.s

rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.requires:
.PHONY : rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.requires

rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.provides: rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.requires
	$(MAKE) -f rtc_pak/CMakeFiles/client.dir/build.make rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.provides.build
.PHONY : rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.provides

rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.provides.build: rtc_pak/CMakeFiles/client.dir/src/client.cpp.o

# Object files for target client
client_OBJECTS = \
"CMakeFiles/client.dir/src/client.cpp.o"

# External object files for target client
client_EXTERNAL_OBJECTS =

/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: rtc_pak/CMakeFiles/client.dir/src/client.cpp.o
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: rtc_pak/CMakeFiles/client.dir/build.make
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/libroscpp.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libboost_signals.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/libxmlrpcpp.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/libroscpp_serialization.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/librosconsole.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/librosconsole_log4cxx.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/librosconsole_backend_interface.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/liblog4cxx.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libboost_regex.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/librostime.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /opt/ros/indigo/lib/libcpp_common.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libboost_system.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libboost_thread.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libpthread.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: /usr/lib/x86_64-linux-gnu/libconsole_bridge.so
/home/xp/xpgit/yubot/devel/lib/rtc_pak/client: rtc_pak/CMakeFiles/client.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable /home/xp/xpgit/yubot/devel/lib/rtc_pak/client"
	cd /home/xp/xpgit/yubot/build/rtc_pak && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/client.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
rtc_pak/CMakeFiles/client.dir/build: /home/xp/xpgit/yubot/devel/lib/rtc_pak/client
.PHONY : rtc_pak/CMakeFiles/client.dir/build

rtc_pak/CMakeFiles/client.dir/requires: rtc_pak/CMakeFiles/client.dir/src/client.cpp.o.requires
.PHONY : rtc_pak/CMakeFiles/client.dir/requires

rtc_pak/CMakeFiles/client.dir/clean:
	cd /home/xp/xpgit/yubot/build/rtc_pak && $(CMAKE_COMMAND) -P CMakeFiles/client.dir/cmake_clean.cmake
.PHONY : rtc_pak/CMakeFiles/client.dir/clean

rtc_pak/CMakeFiles/client.dir/depend:
	cd /home/xp/xpgit/yubot/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/xp/xpgit/yubot/src /home/xp/xpgit/yubot/src/rtc_pak /home/xp/xpgit/yubot/build /home/xp/xpgit/yubot/build/rtc_pak /home/xp/xpgit/yubot/build/rtc_pak/CMakeFiles/client.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : rtc_pak/CMakeFiles/client.dir/depend

