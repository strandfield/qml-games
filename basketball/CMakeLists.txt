
file(GLOB_RECURSE SRC_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
file(GLOB_RECURSE HDR_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
file(GLOB_RECURSE QML_FILES ${CMAKE_CURRENT_SOURCE_DIR}/qml/*.qml)

add_executable(basketball ${HDR_FILES} ${SRC_FILES} "basketball.qrc" ${QML_FILES})

target_link_libraries(basketball Qt5::Quick Qt5::Qml)

if (WIN32)
  set_target_properties(basketball PROPERTIES VS_DEBUGGER_ENVIRONMENT "PATH=${Qt5_DIR}/../../../bin;%PATH%")
endif()
