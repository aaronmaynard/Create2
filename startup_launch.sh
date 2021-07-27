#!/bin/bash
source /opt/ros/melodic/setup.bash
source /home/ubuntu/create_ws/devel/setup.bash
pinc -c 1 192.168.1.82
roslaunch robot_gui_bridge websocket.launch
