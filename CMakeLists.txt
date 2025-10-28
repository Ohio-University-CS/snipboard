# SNIPBOARD CMAKE CONFIGURATION
cmake_minimum_required(VERSION 3.19)
project(SnipBoard VERSION 0.1 LANGUAGES CXX)

# General configuration
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Qt Path Setup
if (WIN32)
    set(QT_ROOT "C:/Qt/6.10.0/mingw_64")
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
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Qml Quick Sql)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Qml Quick Sql)

# ADDED: Set Qt policies to resolve warnings
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

# Define header files
set(HEADERS
    src/core/models/Folder.h
    src/core/models/Snippet.h
    src/core/models/Tag.h
    src/core/objects/SnippetObject.h
    src/core/objects/TagObject.h
    src/core/objects/FolderObject.h
    src/core/objects/SnippetListModel.h
    src/core/objects/TagListModel.h
    src/core/objects/FolderTreeModel.h
)

# Add c++ to be compiled
qt_add_executable(SnipBoard
    MANUAL_FINALIZATION
    MACOSX_BUNDLE
    ${HEADERS}
    src/main.cpp
    src/core/objects/SnippetObject.cpp
    src/core/objects/TagObject.cpp
    src/core/objects/FolderObject.cpp
    src/core/objects/SnippetListModel.cpp
    src/core/objects/TagListModel.cpp
    src/core/objects/FolderTreeModel.cpp
    # Add other c++ files here
)

target_include_directories(SnipBoard PUBLIC src/core/models)

qt_add_qml_module(SnipBoard
    URI SnipBoard
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        src/gui/main.qml
        src/gui/colors.qml
        src/gui/pages/settings.qml
        src/gui/pages/new_snippet.qml
        src/gui/pages/home.qml
        src/gui/pages/delete_overlay.qml
)

# Expose the generated QML module directory to the application at compile-time
# so the running binary can add it to QQmlApplicationEngine import paths.
target_compile_definitions(SnipBoard PRIVATE
    SNIPBOARD_QML_MODULE_DIR="${CMAKE_BINARY_DIR}/SnipBoard"
)

# CHANGED: Updated target properties to use the new executable name
set_target_properties(SnipBoard PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.snipboard.SnipBoard
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    WIN32_EXECUTABLE TRUE
)

# CHANGED: Updated target_link_libraries to use the new executable name
target_link_libraries(SnipBoard PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Qml
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Sql
)

# CHANGED: Updated qt_finalize_executable to use the new executable name
qt_finalize_executable(SnipBoard)

# Post-build Deployment Steps (link Qt requirements)
if (WIN32)
    if (EXISTS "${WINDEPLOYQT_EXECUTABLE}")
        # CHANGED: Updated the deployment command to use the new executable name
        add_custom_command(TARGET SnipBoard POST_BUILD
            COMMAND "${WINDEPLOYQT_EXECUTABLE}" "$<TARGET_FILE:SnipBoard>" --no-translations --verbose 1
            COMMENT "Running windeployqt to bundle Qt dependencies..."
        )
    else()
        message(WARNING "windeployqt not found at ${WINDEPLOYQT_EXECUTABLE}")
    endif()
elseif(APPLE)
    if (MACDEPLOYQT_EXECUTABLE)
        # CHANGED: Updated the deployment command to use the new executable name
        add_custom_command(TARGET SnipBoard POST_BUILD
            COMMAND "${MACDEPLOYQT_EXECUTABLE}"
                "$<TARGET_BUNDLE_DIR:SnipBoard>"
                -always-overwrite
                -verbose=2
                -executable="$<TARGET_FILE:SnipBoard>"
                -libpath=/opt/homebrew/opt/qt6/lib
            COMMENT "Running macdeployqt to bundle Qt frameworks..."
        )
    else()
        message(WARNING "macdeployqt not found. Install Qt with: brew install qt")
    endif()
elseif(UNIX)
    if (LINUXDEPLOYQT_EXECUTABLE)
        # CHANGED: Updated the deployment command to use the new executable name
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

if(APPLE)
    # === Copy QML files into the app bundle ===
    set(QML_SOURCE_DIR "${CMAKE_SOURCE_DIR}/src/gui")
    set(QML_DEST_DIR "${CMAKE_BINARY_DIR}/SnipBoard.app/Contents/Resources")

    # Gather all .qml files from your GUI folder
    file(GLOB QML_FILES "${QML_SOURCE_DIR}/*.qml")

    # Create the Resources directory if it doesn't exist
    add_custom_command(
        TARGET SnipBoard POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${QML_DEST_DIR}"
    )

    # Copy each QML file after build
    foreach(QML_FILE ${QML_FILES})
        add_custom_command(
            TARGET SnipBoard POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    "${QML_FILE}"
                    "${QML_DEST_DIR}/"
            COMMENT "Copying ${QML_FILE} → Resources"
        )
    endforeach()

endif()