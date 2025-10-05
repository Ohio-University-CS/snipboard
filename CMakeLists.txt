cmake_minimum_required(VERSION 3.16)
project(SnipBoard VERSION 0.1 LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile commands for VS Code IntelliSense
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Essential for Qt + CMake integration
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Windows
set(QT_ROOT "C:/Qt/6.9.2/mingw_64")
set(CMAKE_PREFIX_PATH "${QT_ROOT}/lib/cmake")
set(WINDEPLOYQT_EXECUTABLE "${QT_ROOT}/bin/windeployqt.exe")
if (WIN32)
    set(CMAKE_PREFIX_PATH "C:/Qt/6.9.2/mingw_64/lib/cmake")
endif()

# For macOS
if(APPLE)
    list(APPEND CMAKE_PREFIX_PATH "/opt/homebrew/opt/qt6")
endif()

# Find the Qt6 package and its components
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Sql)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Sql)

# Create the executable
qt_add_executable(SnipBoard
    MANUAL_FINALIZATION
    src/main.cpp
    src/gui/mainwindow.h
    src/gui/mainwindow.cpp
    src/gui/mainwindow.ui
)

# Set properties for creating proper application bundles on macOS and Windows
set_target_properties(SnipBoard PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.snipboard.SnipBoard
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    WIN32_EXECUTABLE TRUE
)

# Link the required Qt libraries
target_link_libraries(SnipBoard PRIVATE
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::Sql
)


# Finalize the executable
qt_finalize_executable(SnipBoard)

if (WIN32)
    add_custom_command(TARGET SnipBoard POST_BUILD
        COMMAND "${WINDEPLOYQT_EXECUTABLE}" "$<TARGET_FILE:SnipBoard>" --verbose 1
        COMMENT "Running windeployqt to bundle Qt dependencies..."
    )
endif()