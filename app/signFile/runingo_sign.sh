#!/bin/bash

#str="./../script"
#appPath="."
#TctCamera_M_Global_v0.4.3.1.0002.0_signed_platform_alldpi.apk

str=$1
appPath=$2
moduleName=$3
versionName=$4
echo "versionName : $versionName"

gradle assembleRelease

#mv ./build/outputs/apk/release/${moduleName}-release-unsigned.apk ./build/outputs/apk/release/${moduleName}-release-unsigned.apk

cp -R /home/user/Android/sign/sign_lib /local/work/Runingo/app/signFile/
java -Xmx512m -Djava.library.path=${str}/sign_lib -jar ${str}/sign_lib/signapk.jar --min-sdk-version 8 ${str}/sign_lib/platform.x509.pem ${str}/sign_lib/platform.pk8 ${appPath}/build/outputs/apk/release/${moduleName}-release-unsigned.apk  ${appPath}/build/outputs/apk/release/${versionName}.apk
rm /local/work/Runingo/app/signFile/sign_lib/ -rf

#remove temp apk
rm ${appPath}/build/outputs/apk/release/${moduleName}-release-unsigned.apk

adb uninstall com.factory.runintestii

adb install -r ${appPath}/build/outputs/apk/release/${versionName}.apk

adb shell am start -n com.factory.runintestii/.activity.MainActivity
