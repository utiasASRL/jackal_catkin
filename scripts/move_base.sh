#!/bin/bash

# Arg to specify if we record this run or not
colli=false

while getopts c option
do
case "${option}"
in
c) colli=true;;
esac
done


source ~/catkin_ws/devel/setup.bash

if [ "$colli" = true ] ; then
    echo "Running move_base with modified TEB"
    roslaunch jackal_navigation teb_modified.launch
else
    echo "Running move_base with normal TEB"
    roslaunch jackal_navigation teb_normal.launch
fi