#!/bin/sh
if grep 'mnt/samba' /proc/mounts; then 
  echo "disk is already mounted!"
else
  mount 10.20.30.4:mnt/some-disk mnt/samba
fi
