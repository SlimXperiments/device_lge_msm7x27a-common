#!/system/bin/sh

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

# dump the baseband name into a file, so we don't use grep at every boot
if [ ! -f ".baseband" ]
then
    # we only support the V20 baseband
    echo `strings "/dev/block/mmcblk0p12" | grep -e "-V20.-" | head -1` > ".baseband"
fi
setprop gsm.version.baseband `cat ".baseband"`
