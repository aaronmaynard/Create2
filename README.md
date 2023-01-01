# ROS on Create2

Hi! Welcome to my documentation of the trials and tribulations I may be going through when installing ROS on the iRobot Create2.  Many of the tutorials online have become outdated as versions of Ubuntu and ROS get updated.  I am using **Ubuntu Focal 20.04.5** and **ROS2 Foxy**. 


# Installing PiCreate Software

## Flashing SD card with Raspbian

Launch Raspberry Pi Imager v1.6.2

Set **Operating System** to **RASPBERRY PI OS LITE (32-BIT)**

Set **Storage** to the device hosting your SD card (need 8+ gb)

Write to the storage device - A warning will appear declaring all existing data on the storage device will be erased


## Set wireless connection via boot partition

Enter the `/Volumes/boot` directory - this will be the root directory on windows

Create a `wpa_supplicant.conf` file with the following:

> ```bash
> country=US # Your 2-digit country code
> ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
> network={
>     ssid="YOUR_NETWORK_NAME"
>     psk="YOUR_PASSWORD"
>     key_mgmt=WPA-PSK
> }

Put the SD card into the Raspberry Pi - Booting the device will cause the file to disappear from the SD card's boot directory automatically

Create a file named `ssh` with no extension - file content does not matter

From here you should be able to SSH into the device after establishing the IP address - username `pi`, password `raspberry`

## Complete the installation

Run `sudo chmod +x post-installer.sh`

Run `sudo bash [post-installer.sh](https://github.com/aaronmaynard/Create2)`

### Testing


```
ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py

ros2 launch rosbridge_server rosbridge_websocket_launch.xml
```

# Running the robot

`roslaunch create_bringup create_2.launch`

`roslaunch rosbridge_server rosbridge_websocket.launch`

`roslaunch rplidar_ros view_rplidar.launch`

`roslaunch raspicam_node camerav1_1280x720.launch`

### Exports

```
export M_PI=3.14159265359
export DINGO_LASER=1
export DINGO_LASER_MOUNT='front'
export DINGO_LASER_TOPIC='front/scan'
export DINGO_LASER_TOWER=1
export DINGO_LASER_PREFIX=${DINGO_LASER_MOUNT}
export DINGO_LASER_PARENT=${DINGO_LASER_MOUNT}_mount
export DINGO_LASER_MODEL='lms1xx' # or 'ust10'
export DINGO_LASER_OFFSET='0 0 0'
export DINGO_LASER_RPY='0 0 0'
export DINGO_REALSENSE=1
export DINGO_REALSENSE_MODEL='d435' # or 'd435i', 'd415', 'd455', 'l515'
export DINGO_REALSENSE_MOUNT='front'
export DINGO_REALSENSE_TOPIC='realsense'
export DINGO_REALSENSE_OFFSET='0.03 -0.002 0'
export DINGO_REALSENSE_RPY='0 0 0'
```

### Testing for SD


```
roslaunch dingo_gazebo dingo_world.launch
roslaunch rosbridge_server rosbridge_websocket.launch
rosrun web_video_server web_video_server
roslaunch dingo_viz view_robot.launch config:=localization
```

### Building Packages

```
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin_make
```
