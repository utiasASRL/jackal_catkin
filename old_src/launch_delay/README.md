While no substitute for a fault-tolerant driver, it is possible to delay the launch of a ROS node until a 
connected peripheral is ready to communicate.  This usually comes up when the computer and sensor are powered 
on at the same time, and the computer starts up faster than the sensor.  In a situation like this, the driver 
will try to talk to the sensor, receive a reply it doesn't like (or none at all), then promptly crash flat 
on its face.  Using this script, a launch file may be called any number of seconds after the delay script launches.

# Installation

Create a catkin workspace, then use wstool to install the script from source:

```
cd ~/sensors_ws/src
wstool set launch_delay --git https://bitbucket.org/clearpathrobotics/launch_delay.git
wstool update launch_delay
cd ..
catkin_make 
```

The launch_delay launch file may now be moved into the husky-core.d directory:

```
roscd launch_delay/launch 
sudo cp delayed_launch.launch /etc/ros/indigo/husky-core.d 
```

# Customizing

Finally, the launch file needs to be edited to point at the desired sensor launch file.  In the args line, 
there are three parameters to change:  the time delay ("15"), the package where the launch file is located 
("delayed_package"), and the launch file itself ("delayed_file.launch").  You may choose launch files in 
packages installed from source or from debs.  If there is a husky customization package already present on 
the computer, you can put all your customized launch files in a /launch directory there, and point the delay 
script at that package.  You may also change the name ("package_delay") to something more unique to the sensor.
If there is more than one sensor that requires a delay, you can launch multiple instances of the script from 
within the delayed_launch.launch file.  Simply copy the <node></node> portion as many times as needed, and 
give each instance a different name.
