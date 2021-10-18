#!/bin/bash
# Post installation script to install dependencies needed to run the picreate robot.
# Aaron Maynard October 13th, 2021
echo [POST-INSTALLER] - $(date +"%T") - Starting post-installer script...
echo [POST-INSTALLER] - $(date +"%T") - Setting up ROS repositories...
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Command has changed to utilize Ubuntu keyserver as some may experience issues with ha.pool.kys-keyservers.net
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get upgrade -y
# Enable Pi Camera
sudo raspi-config nonint do_camera 0
# Bootstrap Dependencies
echo [POST-INSTALLER] - $(date +"%T") - Installing bootstrap dependencies...
sudo apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake
sudo rosdep init
rosdep update
# Installing ROS
echo [POST-INSTALLER] - $(date +"%T") - Installing ROS...
mkdir -p ~/catkin_ws
cd ~/catkin_ws
rosinstall_generator ros_comm --rosdistro melodic --deps --wet-only --tar > melodic-ros_comm-wet.rosinstall
wstool init src melodic-ros_comm-wet.rosinstall
rosdep install -y --from-paths src --ignore-src --rosdistro melodic -r --os=debian:buster
# Building catkin workspace
echo [POST-INSTALLER] - $(date +"%T") - Building catkin workspace...
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/melodic -j2
source /opt/ros/melodic/setup.bash
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
# Download and Install PiCreate packages
echo [POST-INSTALLER] - $(date +"%T") - Downloading PiCreate packages...
sudo apt-get install python-rosdep python-catkin-tools
cd ~/catkin_ws
catkin init
cd src/

git clone -b melodic --single-branch https://github.com/AutonomyLab/create_robot.git
git clone -b kinetic-devel https://github.com/ros-teleop/teleop_tools.git
git clone -b melodic-devel https://github.com/ros/geometry2.git
git clone -b melodic-devel https://github.com/ros/xacro.git
sudo rm -R common_msgs/
git clone -b jade-devel https://github.com/ros/common_msgs.git
git clone -b master https://github.com/orocos/orocos_kinematics_dynamics.git
git clone -b master https://github.com/ros/roslint.git
git clone -b melodic-devel https://github.com/ros/urdf.git
git clone -b master https://github.com/AutonomyLab/libcreate.git
git clone -b melodic-devel https://github.com/ros/geometry.git
git clone -b melodic-devel https://github.com/ros-drivers/joystick_drivers.git
git clone -b melodic-devel https://github.com/ros/actionlib.git
git clone -b indigo-devel https://github.com/ros/diagnostics.git
git clone -b kinetic-devel https://github.com/ros/rosconsole_bridge.git
git clone -b master https://github.com/ros/angles.git
git clone -b melodic-devel https://github.com/ros/robot_state_publisher.git
git clone -b kinetic-devel https://github.com/ros/bond_core.git
git clone -b kinetic-devel https://github.com/ros-controls/control_msgs.git
git clone -b master https://github.com/ros/rosbag_migration_rule.git
git clone -b melodic-devel https://github.com/ros/kdl_parser.git
git clone -b melodic-devel https://github.com/ros/urdf_parser_py.git

echo [POST-INSTALLER] - $(date +"%T") - Installing PiCreate packages via catkin...
cd ~/catkin_ws
rosdep update
rosdep install -y --from-paths src -i
catkin build
# Install published packages
sudo apt-get install ros-melodic-rosbridge-server
#
#
# TO DO MORE STUFF
#
#
# Finishing install
echo [POST-INSTALLER] - $(date +"%T") - Checking permissions and sourcing workspace...
sudo usermod -a -G dialout $USER
echo "source ~/create_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
