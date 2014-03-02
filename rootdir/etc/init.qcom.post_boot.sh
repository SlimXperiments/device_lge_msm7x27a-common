#!/system/bin/sh
# Copyright (c) 2009-2012, The Linux Foundation. All rights reserved.
# Copyright (c) 2014, TeamHackLG
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`
case "$target" in
    "msm7x27a")
         echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
         #echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
    ;;
esac

case "$target" in
    "msm7x27a")
        available_frequencies=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`
        if [[ ${available_frequencies} == *\ 196608\ * ]]
        then
            echo 196608 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        else
            echo 245760 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        fi
    ;;
esac

chown system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy

emmc_boot=`getprop ro.boot.emmc`
case "$emmc_boot" in
    "true")
        chown system /sys/devices/platform/rs300000a7.65536/force_sync
        chown system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown system /sys/devices/platform/rs300100a7.65536/force_sync
        chown system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

case "$target" in
    "msm7x27a")
        echo 10 > /sys/devices/platform/msm_sdcc.1/idle_timeout
    ;;
esac

# Enable Power modes and set the CPU Freq Sampling rates
case "$target" in
    "msm7x27a")
        start qosmgrd
        echo 1 > /sys/module/pm2/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/pm2/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/pm2/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/pm2/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/pm2/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/pm2/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/pm2/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/pm2/modes/cpu3/standalone_power_collapse/suspend_enabled
        #SuspendPC:
        echo 1 > /sys/module/pm2/modes/cpu0/power_collapse/suspend_enabled
        #IdlePC:
        echo 1 > /sys/module/pm2/modes/cpu0/power_collapse/idle_enabled
        #echo 25000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
    ;;
esac

# Post-setup services
case "$target" in
    "msm7x27a")
        soc_id=`cat /sys/devices/system/soc/soc0/id`
        case "$soc_id" in
            "127" | "128" | "129")
                start mpdecision
            ;;
        esac
    ;;
esac

case "$target" in
    "msm7x27a")
        soc_id=`cat /sys/devices/system/soc/soc0/id`
        ver=`cat /sys/devices/system/soc/soc0/version`
        case "$soc_id" in
            "127" | "128" | "129" | "137" | "167" )
                if [ "$ver" = "2.0" ]; then
                    start thermald
                fi
            ;;
        esac
        case "$soc_id" in
            "168" | "169" | "170" )
                start thermald
            ;;
        esac
    ;;
esac

# Change adj level and min_free_kbytes setting for lowmemory killer to kick in
case "$target" in
    "msm7x27a")
        echo 0,1,2,4,6,7 > /sys/module/lowmemorykiller/parameters/adj
        echo 4075,5437,6799,8847,11520,15360 > /sys/module/lowmemorykiller/parameters/minfree
        echo 5120 > /proc/sys/vm/min_free_kbytes
    ;;
esac

#fastrpc permission setting

if [ -f "/system/lib/modules/adsprpc.ko" ]
then
    insmod /system/lib/modules/adsprpc.ko
    chown system.system /dev/adsprpc-smd
    chmod 666 /dev/adsprpc-smd
fi
