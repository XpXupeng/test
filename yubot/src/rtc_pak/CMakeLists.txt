cmake_minimum_required(VERSION 2.8.3)
project(rtc_pak)

find_package(catkin REQUIRED COMPONENTS
    roscpp
    rospy
    std_msgs
    rosconsole
)

catkin_package()

#自定义变量使用SET(OBJ_NAME xxxx)，使用时${OBJ_NAME}
set(INCLUDE_PATH "./include/")
set(LIB_PATH "./lib/")
set(BIN_PATH "./bin/")

#指定头文件目录
include_directories(
    ${INCLUDE_PATH}/gloox
    ${catkin_INCLUDE_DIRS}
)


#搜索动态链接库或静态链接库的搜索路径，相当于gcc的-L参数
LINK_DIRECTORIES(${LIB_PATH}/gloox_lib)
add_executable(client src/client.cpp)
#添加链接库,相同于指定-l参数
target_link_libraries(client gloox ${catkin_LIBRARIES})

#搜索动态链接库或静态链接库的搜索路径，相当于gcc的-L参数
LINK_DIRECTORIES(${LIB_PATH}/json_lib)
add_executable(json src/json.cpp)
#添加链接库,相同于指定-l参数
target_link_libraries(json jsonlib ${catkin_LIBRARIES})

