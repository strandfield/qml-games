
# QML games

Playing and making simple games with Qt QML!


## WebAssembly

These QML games can be compiled with WebAssembly to run in a web browser.

Below are the steps for compiling with Qt 5.15 on Windows.

Before getting started, please make sure you have read [Qt for WebAssembly](https://doc.qt.io/qt-5/wasm.html).

**Qt packages for WebAssembly**

In the Qt Maintenance Tool, under Qt 5.15, make sure you have the `WebAssembly` package installed. 

**Installing emscripten**

emscripten is used to compile C++ to WebAssembly.

Installing is done by following the instructions on the [Download and install](https://emscripten.org/docs/getting_started/downloads.html) page.

Since there are many versions of the emscripten compiler, probably 
with some incompatibilites between different versions, a SDK is provided 
so that you can install the exact version you need.

Cloning the SDK:
```
git clone https://github.com/emscripten-core/emsdk.git
``` 

Installing `em++` version 1.39.8:

```
cd emsdk
emsdk install 1.39.8
```

Setting up a build environment:

```
emsdk activate --embedded 1.39.8
```

Checking the version of the emscripten compiler:
```
em++ --version
```

The installation of emscripten has been completed.
You may close the console, but if you do, do not forget 
to set up the build environment (with the `activate` command)
for what comes next.

**Building**

Cloning the project:
```
git clone https://github.com/strandfield/qml-games.git
``` 

Creating and moving to a build directory:
```
mkdir build-wasm && cd build-wasm
```

Make sure qmake is in your path and that it is the version that comes 
with the Qt WebAssembly package.

```
set PATH=C:\Qt\5.15.2\wasm_32\bin;%PATH%
qmake --version
```

Run qmake:
```
qmake ../qml-games/qml-games.pro
```

This should generate a `Makefile` in the `build-wasm` directory.

Use `mingw32-make` for building:
```
set PATH=C:\Qt\Tools\mingw810_64\bin;%PATH%
mingw32-make --version
mingw32-make
```

If everything works fine, a folder is created in the build folder for each game.
Each folder contains a HTML file named after the folder.

**Running**

The HTML files produced by the build cannot be opened directly in a web browser,
a http server must be put in place to serve the files so that the `.wasm` file 
is downloaded and compiled by the main HTML file.

From the build folder:

```
python C:/emsdk/upstream/emscripten/emrun.py --browser firefox --port 8080 --no_emrun_detect --serve_after_close collection/collection.html
```

This will setup a HTTP server in Python, open Firefox on the port 8080 
and hopefully the game will start.

## Android

Before starting, please read https://doc.qt.io/qt-5/android-getting-started.html

The following is for Qt 5.15 on Windows.

**Qt packages for Android**

In the Qt Maintenance Tool, under Qt 5.15, make sure you have the `Android` package installed. 

**JDK**

Install a JDK x64 version 8 from here: https://adoptium.net/fr/temurin/releases/?version=8&arch=x64

While installing, enable the "Set JAVA_HOME" option.

**Qt Creator**

We will use Qt Creator 4.15.
We may get an offline installer from the archives here: https://download.qt.io/archive/qtcreator/4.15/

We will let QtCreator setup the Android SDK/NDK; but before that,
we need to do some hacking.

Go to the installation directory of QtCreator, then in `share/qtcreator/android`.

Example: `C:\Qt\qtcreator-4.15.2\share\qtcreator\android`

Create a backup of `sdk_definitions.json`, then modify the original file
so that the version of the `cmdline-tools` is no longer "latest" but rather "8.0".
There must have been some non-backward compatible modifications to this tool
and most recent version do not work with Java 8.

Replace: `cmdline-tools;latest` by `cmdline-tools;8.0`.

Open QtCreator, then open the preferences dialog.

Check in `Kits > Qt versions` that the Android package is detected, 
otherwise add it manually.
The path to qmake should be something like `C:\Qt\5.15.2\android\bin\qmake.exe`.

Then in the mobile devices section, Android tab, specify the path to the JDK if 
it was not detected by QtCreator.
Something like `C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot`.

Then let QtCreator do a complete setup.

If everything works fine, a message like "Android settings are OK. (SDK Version: 2.1, NDK Version: 21.3.6528147)"
should be displayed.

Then check in the Kits section that a Android Clang Multi-ABI kit has been added.

That is the kit to use for compiling to Android!
