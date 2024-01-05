
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
