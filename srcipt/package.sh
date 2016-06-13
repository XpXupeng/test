#!/bin/bash
#package script to package out application for update.

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

#check arguments.
if [ -z "$1" ]; then
    echo -e "arguments not correct, please input as $0 moudle\ni.e: $0 C28 or $0 YX"
    exit 1
fi

if [ "$1" != "C28" ] && [ "$1" != "YX" ]; then
    echo -e "arguments not correct, please input as $0 moudle\ni.e: $0 C28 or $0 YX"
    exit 1
fi

 
if [ "$1" == "C28" ];then
    moudle=C28
    basecontent="ring.wav env.sh rtc/ startapp_.sh stopapp.sh yg-ai/" 
else
    moudle=YX
    basecontent="env.sh rtc/ startapp_.sh stopapp.sh yg-ai/" 
fi


#prepare variables for package
branch_name=`git rev-parse --abbrev-ref HEAD` #获得当前分支名称
version_show_name="v`date +%y%m%d%H%M`_${branch_name:0:3}"

if [[ -z $(git status -s) ]]; then
    echo "Will build software for version $version_show_name ."
else
    git status -s
    echo "code base has uncommitted changes. commit first."
    exit
fi

try_command_exit git tag $version_show_name
version=`git describe --tags`_$moudle
echo $version
basename="xmppClient"
installfiletmple="template_install.sh"
installfileout="install_out.sh"
installbin=$moudle"_install_"$version".bin"
paskey=mimashi2b*
baseDirforscriptself=$(cd "$(dirname "$0")"; pwd)

#prepare package name
basepackage=$basename"_base.tar.gz"
package=$basename"_"$version".tar.gz"
updatepackage=$basename"_"$version".package"
updatezippackage=$moudle"_"$basename"_"$version"_update.zip"
fullpackage=$basename".tar.gz"
updatepackageinfo="package.info"
client_bin_name="xmppClient_arm_rel48"



#define path
srcdir="/home/lth/work/connection/src/xmppClient/"
basedir="$srcdir/base"
outdir="$baseDirforscriptself/out_packages/$moudle""_$version"
update_package_deps="$baseDirforscriptself/update_package_deps/"
try_command_exit rm -rf $outdir
try_command_exit mkdir -p $outdir

config_template_dir="$srcdir/config.template/"
config_output_dir="$outdir/config/"
robot_info_config="ygrobot/robot_info.xml"

try_command_exit rm -rf $config_output_dir
try_command_exit mkdir -p $config_output_dir

try_command_exit cp $config_template_dir/* $config_output_dir -fr
#change robot_info.xml config for differnet machine module.
try_command_exit sed -i "s/CLEANROBOT/CleanRobot$moudle/g" $config_output_dir/$robot_info_config 


#package content need to be included.
packagecontent="3rd config scripts $client_bin_name"


#update package increament content.

#updatepackagecontent="scripts xmppClient_arm_rel48"
#updatepackagecontent="ring.wav scripts xmppClient_arm_rel48 config/wpa_supplicant.conf"
#updatepackagecontent="ring.wav scripts xmppClient_arm_rel48 post_update.sh config/wpa_supplicant.conf"
#updatepackagecontent="ring.wav scripts xmppClient_arm_rel48 post_update.sh gpio_mcu.ko mcuupgrade/ config/wpa_supplicant.conf"
#updatepackagecontent="ring.wav scripts xmppClient_arm_rel48 config/wpa_supplicant.conf"

#updatepackagecontent="stopapp.sh env.sh scripts xmppClient_arm_rel48 post_update.sh lftp_package mcuupgrade/"
#updatepackagecontent="stopapp.sh env.sh scripts xmppClient_arm_rel48 post_update.sh lftp_package curl_package"
#updatepackagecontent="stopapp.sh env.sh scripts xmppClient_arm_rel48 post_update.sh lftp_package ssh_config/"





packagedir="$outdir/packages_"$version"/"
updateoutdir="$outdir/update_"$version"/"

try_command_exit mkdir -p $packagedir

mkdir -p $updateoutdir

pushd $basedir
try_command_exit tar -cvzf $packagedir/$basepackage $basecontent  #basepackage=$basename"_base.tar.gz"
popd

pushd $srcdir
try_command_exit make ARCH_ARM=YES clean
try_command_exit make ARCH_ARM=YES -j5
try_command_exit rm -rf config
try_command_exit cp -rf $config_output_dir .
try_command_exit tar -cvzf $packagedir/$package $packagecontent -X $baseDirforscriptself/package.ignore  #package=$basename"_"$version".tar.gz"   
popd


pushd $update_package_deps
try_command_exit cp -rf $srcdir/$client_bin_name .
try_command_exit tar -cvhzf - . | openssl des3 -salt -k $paskey | dd of=$updateoutdir/$updatepackage  #updatepackage=$basename"_"$version".package"
popd



pushd $updateoutdir
md5=`md5sum $updatepackage | awk '{ print $1 }'`
echo "filename = "$updatepackage >> $updatepackageinfo #updatepackageinfo="package.info"
echo "version = "$version >> $updatepackageinfo
echo "md5 = "$md5 >> $updatepackageinfo
echo "pwd = "$paskey >> $updatepackageinfo
try_command_exit zip -r $updatezippackage .  #updatezippackage=$moudle"_"$basename"_"$version"_update.zip"     C28_xmppClient_v1604202124_dev_update.zip
#unpack for verify
update_content="update_content"
try_command_exit mkdir -p $update_content
dd if=$updateoutdir/$updatepackage | openssl des3 -d -k $paskey | tar -xvzf - -C $update_content





popd


pushd $packagedir
try_command_exit tar -cvzf $fullpackage $basepackage $package #fullpackage=$basename".tar.gz"
popd

cat $installfiletmple | sed "s/BASEPACKAGE/$basepackage/g;s/FULLPACKAGE/$fullpackage/g;s/PACKAGE/$package/g" > $packagedir/$installfileout
cat $packagedir/$installfileout $packagedir/$fullpackage > $outdir/$installbin
chmod +x $outdir/$installbin
