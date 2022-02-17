#!/bin/bash

source ~/catkin_ws/devel/setup.bash
nohup roslaunch point_slam point_slam.launch > "nohup_point_slam.txt" 2>&1 &

cd ~/catkin_ws/scripts/
nohup ./rosbag_record.sh > "nohup_record.txt" 2>&1 &