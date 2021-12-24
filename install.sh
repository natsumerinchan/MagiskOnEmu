#!/system/bin/sh

AGVARR="$@"
SCRIPT="$0"
AGV1="$1" AGV2="$2"
MYSCRIPT="$(realpath "$0")"
MYPATH="${MYSCRIPT%/*}"
PATH="$MYPATH:$PATH"

text_press_enter_menu="Press Enter to come back to menu"
text_cannot_mm="Cannot install or this app is adready installed"
text_success_mm="Install success!"
text_warn_uninstall_magisk="Do you want to uninstall Magisk?"
text_done="Done!"
text_saved_magisk_apk_to="Saved Magisk APK to"
text_mount_rw_system="Mount system partition (Read-write)"
text_mount_ro_system="Mount system partition (Read-only)"
text_obtain_root="Obtain ROOT access..."
text_obtain_root_failed="Cannot obtain ROOT access"
text_recommend="Recommended"
text_install_app="Install Magisk app"
text_install_app_sug="Please install Magisk app by yourself"
text_install="Install"
text_setup="Initialize Magisk Core"
text_rm_magisk_files="Removing Magisk files"

warn_reboot(){
echo " The device will reboot after a few seconds"
  pd yellow " IF THE EMULATOR FREEZES, SIMPLY JUST REBOOT IT"
}

print_menu(){
pd gray  "=============================================="
echo "   Magisk on Nox - Installer Script"
echo "   by HuskyDG"
# please don't change this or use "by HuskyDG + your name" for credits :((
p none "   Magisk: "; [ "$(which magisk)" ] && [ "$(magisk -v)" ] && pd light_green "$(magisk -v) ($(magisk -V))" || pd light_red "Not installed"
p none "   Android Level: "; [ "$SDK" -lt "28" ] && pd light_red "$SDK" && pd light_red "  ${text_recommended}: NoxPlayer Android 9" || pd light_green "$SDK"
pd gray "=============================================="

echo "  1 - Install/Update Magisk"
pd gray "      Integrate Magisk root into Nox emulator"
echo "  2 - Uninstall Magisk"
pd gray "      Remove Magisk and its modules"
echo "  3 - Install Magisk Modules Manager"
pd gray "      Module manager for Magisk"
p none "[CHOICE]: "
}

print_menu_install(){

pd gray "=============================================="
echo "   Install/Update Magisk"
pd gray "=============================================="
echo "  1 - Lastest Canary"
echo "  2 - Lastest Alpha"
echo "  3 - Stable v23 - Not recommended"
echo "  4 - Offline (Alpha 23016)"
pd green "* You will download magisk.apk and install Magisk"
p none "[CHOICE]: "

}



language_vn(){

text_press_enter_menu="Nhấn Enter để trở về menu"
text_cannot_mm="Không thể cài đặt hoặc ứng dụng đã được cài đặt"
text_success_mm="Cài đặt thành công!"
text_warn_uninstall_magisk="Bạn có muốn gỡ cài đặt Magisk?"
text_done="Đã xong!"
text_saved_magisk_apk_to="Đã lưu Magisk APK vào"
text_mount_rw_system="Gắn kết phân vùng system (Đọc-ghi)"
text_mount_ro_system="Gắn kết phân vùng system (Chỉ đọc)"
text_obtain_root="Đang lấy quyền ROOT.."
text_obtain_root_failed="Không thể lấy quyền ROOT"
text_recommended="Đề xuất"
text_install_app="Cài đặt ứng dụng Magisk"
text_install_app_sug="Vui lòng cài đặt ứng dụng Magisk thủ công"
text_install="Cài đặt"
text_setup="Thiết lập lõi Magisk"
text_rm_magisk_files="Loại bỏ các tập tin Magisk"


warn_reboot(){
echo " Thiết bị sẽ khởi động trong vài giây nữa"
  pd yellow " NẾU GIẢ LẬP KHÔNG PHẢN HỒI, VUI LÒNG KHỞI ĐỘNG LẠI"
}

print_menu(){
pd gray  "=============================================="
echo "   Magisk on Nox - Installer Script"
echo "   by HuskyDG"
# please don't change this or use "by HuskyDG + your name" for credits :((
p none "   Magisk: "; [ "$(which magisk)" ] && [ "$(magisk -v)" ] && pd light_green "$(magisk -v) ($(magisk -V))" || pd light_red "Not installed"
p none "   Android Level: "; [ "$SDK" -lt "28" ] && pd light_red "$SDK" && pd light_red "  ${text_recommend}: NoxPlayer Android 9" || pd light_green "$SDK"
pd gray "=============================================="

echo "  1 - Cài đặt hoặc cập nhật Magisk"
pd gray "      Triển khai Magisk root vào giả lập Nox"
echo "  2 - Gỡ cài đặt Magisk"
pd gray "      Loại bỏ Magisk và các mô-đun của nó"
echo "  3 - Cài đặt trình quản lí Magisk mô-đun"
pd gray "      Quản lí mô-đun thay thế cho Magisk"
p none "[CHỌN]: "
}

print_menu_install(){

pd gray "=============================================="
echo "   Install/Update Magisk"
pd gray "=============================================="
echo "  1 - Canary mới nhất"
echo "  2 - Alpha mới nhất"
echo "  3 - Stable v23 - Không khuyến khích"
echo "  4 - Cài đặt Offline (Alpha 23016)"
pd green "* Bạn sẽ tải magisk.apk và cài đặt Magisk"
p none "[CHỌN]: "

}



}


