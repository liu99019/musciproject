cmake_minimum_required(VERSION 3.23)

project(lingTmusic VERSION 0.1 LANGUAGES CXX)

file(GLOB_RECURSE QRC_SOURCE_FILES ${CAMKE_CURRENT_SOURCE_DIR}/*.qrc)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QRC_SOURCE_FILES Resources.qrc)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

find_package(Qt6 REQUIRED COMPONENTS Widgets)

find_package(Qt6 REQUIRED COMPONENTS Multimedia)
find_package(Qt6 REQUIRED COMPONENTS Charts)

INCLUDE_DIRECTORIES("/usr/include/taglib")

qt6_add_resources(QRC_FILES ${QRC_SOURCE_FILES})

SOURCE_GROUP("Resource Files" FILES ${QRC_SOURCE_FILES})
qt_add_executable(applingTmusic
    main.cpp
    common.h
    mylrc.cpp
    mylrc.h
    searchsong.cpp
    searchsong.h
    ${QRC_FILES}
    songdecode.h songdecode.cpp
    datasource.h  datasource.cpp
)

qt_add_qml_module(applingTmusic
    URI lingTmusic
    VERSION 1.0
    QML_FILES main.qml MusicLrc.qml MyMediaPlayer.qml
    SongSearch.qml RecentSong.qml ButtonItem.qml Songinformation.qml  AudioSample.qml
)


set_target_properties(applingTmusic PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(applingTmusic
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(applingTmusic
    PRIVATE Qt6::Quick tag)
target_link_libraries(applingTmusic PRIVATE
       Qt6::Multimedia   Qt6::Widgets   Qt6::Multimedia   Qt6::Charts)
