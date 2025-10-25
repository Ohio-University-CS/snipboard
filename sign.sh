codesign --remove-signature ./build/SnipBoard.app
codesign --force --deep --sign - ./build/SnipBoard.app

export DYLD_FRAMEWORK_PATH=./build/SnipBoard.app/Contents/Frameworks
export QML_IMPORT_PATH=/opt/homebrew/share/qt/qml

./build/SnipBoard.app/Contents/MacOS/SnipBoard