LANGUAGE="$(getprop persist.sys.locale)"
case "$LANGUAGE" in
"vi-VN")
    language_vn
    ;;
esac


mount_rw_system(){
if mount | grep -q rootfs; then
# legacy rootfs
mount -o rw,remount "$SYSTEMDIR"
else
# system-as-root, mount "/"
mount -o rw,remount "$SYSTEMROOTDIR"
fi
}

mount_ro_system(){
if mount | grep -q rootfs; then
# legacy rootfs
mount -o ro,remount "$SYSTEMDIR"
else
# system-as-root, mount "/"
mount -o ro,remount "$SYSTEMROOTDIR"
fi
}


mkshrc(){
# Copyright (c) 2010, 2012, 2013, 2014
#	Thorsten Glaser <tg@mirbsd.org>
# This file is provided under the same terms as mksh.
#-
# Minimal /system/etc/mkshrc for Android
#
# Support: https://launchpad.net/mksh

set +o nohup

if (( USER_ID )); then export PS1='$'; else export PS1='#'; fi
export PS4='[$EPOCHREALTIME] '; export PS1='${|
	local e=$?
   HOSTNAME="HuskyDG"
	(( e )) && REPLY+="$e|"

	return $e
}$HOSTNAME:${PWD:-?} '"$PS1 "
}

p(){
COLOR=$1;TEXT="$2";escape="$1"
[ "$COLOR" == "black" ] && escape="0;30"
[ "$COLOR" == "red" ] && escape="0;31"
[ "$COLOR" == "green" ] && escape="0;32"
[ "$COLOR" == "orange" ] && escape="0;33"
[ "$COLOR" == "blue" ] && escape="0;34"
[ "$COLOR" == "purple" ] && escape="0;35"
[ "$COLOR" == "cyan" ] && escape="0;36"
[ "$COLOR" == "light_gray" ] && escape="0;37"
[ "$COLOR" == "gray" ] && escape="1;30"
[ "$COLOR" == "light_red" ] && escape="1;31"
[ "$COLOR" == "light_green" ] && escape="1;32"
[ "$COLOR" == "yellow" ] && escape="1;33"
[ "$COLOR" == "light_blue" ] && escape="1;34"
[ "$COLOR" == "light_purple" ] && escape="1;35"
[ "$COLOR" == "light_cyan" ] && escape="1;36"
[ "$COLOR" == "white" ] && escape="1;37"
[ "$COLOR" == "none" ] && escape="0"
code="\033[${escape}m"
end_code="\033[0m"
echo -en "$code$TEXT$end_code"
}

random(){
VALUE=$1; TYPE=$2; PICK="$3"; PICKC="$4"
TMPR=""
HEX="0123456789abcdef"; HEXC=16
CHAR="qwertyuiopasdfghjklzxcvbnm"; CHARC=26
NUM="0123456789"; NUMC=10
COUNT=$(seq 1 1 $VALUE)
list_pick=$HEX; C=$HEXC
[ "$TYPE" == "char" ] &&  list_pick=$CHAR && C=$CHARC 
[ "$TYPE" == "number" ] && list_pick=$NUM && C=$NUMC 
[ "$TYPE" == "custom" ] && list_pick="$PICK" && C=$PICKC 
      for i in $COUNT; do
          random_pick=$(( $RANDOM % $C))
          echo -n ${list_pick:$random_pick:1}
      done

}



