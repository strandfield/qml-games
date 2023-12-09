cmake_minimum_required(VERSION 3.9)
project(qmlgames)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

##################################################################
####### Qt
##################################################################

find_package(Qt5 COMPONENTS Core Gui Quick Qml REQUIRED)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC TRUE)

##################################################################
####### the games
##################################################################

add_subdirectory(basketball)

