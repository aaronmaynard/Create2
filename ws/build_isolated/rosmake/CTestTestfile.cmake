# CMake generated Testfile for 
# Source directory: /home/pi/picreate/Create2/ws/src/ros/rosmake
# Build directory: /home/pi/picreate/Create2/ws/build_isolated/rosmake
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_rosmake_nosetests_test "/home/pi/picreate/Create2/ws/build_isolated/rosmake/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/kinetic/share/catkin/cmake/test/run_tests.py" "/home/pi/picreate/Create2/ws/build_isolated/rosmake/test_results/rosmake/nosetests-test.xml" "--return-code" "\"/usr/bin/cmake\" -E make_directory /home/pi/picreate/Create2/ws/build_isolated/rosmake/test_results/rosmake" "/usr/bin/nosetests-2.7 -P --process-timeout=60 --where=/home/pi/picreate/Create2/ws/src/ros/rosmake/test --with-xunit --xunit-file=/home/pi/picreate/Create2/ws/build_isolated/rosmake/test_results/rosmake/nosetests-test.xml")
set_tests_properties(_ctest_rosmake_nosetests_test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/kinetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/kinetic/share/catkin/cmake/test/nosetests.cmake;83;catkin_run_tests_target;/home/pi/picreate/Create2/ws/src/ros/rosmake/CMakeLists.txt;10;catkin_add_nosetests;/home/pi/picreate/Create2/ws/src/ros/rosmake/CMakeLists.txt;0;")
subdirs("gtest")
