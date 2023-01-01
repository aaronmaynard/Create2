# ROS on Create2

<<<<<<< HEAD
Hi! Welcome to my documentation of the trials and tribulations I may be going through when installing ROS on the iRobot Create2.  Many of the tutorials online have become outdated as versions of Ubuntu and ROS get updated.  I am using **Ubuntu 18.04.5** and **ROS Melodic**. 
=======
Hi! Welcome to my documentation of the trials and tribulations I may be going through when installing ROS on the iRobot Create2.  Many of the tutorials online have become outdated as versions of Ubuntu and ROS get updated.  I am using **Ubuntu Focal 20.04.5** and **ROS2 Foxy**. 
>>>>>>> origin/noetic


## Prerequisites

To follow along with this process you will need:

 - Raspberry Pi Model B
 - USB Type-C power adapter
 - ethernet cable (optional)
 - microSD card with +8GB capacity (I'm using 16GB)
 - microSD-SD adapter (optional)
 - card reader for flashing Ubuntu 18.04 LTS image
 - computer for flashing microSD card
 - imaging software (Raspberry Pi Imager | Balena Etcher)
 - keyboard / monitor + HDMI cable
 - iRobot Create2 programmable robot
 - iRobot Create2 Serial-USB (should be included)

## Part Specifications

USB to TTL Serial Cable - [Adafruit](https://www.adafruit.com/product/954)

| Color | Name |
|--|--|
| Red | Vpwr |
| Black | GND |
| White | RX into USB Port |
| Green | TX out of USB Port |

Mini-iRobot DIN Connector Cable 6' - [Adafruit](https://www.adafruit.com/product/2438)

| Color | Pin | Name | Description |
|--|--|--|--|
| Red | 2 | Vpwr | Roomba battery + (unregulated)  |
| Black (thin) | 4 | TXD | 0 – 5V Serial output from Roomba |
| Black (thick)| O | O | Outer shell |
| Green | 5 | BRC | Baud Rate Change |
| Yellow | 6 | GND | Roomba battery ground |
| Orange | 7 | GND | Roomba battery ground |
| Purple | 1   | Vpwr | Roomba battery + (unregulated) |
| Brown | 3 | RXD | 0 – 5V Serial input to Roomba |


SPDT Slide Switch - [Adafruit](https://www.adafruit.com/product/805)

| Pin | Name |
|--|--|
| 1 | Power Out |
| 2 | Power In |
| 3 | Power Out |


UBEC SC/SC Converter 5V @ 3A - [Adafruit](https://www.adafruit.com/product/1385)

| Color | Name |
|--|--|
| Red | Vpwr |
| Black | GND|

<<<<<<< HEAD
# Running the robot

`roslaunch create_bringup create_2.launch`

`roslaunch rosbridge_server rosbridge_websocket.launch`

`roslaunch rplidar_ros view_rplidar.launch`

`roslaunch raspicam_node camerav1_1280x720.launch`

=======


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
>>>>>>> origin/noetic
