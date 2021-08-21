# CMake generated Testfile for 
# Source directory: /home/pi/picreate/Create2/ws/src/ros_comm/rosbag
# Build directory: /home/pi/picreate/Create2/ws/build_isolated/rosbag
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_rosbag_nosetests_test "/home/pi/picreate/Create2/ws/build_isolated/rosbag/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/kinetic/share/catkin/cmake/test/run_tests.py" "/home/pi/picreate/Create2/ws/build_isolated/rosbag/test_results/rosbag/nosetests-test.xml" "--return-code" "\"/usr/bin/cmake\" -E make_directory /home/pi/picreate/Create2/ws/build_isolated/rosbag/test_results/rosbag" "/usr/bin/nosetests-2.7 -P --process-timeout=60 --where=/home/pi/picreate/Create2/ws/src/ros_comm/rosbag/test --with-xunit --xunit-file=/home/pi/picreate/Create2/ws/build_isolated/rosbag/test_results/rosbag/nosetests-test.xml")
set_tests_properties(_ctest_rosbag_nosetests_test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/kinetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/kinetic/share/catkin/cmake/test/nosetests.cmake;83;catkin_run_tests_target;/home/pi/picreate/Create2/ws/src/ros_comm/rosbag/CMakeLists.txt;67;catkin_add_nosetests;/home/pi/picreate/Create2/ws/src/ros_comm/rosbag/CMakeLists.txt;0;")
subdirs("gtest")
