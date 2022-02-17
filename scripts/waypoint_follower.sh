#!/bin/bash

echo "-----------------------------------------------------------------"
echo "use saved argument to use previously saved waypoints"
echo "use new argument to start foillowing the newly specified waypoints"
echo "-----------------------------------------------------------------"
echo ""

source ~/catkin_ws/devel/setup.bash

if [ $1 = "saved" ]
then
    echo "Waypoint Follower";
    echo ""
    echo "Using SAVED waypoints!"
    echo ""
    rostopic pub /start_journey std_msgs/Empty -1
fi

if [ $1 = "new" ]
then
    echo "Waypoint Follower";
    echo ""
    echo "Using newly specified waypoints!"
    echo ""
    rostopic pub /path_ready std_msgs/Empty -1
fi

