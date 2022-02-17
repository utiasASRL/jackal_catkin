#!/usr/bin/env python  
import rospy

import math
import tf2_ros
import geometry_msgs.msg
import turtlesim.srv


if __name__ == '__main__':
    rospy.init_node('tf2_turtle_listener')

    # tfBuffer = tf2_ros.Buffer()
    # listener = tf2_ros.TransformListener(tfBuffer)

    tf_buffer = tf2_ros.Buffer()
    tf_listener = tf2_ros.TransformListener(tf_buffer)


    rate = rospy.Rate(100.0)
    while not rospy.is_shutdown():
        try:
            trans = tf_buffer.lookup_transform('odom', 'velodyne', rospy.Time())
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException):
            rate.sleep()
            continue

        t_now = rospy.get_rostime().to_sec()



        t_trans = trans.header.stamp.to_sec()

        timediff = t_now - t_trans

        # if mean_timediff is None:
        #     mean_timediff = timediff
        # else:
        #     mean_timediff = 0.98 * mean_timediff + 0.02 * timediff

        # self.get_logger().warn(f'Current time {sec1}.{nsec1}, got tf at {sec2}.{nsec2}, time difference {timediff}')

        print('timediff {:.3f}'.format(timediff))

        rate.sleep()