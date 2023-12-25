
file(GLOB_RECURSE SRC_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
file(GLOB_RECURSE HDR_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
file(GLOB_RECURSE QML_FILES ${CMAKE_CURRENT_SOURCE_DIR}/qml/*.qml)

add_executable(guess ${HDR_FILES} ${SRC_FILES} "resources/guess.qrc" ${QML_FILES})

target_link_libraries(guess Qt5::Quick Qt5::Qml Qt5::Svg)

if (WIN32)
  set_target_properties(guess PROPERTIES VS_DEBUGGER_ENVIRONMENT "PATH=${Qt5_DIR}/../../../bin;%PATH%")
endif()
