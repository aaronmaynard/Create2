#!/bin/bash
# Post installation script to install dependencies needed to run the picreate robot.
# Aaron Maynard
# January 1st, 2023
# Make this file an executable via 'chmod +x post-installer.sh'
# Run this file via './post-installer.sh'
echo [POST-INSTALLER] - $(date +"%T") - Starting post-installer script...
echo [POST-INSTALLER] - $(date +"%T") - Setting up ROS repositories...
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -k -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade -y
# Installing ROS
echo [POST-INSTALLER] - $(date +"%T") - Installing ROS...
sudo apt install ros-foxy-desktop python3-argcomplete ros-dev-tools -y
# Replace ".bash" with your shell if you're not using bash
# Possible values are: setup.bash, setup.sh, setup.zsh
source /opt/ros/foxy/setup.bash
# Installing RPLiDAR
echo [POST-INSTALLER] - $(date +"%T") - Installing RPLiDAR...
sudo apt-get install ros-foxy-rplidar-ros -y
# Installing RealSense Camera SDK
echo [POST-INSTALLER] - $(date +"%T") - Installing RealSense SDK...
sudo apt-get install ros-foxy-realsense2-camera -y
# You can test if the install was successful via: 
# ros2 launch realsense2_camera rs_launch.py enable_pointcloud:=true device_type:=d435
# Installing ROSBridge Suite
echo [POST-INSTALLER] - $(date +"%T") - Installing ROSBridgeSuite...
sudo apt-get install ros-foxy-rosbridge-suite -y
# Installing Create2 Bridge
echo [POST-INSTALLER] - $(date +"%T") - Manually building the Create2 bridge...
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/autonomylab/create_robot.git --branch foxy
git clone https://github.com/AutonomyLab/libcreate
echo [POST-INSTALLER] - $(date +"%T") - Manually building Web Video Server...
git clone https://github.com/RobotWebTools/web_video_server.git --branch ros2
cd ~/ros2_ws
sudo rosdep init
# If there are issues with the above, network security may be the issue (such as Google WiFi).  Change to a different network.
rosdep update
rosdep install --from-paths src -i -y
colcon build
# Finishing install
echo [POST-INSTALLER] - $(date +"%T") - Checking permissions and sourcing workspace...
sudo usermod -a -G dialout $USER
. ~/ros2_ws/install/local_setup.bash
