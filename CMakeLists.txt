cmake_minimum_required(VERSION 3.16)
project(SnipBoard VERSION 0.1 LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile commands so tools (like VS Code C/C++ extension) can read include paths
# and flags from build/compile_commands.json. This helps resolve Qt headers for IntelliSense.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Essential for Qt + CMake integration
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find the Qt6 package and its required components (added Sql for your database)
find_package(Qt6 REQUIRED COMPONENTS Widgets Sql)

# For mac
if(APPLE)
  list(APPEND CMAKE_PREFIX_PATH "/opt/homebrew/opt/qt6")
endif()

# Use the modern Qt6 way to create the executable
qt_add_executable(SnipBoard
    src/main.cpp
    src/gui/mainwindow.h
    src/gui/mainwindow.cpp
    src/gui/mainwindow.ui
    # As you add more source files, list them here
)

# Set properties for creating proper application bundles on macOS and Windows
set_target_properties(SnipBoard PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.snipboard.SnipBoard # Change this to be unique
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    WIN32_EXECUTABLE TRUE
)

# Link the required Qt libraries to our executable
target_link_libraries(SnipBoard PRIVATE
    Qt6::Widgets
    Qt6::Sql
)

# Finalize the executable (part of the modern Qt6 CMake API)
qt_finalize_executable(SnipBoard)
