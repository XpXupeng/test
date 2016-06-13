#!/bin/bash
robot_run_dir="/media/mmcblk0p7/"
factory_dir="/media/mmcblk0p8/"

try_command_exit()
{
    $*
    ret=$?
    if [ $ret != 0 ];then
       echo "command '"$*"' exec failed."  
       exit $ret
    fi
    return $ret
}

cp $robot_run_dir/config/wpa_supplicant.conf $factory/config/
