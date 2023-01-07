
# ROS on Create2

Hi! Welcome to my documentation of the trials and tribulations I may be going through when installing ROS2 on the iRobot Create2. Many of the tutorials online have become outdated as versions of Ubuntu and ROS get updated. I am using the following in this branch:

**Software**  
Ubuntu Focal 20.04.5  
ROS2 Foxy  

**Hardware**  
Raspberry Pi Model 3B+  
Intel RealSense D435  
RPLiDAR A1  
iRobot Create 2  

# Installing PiCreate Software

## Flashing SD card with Raspbian

Launch [Raspberry Pi Imager](https://www.raspberrypi.com/software/) v1.6.2 or greater.

Set **Operating System** to **Ubuntu Server 20.04.5 LTS (64-bit)**. If this version is no longer available, you can download the image directly from Ubuntu's archives and select "Use custom".

Set **Storage** to the device hosting your SD card (+ gb, 32 gb recommended).

Write to the storage device - A warning will appear declaring all existing data on the storage device will be erased.

## Set wireless connection via boot partition

Enter the `/Volumes/boot` directory - this will be the root directory on windows.

Create a `wpa_supplicant.conf` file with the following:

> ```bash
> country=US # Your 2-digit country code
> ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
> network={
>     ssid="YOUR_NETWORK_NAME"
>     psk="YOUR_PASSWORD"
>     key_mgmt=WPA-PSK
> }
> ```

Create a file named `ssh` with no extension - file content does not matter.

Put the SD card into the Raspberry Pi - Booting the device will cause the files to disappear from the SD card's boot directory automatically.

From here you should be able to SSH into the device after establishing the IP address - username `pi`, password `raspberry`

## Complete the installation

Run `sudo chmod +x post-installer.sh`

Run `sudo bash post-installer.sh`

If you run into an error such as:
`Waiting for cache lock: Could not get lock /var/lib/dpkg/lock-frontend. It is held by process 1777 (unattended-upgr)`
You can kill the process via `sudo kill -9 1777` replacing `1777` with whichever is described in the error.  You may then run `sudo bash post-installer.sh`.

# Running the robot

Create 2 Bridge  
`ros2 launch create_bringup create_2.launch`  
RPLiDAR  
`ros2 run rplidar_ros rplidar_composition`  
RealSense  
`ros2 run realsense2_camera realsense2_camera_node`  
ROSBridge Suite  
`ros2 run rosbridge_server rosbridge_websocket`  
Web Video Server  
`ros2 run web_video_server web_video_server`  

### Building Packages

```
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build
```
