#!/bin/bash

# Target device MAC
DEVICE="ADD_YOUR_DEVICE_MAC"

# Power on and enable agent
bluetoothctl power on
bluetoothctl agent on

# Remove old pairing
bluetoothctl remove "$DEVICE" 2>/dev/null

# Scan with discovery (this is the key!)
bluetoothctl --timeout 20 scan on & sleep 3

# Pair and connect
{
    bluetoothctl pair "$DEVICE"
    bluetoothctl trust "$DEVICE"
    bluetoothctl connect "$DEVICE"
} 2>/dev/null

# Simple status check
if bluetoothctl info "$DEVICE" | grep -q "Connected: yes"; then
    echo "Success! Device connected."
else
    echo "Failed. Make sure device is in pairing mode and nearby."
fi

exit 0
