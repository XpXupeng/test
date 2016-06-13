#!/bin/bash
line=`wc -l $0|awk '{print $1}'`
line=`expr $line - 111`
baseDirforscriptself=$(cd "$(dirname "$0")"; pwd)

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

rundir=/media/mmcblk0p7/
factorydir=/media/mmcblk0p8/
thirddir=/media/mmcblk0p7/3rd/

webpypackage="web.py-0.37.tar.gz"

if [ ! -d "$rundir" ];then
    echo -e "###### Setup File System, please wait for few seconds...  ######\n\n"
    try_command_exit mkdir -p /media/mmcblk0p7
    try_command_exit mkdir -p /media/mmcblk0p8
    try_command_exit mkfs.ext4 -F /dev/mmcblk0p7
    try_command_exit mkfs.ext4 -F /dev/mmcblk0p8

    try_command_exit mount /dev/mmcblk0p7 /media/mmcblk0p7
    try_command_exit mount /dev/mmcblk0p8 /media/mmcblk0p8

    try_command_exit pushd /media/mmcblk0p7
    try_command_exit rm -rf *
    try_command_exit popd

    try_command_exit pushd /media/mmcblk0p8
    try_command_exit rm -rf *
    try_command_exit popd

    try_command_exit chmod 711 /media/mmcblk0p7 -R
    try_command_exit chmod 711 /media/mmcblk0p8 -R

fi

pushd $baseDirforscriptself



install_tmp=$rundir/yg_tmp/

basepackage=BASEPACKAGE
package=PACKAGE
fullpackage=FULLPACKAGE





try_command_exit mkdir -p $install_tmp

#sed -n -e '1,/^exit 0$/!p' $0 > "$install_tmp/$fullpackage" 2>/dev/null
echo -e "###### Preparing installation files, please wait for few seconds...  ######\n\n"
try_command_exit tail -n $line $0 | tar zx -C $install_tmp
try_command_exit sync

try_command_exit pushd $install_tmp
echo -e "###### extracting installation files, please wait... ######\n\n"
try_command_exit tar -xvf $basepackage -C $rundir
try_command_exit tar -xvf $package -C $rundir
try_command_exit sync

echo -e "###### extracting installation files to factory dir, please wait... ######\n\n"
try_command_exit tar -xf $basepackage -C $factorydir
try_command_exit tar -xf $package -C $factorydir
try_command_exit sync
try_command_exit popd

try_command_exit rm -rf $install_tmp
try_command_exit sync


echo -e "###### install 3rd packages, please wait... ######\n\n"
try_command_exit pushd $thirddir
try_command_exit tar zxvf $webpypackage
try_command_exit pushd web.py-0.37
try_command_exit python setup.py install
try_command_exit popd
try_command_exit popd


echo -e "###### Seting up running enviroment...######\n\n"
try_command_exit pushd $rundir
try_command_exit rm -rf $thirddir
./config/link.sh
ret=$?
try_command_exit sync
try_command_exit popd

startscript=/etc/rcS.d/S99User.sh
if grep -q startapp $startscript; then
    echo "startapp alreay set."
else
    echo "pushd $rundir" >> $startscript
    echo ". ./startapp_.sh" >> $startscript
    echo "popd" >> $startscript
fi

try_command_exit sync
popd
echo -e "###### Installation Finished. please make sure the progress have no error.######\n\n"
exit $ret
