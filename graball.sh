#!/bin/bash
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

