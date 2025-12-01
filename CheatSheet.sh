#!/bin/bash

section="$1"

if [ "$section" == "files" ]; then
    echo "Files Commands:"
    echo "ls - List directory contents"
    echo "cp - Copy files and directories"
    echo "mv - Move or rename files and directories"
    echo "rm - Remove files or directories"
elif [ "$section" == "network" ]; then
    echo "Network Commands:"
    echo "ping - Check network connectivity"
    echo "ifconfig - Display network interfaces"
    echo "netstat - Show network status"
    echo "curl - Transfer data from or to a server"
elif [ "$section" == "processes" ]; then
    echo "Processes Commands:"
    echo "ps - Display current processes"
    echo "top - Show real-time system processes"
    echo "kill - Terminate a process"
    echo "htop - Interactive process viewer"
else
    echo "Usage: $0 {files|network|processes}"
fi   

