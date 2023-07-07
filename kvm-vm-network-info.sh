#!/bin/bash

# This script assumes that the VM name is identical to its hostname
# for the IP address retrieval to work.

echo "Online VMs:"
# get list of all online VMs
online_vms=$(virsh list --all | grep running | awk '{print $2}')

# iterate over online VMs
for vm in $online_vms; do
    echo "VM Name: $vm"
    echo "Status: Running"

    # get network interfaces of each VM
    iface_info=$(virsh domiflist $vm | tail -n +3 | head -n -1)

    # iterate over network interfaces
    while read -r line; do
        iface=$(echo "$line" | awk '{print $1}')
        mac=$(echo "$line" | awk '{print $5}')
        source=$(echo "$line" | awk '{print $3}')

        # get network name from the source (network bridge)
        net_name=$(virsh net-list --all | grep -oP '^\s*\K\S+(?=\s+active)')

        # use getent to get the IP address, assumes VM name = hostname
        ip_addr=$(getent hosts $vm | awk '{ print $1 }')

        # get network traffic statistics
        net_stats=$(virsh domifstat $vm $iface | tail -n +3)

        # list information in a logical order similar to ip a or nmcli
        echo "    IP Address: $ip_addr"
        echo "    Network Interface (MAC): $mac"
        echo "    Network Name: $net_name"
        echo "    Network Source (Bridge): $source"
        echo "    Network Statistics:"

        while read -r stat; do
            key=$(echo "$stat" | awk '{print $2}')
            value=$(echo "$stat" | awk '{print $3}')
            case "$key" in
            "rx_bytes"|"tx_bytes")
                # convert bytes to more human-friendly units
                if [ $value -gt 1000000000 ]; then
                    value=$(echo "scale=2; $value/1000000000" | bc)
                    unit="GB"
                elif [ $value -gt 1000000 ]; then
                    value=$(echo "scale=2; $value/1000000" | bc)
                    unit="MB"
                elif [ $value -gt 1000 ]; then
                    value=$(echo "scale=2; $value/1000" | bc)
                    unit="KB"
                else
                    unit="bytes"
                fi
                echo "        $key: $value $unit"
                ;;
            *)
                # display other statistics as is
                echo "        $stat"
                ;;
            esac
        done <<< "$net_stats"

    done <<< "$iface_info"

    echo ""
done
