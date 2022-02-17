#!/bin/bash

# Arg to specify the name of the waypoints file to follow. If no such file exists, 
# then we wait for the user to set waypoints for this new file
waypoints="default_no_given"

while getopts w: option
do
case "${option}"
in
w) waypoints=${OPTARG};;
esac
done

# Start the node in nohup mdode
source /etc/ros/setup.bash
source /opt/ros/melodic/setup.bash
source ~/catkin_ws/devel/setup.bash
# echo ""
# echo "Running PointSlam"
# if [ "$colli" = true ] ; then
#     nohup roslaunch point_slam point_slam.launch filter:="false" > "nohup_point_slam.txt" 2>&1 &
# else
#     nohup roslaunch point_slam point_slam.launch filter:="false" > "nohup_point_slam.txt" 2>&1 &
# fi


#
########################################################
# Note this script only handles waypoint following now #
########################################################
#

# # Waiting for pointslam initialization
# echo ""
# echo "Waiting for pointslam initialization ..."

# map_topic=$(rostopic list -p | grep "/map")
# until [ -n "$map_topic" ] 
# do 
#     sleep 0.5
#     map_topic=$(rostopic list -p | grep "/map")
# done 

# echo "OK"

echo ""
echo "Running waypoint follower"
nohup roslaunch follow_waypoints follow_waypoints.launch waypoint_file:="$waypoints" > "nohup_waypoint.txt" 2>&1 &
echo "OK"
# xterm -bg black -fg lightgray -xrm "xterm*allowTitleOps: false" -T "follow_waypoints" -n "follow_waypoints" -hold \
#     -e roslaunch follow_waypoints follow_waypoints.launch waypoint_file:="$waypoints" &


if [ $waypoints = "default_no_given" ]; then

    echo ""
    echo "No waypoint given. This tour wont be recorded"
    echo "Use rviz 2D Nav goal or the controller to move the robot."
    echo ""

else

    # Check if the waypoint file exists
    if [ ! -f "../src/follow_waypoints/saved_path/$waypoints.csv" ]; then

        echo ""
        echo "Creating for new waypoints: $waypoints.csv"
        echo "Use rviz 2D Pose estimate tools to create a succession of waypoints."
        echo ""
        echo "Are you satisfied with your waypoints? [y/n]"
        read -p "Answer:" choice
        echo ""
        new_waypoints=false
        case "$choice" in 
            y|Y ) new_waypoints=true;;
            n|N ) new_waypoints=false;;
            * ) new_waypoints=false;;
        esac

        if [ "$new_waypoints" = true ] ; then

            echo "starting run with these new waypoints"
            rostopic pub /path_ready std_msgs/Empty -1
        else
            echo "Aborting run"
            ./stop_exp.sh
        fi

    else

        echo ""
        echo "Using saved waypoints: $waypoints.csv"
        rostopic pub /start_journey std_msgs/Empty -1

    fi

fi

echo "Done"
echo ""

