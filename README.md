## SnipBoard

```
   _____         _         ____                          _ 
  / ____|       (_)       |  _ \                        | |
 | (___   _ __   _  _ __  | |_) |  ___    __ _  _ __  __| |
  \___ \ | '_ \ | || '_ \ |  _ <  / _ \  / _` || '_//  _` |
  ____) || | | || || |_) || |_) || (_) || (_| || |  | (_| |
 |_____/ |_| |_||_|| .__/ |____/  \___/  \__,_||_|   \__,_|
                   | |
                   |_|                         
```

SnipBoard provides a way to let you store code snippets. SnipBoard has strong search support and sorting featues such as tags and folders. Refer to the Notion.

##

This project is a work in progress and is being made as a semester long project for CS 3560: Software Engineering Tools and Practices



4. How to Run
   * Have QT installed *
     
   MAC:
      0. brew install qt (if you haven't already)
      1. Create a file "sign.sh". Add the following commands to this .sh file
            "codesign --remove-signature ./build/SnipBoard.app
            codesign --force --deep --sign - ./build/SnipBoard.app
   
            QT_PATH=$(brew --prefix qt)
            export QML_IMPORT_PATH="$QT_PATH/share/qt/qml"
            export DYLD_FRAMEWORK_PATH=./build/SnipBoard.app/Contents/Frameworks
   
            ./build/SnipBoard.app/Contents/MacOS/SnipBoard"
      2. Click build (may take a minute or two...)
      3. Enter "./sign.sh" in terminal to run
         
   WINDOWS:
      1. Click build
      2. Click run/launch button
  
6. 

### Attributions:

1) Star Icon - <a href="https://www.flaticon.com/free-icons/star" title="star icons">Star icons created by Pixel perfect - Flaticon</a>
2) Search Icon - <a href="https://www.flaticon.com/free-icons/magnifying-glass" title="magnifying glass icons">Magnifying glass icons created by Royyan Wijaya - Flaticon</a>
3) Setting Icon - <a href="https://www.flaticon.com/free-icons/settings" title="settings icons">Settings icons created by Ilham Fitrotul Hayat - Flaticon</a>
4) Folder Icon - <a href="https://www.flaticon.com/free-icons/folder" title="folder icons">Folder icons created by dmitri13 - Flaticon</a>
5) Home Icon - <a href="https://www.flaticon.com/free-icons/home-button" title="home button icons">Home button icons created by Freepik - Flaticon</a>
6) Gold Star Icon - <a href="https://www.flaticon.com/free-icons/star" title="star icons">Star icons created by Pixel perfect - Flaticon</a>




