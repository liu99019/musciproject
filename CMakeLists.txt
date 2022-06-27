cmake_minimum_required(VERSION 3.23)

project(lingTmusic VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

qt_add_executable(applingTmusic
    main.cpp
    common.h
    mylrc.cpp
    mylrc.h
    searchsong.cpp
    searchsong.h
    icon.qrc
)

qt_add_qml_module(applingTmusic
    URI lingTmusic
    VERSION 1.0
    QML_FILES main.qml MusicLrc.qml MyMediaPlayer.qml
    SongSearch.qml RecentSong.qml ButtonItem.qml  MiniLrcDialog.qml
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
    PRIVATE Qt6::Quick)
target_link_libraries(applingTmusic PRIVATE
       Qt6::Multimedia)