md5code_get(){
FILE=$1
if [ -x "$tbox" ]; then
rawcode=`$tbox md5sum $FILE`
else
rawcode=`/system/xbin/busybox md5sum $FILE`
fi
for e in $rawcode; do
echo $e; break
done
}

mod_prop(){
NAME=$1; VARPROP=$2; FILE="$3"; [ ! "$FILE" ] && FILE=/tool_files/system.prop
if [ "$NAME" ] && [ ! "$NAME" == "=" ]; then
touch $FILE 2>/dev/null
echo "$NAME=$VARPROP" | while read prop; do export newprop=$(echo ${prop} | cut -d '=' -f1); sed -i "/${newprop}/d" $FILE; cat="`cat $FILE`"; echo $prop > $FILE; echo -n "$cat" >>$FILE; done 2>/dev/null
fi
}



del_prop(){
NAME=$1; FILE="$2"; [ ! "$FILE" ] && FILE=/tool_files/system.prop
noneprop="$NAME="
nonepropn="$noneprop\n"
if [ "$NAME" ] && [ ! "$NAME" == "=" ]; then
sed -i "/${nonepropn}/d" $FILE 2>/dev/null
sed -i "/${noneprop}/d" $FILE 2>/dev/null
fi
}


pd(){
p "$1" "$2"; echo
}



abortc(){
pd "$1" "$2"; pd yellow "Process exit with error - Enter to exit"; read; exit 1
}


if [ "$USER_ID" != "0" ]; then
pd yellow "$text_obtain_root..."
( su -c "$SCRIPT" || /system/xbin/su -c "$SCRIPT" || /system/bin/su -c "$SCRIPT" || /sbin/su -c "$SCRIPT" ) 2>/dev/null
ERR_CODE="$?"
if [ "$ERR_CODE" != 0 ]; then
clear
abortc "light_red" "$text_obtain_root_failed"
read
fi
exit
fi

SDK="$(getprop ro.build.version.sdk)"

MAGISK_TMP="$(magisk --path)"
MAGISKDIR="$MAGISK_TMP/.magisk"
[ "$MAGISK_TMP" ] && MAGISK_MIRROR="$MAGISKDIR/mirror"
SYSTEMDIR="$MAGISK_MIRROR/system"
SYSTEMROOTDIR="$MAGISK_MIRROR/system_root"


priv_dir=/data/data/io.github.huskydg.magiskonnox
cd "$priv_dir"
DLPATH="$priv_dir/magisk"

if [ ! -d "$DLPATH" ]; then
rm -rf "$DLPATH" 2>/dev/null
mkdir -p "$DLPATH" 2>/dev/null
fi

stable_magisk_link="https://cdn.jsdelivr.net/gh/topjohnwu/magisk-files@23.0/app-release.apk"
canary_magisk_link="https://github.com/topjohnwu/magisk-files/blob/canary/app-debug.apk?raw=true"
alpha_magisk_link="https://github.com/vvb2060/magisk_files/blob/alpha/app-release.apk?raw=true"

# This script is write by HuskyDG
ARG1="$1"
JOBPWD="${0%/*}"
bb=/data/local/tmp/busybox
TMPDIR=/dev/tmp_magisk
APKFILE="$JOBPWD/magisk.apk"
MAGISKCORE="$MAGISK_MIRROR/system/etc/magisk"


abort(){
echo "$1" ; exit 1
}

link(){ (
agv1="$1"; agv2="$2"
[ ! -f "$DLPATH/$agv2" ] && rm -rf "$DLPATH/$agv2" 2>/dev/null
ln -s "$(which "$agv1")" "$DLPATH/$agv2" 2>/dev/null
) }

link "libapp.so" "magisk.apk"
link "libbusybox.so" "busybox"
bb="$DLPATH/busybox"

clean_flash(){
umount -l "$TMPDIR"
rm -rf "$TMPDIR"
}

