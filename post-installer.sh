#!/bin/bash
# Post installation script to install dependencies needed to run the picreate robot.
# Aaron Maynard
# January 1st, 2023
# Make this file an executable via 'chmod +x post-installer.sh'
# Run this file via './post-installer.sh'
echo [POST-INSTALLER] - $(date +"%T") - Starting post-installer script...
echo [POST-INSTALLER] - $(date +"%T") - Setting up ROS repositories...
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl -y # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
# Installing ROS
echo [POST-INSTALLER] - $(date +"%T") - Installing ROS...
sudo apt install ros-melodic-desktop-full -y
# Setting Up ROS Environment
echo [POST-INSTALLER] - $(date +"%T") - Setting Up ROS Environment...
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
# If you use zsh instead of bash you need to run the following commands to set up your shell:
# echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
# source ~/.zshrc
# Dependencies for building packages
echo [POST-INSTALLER] - $(date +"%T") - Installing Build Dependencies...
sudo apt install python-rosdep python-catkin-tools python-rosinstall python-rosinstall-generator python-wstool build-essential -y
sudo rosdep init
rosdep update
# Installing RealSense Camera SDK
echo [POST-INSTALLER] - $(date +"%T") - Installing ROS Wrapper for Intel RealSense Devices...
sudo apt-get install ros-$ROS_DISTRO-realsense2-camera -y
# Installing ROSBridge 	Suite
echo [POST-INSTALLER] - $(date +"%T") - Installing ROSBridgeSuite...
sudo apt-get install ros-$ROS_DISTRO-rosbridge-suite -y
# Installing Web Video Server
echo [POST-INSTALLER] - $(date +"%T") - Manually building Web Video Server...
sudo apt-get install ros-$ROS_DISTRO-web-video-server -y
# Installing RPLiDAR
echo [POST-INSTALLER] - $(date +"%T") - Installing RPLiDAR...
sudo apt-get install ros-$ROS_DISTRO-rplidar-ros -y
# Installing Create2 Bridge
echo [POST-INSTALLER] - $(date +"%T") - Manually building the Create2 bridge...
cd ~
mkdir -p catkin_ws/src
cd ~/catkin_ws
catkin init
cd ~/catkin_ws/src
git clone https://github.com/autonomylab/create_robot.git
cd ~/catkin_ws
rosdep update
rosdep install --from-paths src -i -y 
catkin build
# Finishing install
echo [POST-INSTALLER] - $(date +"%T") - Checking permissions and sourcing workspace...
sudo usermod -a -G dialout $USER
source ~/catkin_ws/devel/setup.bash
