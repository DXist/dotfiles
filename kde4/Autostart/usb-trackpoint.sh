#!/usr/bin/env bash

usb_trackpoint_id=`xinput list --id-only "pointer:Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint"`

# xinput set-prop ${usb_trackpoint_id} "Device Accel Profile" 2
# xinput set-prop ${usb_trackpoint_id} "Device Accel Velocity Scaling" 15
xinput set-prop ${usb_trackpoint_id} "Device Accel Profile" 2
xinput set-prop ${usb_trackpoint_id} "Device Accel Velocity Scaling" 75
xinput set-prop ${usb_trackpoint_id} 'Device Accel Constant Deceleration' 2
xinput set-prop ${usb_trackpoint_id} "Evdev Wheel Emulation" 1
xinput set-prop ${usb_trackpoint_id} "Evdev Wheel Emulation Button" 2
