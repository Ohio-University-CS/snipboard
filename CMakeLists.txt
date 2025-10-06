# SNIPBOARD CMAKE CONFIGURATION
cmake_minimum_required(VERSION 3.16)
project(SnipBoard VERSION 0.1 LANGUAGES CXX)

# General configuration
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Qt Path Setup
if (WIN32)
    set(QT_ROOT "C:/Qt/6.9.2/mingw_64")
    set(CMAKE_PREFIX_PATH "${QT_ROOT}/lib/cmake")
    set(WINDEPLOYQT_EXECUTABLE "${QT_ROOT}/bin/windeployqt.exe")

elseif(APPLE)
    list(APPEND CMAKE_PREFIX_PATH "/opt/homebrew/opt/qt6")
    find_program(MACDEPLOYQT_EXECUTABLE macdeployqt HINTS "/opt/homebrew/opt/qt6/bin")

elseif(UNIX)
    list(APPEND CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/cmake/Qt6")
    find_program(LINUXDEPLOYQT_EXECUTABLE linuxdeployqt)
endif()

# Find Qt Libraries
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Sql)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Sql)

# Build Target
qt_add_executable(SnipBoard
    MANUAL_FINALIZATION
    src/main.cpp
    src/gui/mainwindow.h
    src/gui/mainwindow.cpp
    src/gui/mainwindow.ui
    # Add files here that get created
)

set_target_properties(SnipBoard PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.snipboard.SnipBoard
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(SnipBoard PRIVATE
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::Sql
)

qt_finalize_executable(SnipBoard)

# Post-build Deployment Steps (link Qt requirements)
if (WIN32)
    if (EXISTS "${WINDEPLOYQT_EXECUTABLE}")
        add_custom_command(TARGET SnipBoard POST_BUILD
            COMMAND "${WINDEPLOYQT_EXECUTABLE}" "$<TARGET_FILE:SnipBoard>" --no-translations --verbose 1
            COMMENT "Running windeployqt to bundle Qt dependencies..."
        )
    else()
        message(WARNING "windeployqt not found at ${WINDEPLOYQT_EXECUTABLE}")
    endif()

elseif(APPLE)
    if (MACDEPLOYQT_EXECUTABLE)
        add_custom_command(TARGET SnipBoard POST_BUILD
            COMMAND "${MACDEPLOYQT_EXECUTABLE}" "$<TARGET_BUNDLE_DIR:SnipBoard>" -always-overwrite
            COMMENT "Running macdeployqt to bundle Qt frameworks..."
        )
    else()
        message(WARNING "macdeployqt not found. Install Qt with: brew install qt")
    endif()

elseif(UNIX)
    if (LINUXDEPLOYQT_EXECUTABLE)
        add_custom_command(TARGET SnipBoard POST_BUILD
            COMMAND "${LINUXDEPLOYQT_EXECUTABLE}" "$<TARGET_FILE:SnipBoard>" -appimage
            COMMENT "Running linuxdeployqt to bundle Qt libraries..."
        )
    else()
        message(STATUS "linuxdeployqt not found — skipping auto-deploy on Linux.")
    endif()
endif()

#  Diagnostic Output
message(STATUS "Qt Version: ${QT_VERSION_MAJOR}")
message(STATUS "CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")