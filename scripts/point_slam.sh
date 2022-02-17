#!/bin/bash

source /etc/ros/setup.bash
source /opt/ros/melodic/setup.bash
source ~/catkin_ws/devel/setup.bash

nohup=false

while getopts n option
do
case "${option}"
in
n) nohup=true;;
esac
done

if [ "$nohup" = true ] ; then
    nohup roslaunch point_slam point_slam.launch filter:="false" > "nohup_point_slam.txt" 2>&1 &
else
    roslaunch point_slam point_slam.launch filter:="false"
fi