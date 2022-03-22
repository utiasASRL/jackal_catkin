#!/bin/bash

source /etc/ros/setup.bash
source /opt/ros/melodic/setup.bash
source ~/catkin_ws/devel/setup.bash

nohup=false
filtering=false
mapfile=""

# Example of map files:  map_Myhal_1.ply  /  map_Myhal_5.ply

while getopts nfm: option
do
case "${option}"
in
n) nohup=true;;
f) filtering=true;;
m) mapfile=${OPTARG};;
esac
done

mycommand="roslaunch point_slam point_slam.launch filter:=$filtering"
if [ -n "$mapfile" ] ; then
    mycommand="$mycommand init_map_path:=/home/administrator/1-Deep-Collider/results/runs/Myhal/$mapfile"
fi

echo "---------   $mycommand"

if [ "$nohup" = true ] ; then
    nohup $mycommand > "nohup_point_slam.txt" 2>&1 &
else
    $mycommand
fi