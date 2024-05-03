#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <pod_name> [image_name]"
    exit 1
fi

# Find the Container ID based on the provided name or ID
CONTAINER=$(docker ps | grep -v "/pause" | grep "$1" | head -1 | awk '{print $1}')

# Check if the container ID is found
if [ -z "$CONTAINER" ]; then
    echo "Pod with name \"$1\" not found or is not running."
    exit 1
fi

# Set the default image name
image_name="dev-docker.local/alpine-tcpdump:latest"

# Check if the second argument is provided and replace the image name if provided
if [ ! -z "$2" ]; then
    image_name="$2"
fi

cpu_quota_us=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
cpu_quota_ms=$((cpu_quota_us / 10000))
cpu_quota=$(awk "BEGIN {printf \"%.1f\", $cpu_quota_ms / 10}")

memory_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
memory_quota=$((memory_in_bytes / 1000000))m

# Run tcpdump in a container, connecting to the network namespace of the specified container
docker run -it --rm -v /tmp:/tmp/tcpdump/ --cpus=$cpu_quota --memory=$memory_quota --cap-add=NET_ADMIN --cap-add=CAP_NET_RAW --net container:"$CONTAINER" $image_name 
