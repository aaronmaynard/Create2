#!/bin/bash
# Post installation script to install dependencies needed to run the picreate robot.
# Aaron Maynard October 13th, 2021
echo $(date +"%T") - [POST-INSTALLER] Starting post-installer script...
echo $(date +"%T") - [POST-INSTALLER] Setting up ROS repositories...
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Command has changed to utilize Ubuntu keyserver as some may experience issues with ha.pool.kys-keyservers.net
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get upgrade
# Bootstrap Dependencies
echo $(date +"%T") - [POST-INSTALLER] Installing bootstrap dependencies...
sudo apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake
sudo rosdep init
rosdep update
# Installing ROS
echo $(date +"%T") - [POST-INSTALLER] Installing ROS...
mkdir -p ~/catkin_ws
cd ~/catkin_ws
rosinstall_generator ros_comm --rosdistro melodic --deps --wet-only --tar > melodic-ros_comm-wet.rosinstall
wstool init src melodic-ros_comm-wet.rosinstall
rosdep install -y --from-paths src --ignore-src --rosdistro melodic -r --os=debian:buster
# Building catkin workspace
echo $(date +"%T") - [POST-INSTALLER] Building catkin workspace...
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/melodic
source /opt/ros/melodic/setup.bash
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
# Download and Install PiCreate packages
echo $(date +"%T") - [POST-INSTALLER] Downloading PiCreate packages...
cd ~/catkin_ws
catkin init
cd src/
git clone -b deployment --single-branch https://github.com/aaronmaynard/Create2.git
echo $(date +"%T") - [POST-INSTALLER] Installing PiCreate packages via catkin...
cd ~/catkin_ws
rosdep update
rosdep install --from-paths src -i
catkin build
# Install published packages
sudo apt-get install ros-melodic-rosbridge-server
#
#
# TO DO MORE STUFF
#
#
# Finishing install
echo $(date +"%T") - [POST-INSTALLER] Checking permissions and sourcing workspace...
sudo usermod -a -G dialout $USER
echo "source ~/create_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
