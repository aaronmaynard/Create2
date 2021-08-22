# CMake generated Testfile for 
# Source directory: /home/ubuntu/Create2/ws/src/create_robot/create_driver
# Build directory: /home/ubuntu/Create2/ws/build/create_driver
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_create_driver_roslint_package "/home/ubuntu/Create2/ws/build/create_driver/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/ubuntu/Create2/ws/build/create_driver/test_results/create_driver/roslint-create_driver.xml" "--working-dir" "/home/ubuntu/Create2/ws/build/create_driver" "--return-code" "/opt/ros/melodic/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/ubuntu/Create2/ws/build/create_driver/test_results/create_driver/roslint-create_driver.xml make roslint_create_driver")
subdirs("gtest")
