# CMake generated Testfile for 
# Source directory: /home/ubuntu/Create2/ws/src/create_robot/create_description
# Build directory: /home/ubuntu/Create2/ws/build/create_description
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_create_description_roslaunch-check_launch "/home/ubuntu/Create2/ws/build/create_description/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/ubuntu/Create2/ws/build/create_description/test_results/create_description/roslaunch-check_launch.xml" "--return-code" "/usr/bin/cmake -E make_directory /home/ubuntu/Create2/ws/build/create_description/test_results/create_description" "/opt/ros/melodic/share/roslaunch/cmake/../scripts/roslaunch-check -o \"/home/ubuntu/Create2/ws/build/create_description/test_results/create_description/roslaunch-check_launch.xml\" \"/home/ubuntu/Create2/ws/src/create_robot/create_description/launch\" ")
subdirs("gtest")
