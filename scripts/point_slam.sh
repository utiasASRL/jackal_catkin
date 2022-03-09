#!/bin/bash

source /etc/ros/setup.bash
source /opt/ros/melodic/setup.bash
source ~/catkin_ws/devel/setup.bash

nohup=false
newmap=false

while getopts nm option
do
case "${option}"
in
n) nohup=true;;
m) newmap=true;;
esac
done

mycommand="roslaunch point_slam point_slam.launch filter:=false"
if [ "$newmap" = false ] ; then
    mycommand="$mycommand init_map_path:=/home/administrator/1-Deep-Collider/results/runs/Myhal/map_Myhal_1.ply"
fi

echo "---------   $mycommand"

if [ "$nohup" = true ] ; then
    nohup $mycommand > "nohup_point_slam.txt" 2>&1 &
else
    $mycommand
fi