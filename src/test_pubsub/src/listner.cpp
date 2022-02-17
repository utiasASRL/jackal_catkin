
#include "ros/ros.h"
#include "vox_msgs/VoxGrid.h"

/**
 * This tutorial demonstrates simple receipt of messages over the ROS system.
 */
void chatterCallback(const vox_msgs::VoxGrid::ConstPtr& msg)
{
  ROS_INFO("I heard");
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "listener");

  /**
   * NodeHandle is the main access point to communications with the ROS system.
   * The first NodeHandle constructed will fully initialize this node, and the last
   * NodeHandle destructed will close down the node.
   */

  ROS_WARN("_________STARTED TEST LISTNER NODE_________");
  ros::NodeHandle n;
  ros::Subscriber sub = n.subscribe("/plan_costmap_3D", 1000, chatterCallback);

// %Tag(SPIN)%
  ros::spin();
// %EndTag(SPIN)%

  return 0;
}
// %EndTag(FULLTEXT)%