install_magisk(){
echo "******************************"
echo "      Magisk installer"
echo "******************************"

overlay_loader="#!/system/bin/sh

export PATH=/sbin:/system/bin:/system/xbin

mnt_tmpfs(){ (
# MOUNT TMPFS ON A DIRECTORY
MOUNTPOINT=\"\$1\"
mkdir -p \"\$MOUNTPOINT\"
mount -t tmpfs -o \"mode=0755\" tmpfs \"\$MOUNTPOINT\"
) }


mnt_bind(){ (
# SHORTCUT BY BIND MOUNT
FROM=\"\$1\"; TO=\"\$2\"
if [ -L \"\$FROM\" ]; then
SOFTLN=\"\$(readlink \"\$FROM\")\"
ln -s \"\$SOFTLN\" \"\$TO\"
elif [ -d \"\$FROM\" ]; then
mkdir -p \"\$TO\" 2>/dev/null
mount --rbind \"\$FROM\" \"\$TO\"
else
echo -n 2>/dev/null >\"\$TO\"
mount --rbind \"\$FROM\" \"\$TO\"
fi
) }

clone(){ (
FROM=\"\$1\"; TO=\"\$2\"; IFS=\$\"
\"
[ -d \"\$TO\" ] || exit 1;
( cd \"\$FROM\" && find * ) | while read obj; do
if [ -d \"\$FROM/\$obj\" ]; then
mnt_tmpfs \"\$TO/\$obj\"
else
mnt_bind \"\$FROM/\$obj\" \"\$TO/\$obj\" 2>/dev/null
fi
done
) }

overlay(){ (
# RE-OVERLAY A DIRECTORY
FOLDER=\"\$1\";
TMPFOLDER=\"/dev/vm-overlay\"
#_____
PAYDIR=\"\$TMPFOLDER/\$RANDOM_\$(date | base64)\"
mkdir -p \"\$PAYDIR\"
mnt_tmpfs \"\$PAYDIR\"
#_________
clone \"\$FOLDER\" \"\$PAYDIR\"
mnt_bind \"\$PAYDIR\" \"\$FOLDER\"
#______________
) }

mount -o rw,remount /
rm -rf /root
mkdir /root
ln /sbin/* /root
mount -o ro,remount /

mnt_tmpfs /sbin
clone /root /sbin

chcon u:r:rootfs:s0 /sbin
cd /system/etc/magisk
MAGISKTMP=/sbin
MAGISKBIN=/data/adb/magisk
mkdir -p \$MAGISKBIN
for mdir in modules post-fs-data.d service.d; do
mkdir /data/adb/\$mdir
done

for file in magisk32 magisk64 magiskinit; do
  chmod 755 ./\$file
  cp -af ./\$file \$MAGISKTMP/\$file
  cp -af ./\$file \$MAGISKBIN/\$file
done
cp -af ./magiskboot \$MAGISKBIN/magiskboot
cp -af ./busybox \$MAGISKBIN/busybox
cp -af ./loadpolicy.sh \$MAGISKTMP

ln -s ./magisk64 \$MAGISKTMP/magisk
ln -s ./magisk \$MAGISKTMP/su
ln -s ./magisk \$MAGISKTMP/resetprop
ln -s ./magisk \$MAGISKTMP/magiskhide
ln -s ./magiskinit \$MAGISKTMP/magiskpolicy

mkdir -p \$MAGISKTMP/.magisk/mirror
mkdir \$MAGISKTMP/.magisk/block
touch \$MAGISKTMP/.magisk/config

cd \$MAGISKTMP
# SELinux stuffs
ln -sf ./magiskinit magiskpolicy
if [ -f /vendor/etc/selinux/precompiled_sepolicy ]; then
  ./magiskpolicy --load /vendor/etc/selinux/precompiled_sepolicy --live --magisk 2>&1
elif [ -f /sepolicy ]; then
  ./magiskpolicy --load /sepolicy --live --magisk 2>&1
else
  ./magiskpolicy --live --magisk 2>&1
fi

touch /dev/.overlay_unblock"

cd "$JOBPWD"
shloadpolicy="#!/system/bin/sh
          for module in \$(ls /data/adb/modules); do
              if ! [ -f \"/data/adb/modules/\$module/disable\" ] && [ -f \"/data/adb/modules/\$module/sepolicy.rule\" ]; then
                  /sbin/magiskpolicy --live --apply \"/data/adb/modules/\$module/sepolicy.rule\"
              fi
          done"

magiskloader="on post-fs-data
              start logd
              start adbd
              rm /dev/.overlay_unblock
              start magiskoverlay
              wait /dev/.overlay_unblock 10
              rm /dev/.overlay_unblock
              
              rm /dev/.magisk_unblock
              start IhhslLhHYfse
              start FAhW7H9G5sf
              wait /dev/.magisk_unblock 40
              rm /dev/.magisk_unblock

          service magiskoverlay /system/bin/sh /system/etc/magisk/overlay.sh
             user root
             group root
             oneshot

          service IhhslLhHYfse /system/bin/sh /sbin/loadpolicy.sh
              user root
              seclabel u:r:magisk:s0
              oneshot

          service FAhW7H9G5sf /sbin/magisk --post-fs-data
              user root
              seclabel u:r:magisk:s0
              oneshot

          service HLiFsR1HtIXVN6 /sbin/magisk --service
              class late_start
              user root
              seclabel u:r:magisk:s0
              oneshot

          on property:sys.boot_completed=1
              start YqCTLTppv3ML

          service YqCTLTppv3ML /sbin/magisk --boot-complete
              user root
              seclabel u:r:magisk:s0
              oneshot"



[ "$(whoami)" == "root" ] || abort "! Run script as root only"

echo "- $text_mount_rw_system"
mount_rw_system || abort "! $text_failed_mount_system"

echo "- $text_setup"
rm -rf "$MAGISKCORE"
mkdir -p "$MAGISKCORE"
chown root:root "$MAGISKCORE"
chmod 750 "$MAGISKCORE"

chmod 777 $bb
mkdir $TMPDIR

$bb unzip -oj "$APKFILE" 'assets/util_functions.sh' -d "$TMPDIR"
MAGISK_VER=""
MAGISK_VER_CODE=""
[ -f "$TMPDIR/util_functions.sh" ] || abort "! This apk is not Magisk app"
. $TMPDIR/util_functions.sh
pd green "- Magisk version: $MAGISK_VER ($MAGISK_VER_CODE)"


api_level_arch_detect

echo "- $text_extract_magisk_apk"

[ "$IS64BIT" == "true" ] && mkdir -p "$TMPDIR/magisk32"
mkdir -p "$TMPDIR/magisk"


$bb unzip -oj "$APKFILE" "lib/$ABI/*" -x "lib/$ABI/busybox.so" -d "$TMPDIR/magisk"
chmod -R 777 "$TMPDIR/magisk"
ln -s "./libmagiskinit.so" "$TMPDIR/magisk/magiskinit"

if [ "$IS64BIT" == "true" ]; then
$bb unzip -oj "$APKFILE" "lib/$ABI32/*" -x "lib/$ABI/busybox.so" -d "$TMPDIR/magisk32"
ln -s "./libmagiskinit.so" "$TMPDIR/magisk32/magiskinit"
chmod -R 777 "$TMPDIR/magisk32"
fi

( cd "$TMPDIR/magisk"
for file in lib*.so; do
  chmod 755 $file
  mv "$file" "$MAGISKCORE/${file:3:${#file}-6}" && echo "  add magisk binary: ${file:3:${#file}-6}"
done

if [ "$IS64BIT" == "true" ]; then
cd "$TMPDIR/magisk32"
for file in lib*.so; do
  chmod 755 $file
  [ ! -f "$MAGISKCORE/${file:3:${#file}-6}" ] && mv "$file" "$MAGISKCORE/${file:3:${#file}-6}" && echo "  add magisk binary: ${file:3:${#file}-6}"
done

fi

if [ ! -f "$MAGISKCORE/magisk64" ] && [ "$IS64BIT" == "true" ]; then
"$TMPDIR/magisk/magiskinit" -x magisk "$MAGISKCORE/magisk64" && echo "  add magisk binary: magisk64"
fi

if [ ! -f "$MAGISKCORE/magisk32" ]; then
    whatmagisk="magisk"
    [ "$IS64BIT" == "true" ] && whatmagisk="magisk32"
"$TMPDIR/$whatmagisk/magiskinit" -x magisk "$MAGISKCORE/magisk32" && echo "  add magisk binary: magisk32"
fi

)


mkdir -p $MAGISKBIN 2>/dev/null
$bb unzip -oj "$APKFILE" 'assets/*' -x 'assets/chromeos/*' -d $MAGISKBIN
mkdir $NVBASE/modules 2>/dev/null
mkdir $POSTFSDATAD 2>/dev/null
mkdir $SERVICED 2>/dev/null


echo "- Install Magisk loader..."
rm -rf $MAGISKCORE/overlay.sh
echo "$overlay_loader" >"$MAGISKCORE/overlay.sh"
rm -rf "$MAGISK_MIRROR/system/etc/init/magisk.rc"
echo "$magiskloader" >"$MAGISK_MIRROR/system/etc/init/magisk.rc"
rm -rf "$MAGISKCORE/loadpolicy.sh"
echo "$shloadpolicy" >"$MAGISKCORE/loadpolicy.sh"
echo "- $text_mount_ro_system"
mount_ro_system
clean_flash
echo "- $text_install_app..."
pm uninstall com.topjohnwu.magisk &>/dev/null
pm install "$APKFILE" &>/dev/null || echo "* $text_install_app_sug"
mkdir -p "/sdcard/Magisk"
rm -rf "/sdcard/Magisk/Magisk.apk"
cp "$APKFILE" "/sdcard/Magisk/Magisk.apk"
echo "- $text_saved_magisk_apk_to /sdcard/Magisk/Magisk.apk"
echo "- $text_done"
pd yellow "$text_press_enter_menu"
read
}

uninstall_magisk(){
echo "******************************"
echo "      Magisk uninstaller"
echo "******************************"
echo "- $text_mount_rw_system"
mount_rw_system || abort "! $text_failed_mount_system"
echo "- Remove Magisk..."
for fun in /system/etc/magisk /system/etc/init/magisk.rc; do
rm -rf "$MAGISK_MIRROR/$fun"
done
ADDOND=/system/addon.d/99-magisk.sh
if [ -f $ADDOND ]; then
  rm -f "$MAGISK_MIRROR/$ADDOND"
fi
echo "- $text_mount_ro_system"
mount_ro_system
echo "- $text_rm_magisk_files"
rm -rf \
/cache/*magisk* /cache/unblock /data/*magisk* /data/cache/*magisk* /data/property/*magisk* \
/data/Magisk.apk /data/busybox /data/custom_ramdisk_patch.sh /data/adb/*magisk* \
/data/adb/post-fs-data.d /data/adb/service.d /data/adb/modules* \
/data/unencrypted/magisk /metadata/magisk /persist/magisk /mnt/vendor/persist/magisk
cd /
  echo "********************************************"
  warn_reboot
  echo "********************************************"
(sleep 8; /system/bin/reboot)&
echo "- $text_done"
pd yellow "$text_press_enter_menu"
read
}




install_option(){
clear
print_menu_install
read build
install_magisk=true
install_offline=false
case $build in
1)
    URL="$canary_magisk_link"
    ;;
2)
    URL="$alpha_magisk_link"
    ;;
3)
    URL="$stable_magisk_link"
    ;;
4)
    install_offline=true
    ;;
*)
    install_magisk=false
    ;;
esac

if [ "$install_magisk" == "true" ]; then
    if [ "$install_offline" == "true" ]; then
    APKFILE="$DLPATH/magisk.apk"
    clear
    ( install_magisk ) 2>/dev/null
    else
    ( clear
    echo "- Downloading Magisk APK..."
    rm -rf "$DLPATH/app.tmp"
    rm -rf "$DLPATH/app.apk"
    $bb wget -O "$DLPATH/app.tmp" "$URL" &>/dev/null && mv -f "$DLPATH/app.tmp" "$DLPATH/app.apk" 2>/dev/null
    [ -f "$DLPATH/app.apk" ] || abortc none "! Cannot download Magisk APK"
    APKFILE="$DLPATH/app.apk"
    install_magisk
    )
    fi
fi

    


}



main(){
clear
print_menu
read option
case $option in
1)
    install_option
    ;;
2)
    p none "$text_warn_uninstall_magisk <Y/n> "
    read uni
    if [ "$uni" == "y" -o "$uni" == "Y" ]; then
    clear
    ( uninstall_magisk )
    fi
    ;;
3)
   rm -rf "$DLPATH/fmm.apk"
   cp "$MYPATH/libmm.so" "$DLPATH/fmm.apk"
    pm install "$DLPATH/fmm.apk" &>/dev/null && pd light_green "$text_success_mm" || pd light_red "$text_cannot_mm"
    pd yellow "$text_press_enter_menu"
    read
    ;;
*)
    exit 0
    ;;
esac
}


while true; do main; done
true