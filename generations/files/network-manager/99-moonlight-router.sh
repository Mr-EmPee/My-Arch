#!/bin/bash

# Extract variables provided natively by NetworkManager
INTERFACE=$1
ACTION=$2

# CONFIGURATION: Set the profile names of your connections exactly as they appear in nmcli
TEST_NET_PROFILE="Gaming-Internal"
LAN_PROFILE="Vodafone-A85307373"

# Path to the targeted configuration line
HOSTS_FILE="/etc/hosts"
HOSTNAME_TARGET="gaming-rig"

# Only run if a connection interface has fully transitioned up
if [ "$ACTION" = "up" ]; then

    # Check if the connecting profile matches your experimental network
    if [ "$CONNECTION_ID" = "$TEST_NET_PROFILE" ]; then
        # Remove old pointer and append the 203.0.113.1 destination
        sed -i "/$HOSTNAME_TARGET/d" "$HOSTS_FILE"
        echo "203.0.113.1    $HOSTNAME_TARGET" >> "$HOSTS_FILE"
        logger -t NM_MOONLIGHT "Switched gaming-rig to documentation IP 203.0.113.1"
        
    # Check if connecting profile matches your primary home subnet
    elif [ "$CONNECTION_ID" = "$LAN_PROFILE" ]; then
        # Remove old pointer and append the 192.168.137.1 destination
        sed -i "/$HOSTNAME_TARGET/d" "$HOSTS_FILE"
        echo "192.168.137.1    $HOSTNAME_TARGET" >> "$HOSTS_FILE"
        logger -t NM_MOONLIGHT "Switched gaming-rig to local LAN IP 192.168.137.1"
    fi
fi

