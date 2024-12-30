#!/system/bin/sh

# Some performance tweaks.
sysctl -w kernel.sched_schedstats=0
echo off > /proc/sys/kernel/printk_devkmsg
for disks in /sys/block/*/queue; do
    # Don't log I/O statistics.
    echo 0 > "$disks/iostats" 
done

# Use "Explicit Congestion Notification" for both incoming and outgoing packets.
sysctl -w net.ipv4.tcp_ecn=1

# Use the best available TCP congestion algorithm.
sysctl -w net.ipv4.tcp_congestion_control=cubic
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.ipv4.tcp_congestion_control=bbr2
sysctl -w net.ipv4.tcp_congestion_control=bbr3

# Delete specific properties related to media resolution limits.
resetprop -p --delete media.resolution.limit.16bit
resetprop -p --delete media.resolution.limit.24bit
resetprop -p --delete media.resolution.limit.32bit

resetprop -p --delete audio.resolution.limit.16bit
resetprop -p --delete audio.resolution.limit.24bit
resetprop -p --delete audio.resolution.limit.32bit

# Disable audio safe volume.
settings put global audio_safe_volume_state 0

# Some other tweaks.
settings put global netstats_enabled 0