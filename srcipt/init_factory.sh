#!/bin/bash
baseDirforscriptself=$(cd "$(dirname "$0")"; pwd)
run_dir=/media/mmcblk0p7/
ssh_config_path=/usr/local/etc/sshd_config
server_ip=192.168.1.53
server_port=9090

export PYTHONHOME=/
export PYTHONPATH=/lib/python3.2:/lib/python3.2/site-packages:/lib/python3.2/lib-dynload
export PATH=$PATH:$PYTHONHOME:$PYTHONPATH

reset_to_default_pwd()
{
    #change default ssh port
    sed -i "/Port/d" $ssh_config_path
    echo "Port 22" >> $ssh_config_path
    sync

    #chang root password
    echo -e "mimashi2b\nmimashi2b" | passwd root
    sync
}

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


wait_network_ok()
{
count=0
while ! ping -c 1 -W 1 $server_ip; do
        echo "Waiting for $server_ip - network interface might be down..."
        sleep 1
        let $[count++]
        if [ $count -gt 20 ];then
            echo "network not ready, skip installation."
            exit 1
        fi
done
return 0
}

install_package_url="http://$server_ip:$server_port/plugins/robotInitialInstallation/robotinitialinstallation" #机器人的初始安装
config_base_url="http://$server_ip:$server_port/plugins/robotConfig/robotconfigservlet?"
nic=wlan0

#network
wait_network_ok
echo $install_package_url
echo $config_base_url

install_package_file="installation.bin"
config_file="robot_config.xml"
config_path=/etc/ygrobot/
ssh_config_path_out=/usr/local/etc/sshd_config.out

mac="mac=`ifconfig $nic | awk '/HWaddr/{ print $5 }'`"

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000))
    echo $(($num%$max+$min))
    return $num
}

random_port=$(rand 1024 65535)
echo $random_port
sshport="sshport=$random_port"

random_root_pwd=`openssl rand -hex 4`
echo $random_root_pwd
rootpwd="rootpwd=$random_root_pwd"


#change default ssh port
try_command_exit cp -fr $ssh_config_path $ssh_config_path_out
try_command_exit sed -i "/Port/d" $ssh_config_path
try_command_exit echo "Port $random_port" >> $ssh_config_path
try_command_exit sync



#chang root password
try_command_exit echo -e "$random_root_pwd\n$random_root_pwd" | passwd root
try_command_exit sync


config_full_url=$config_base_url$mac"&"$rootpwd"&"$sshport
echo $config_full_url

#Download configfile, and upload ssh pwd and port
try_command_exit rm -rf $baseDirforscriptself/$config_file
try_command_exit sync
try_command_exit wget -O $baseDirforscriptself/$config_file $config_full_url
try_command_exit sync


#check if the config file exists.
if [ ! -f "$baseDirforscriptself/$config_file" ]; then
    reset_to_default_pwd
fi


#1.download init full package.
try_command_exit rm -rf $baseDirforscriptself/$install_package_file
try_command_exit sync
try_command_exit wget -O $baseDirforscriptself/$install_package_file $install_package_url
try_command_exit sync





pushd $baseDirforscriptself
try_command_exit sh $install_package_file

try_command_exit cp $config_file $config_path -fr
try_command_exit sync

try_command_exit rm $baseDirforscriptself/* -fr
try_command_exit sync
popd



startscript=/etc/rcS.d/S99User.sh
startscript_out=/etc/rcS.d/S99User.sh.bak
try_command_exit cp $startscript $startscript_out -fr
try_command_exit sed -i '/init_factory/d' $startscript
try_command_exit sync


pushd $run_dir
try_command_exit . ./env.sh
try_command_exit ./xmppClient_arm_rel48
popd
