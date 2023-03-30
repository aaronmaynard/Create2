
# ROS on Create2

Hi! Welcome to my documentation of the trials and tribulations I may be going through when installing ROS2 on the iRobot Create2. Many of the tutorials online have become outdated as versions of Ubuntu and ROS get updated. I am using the following in this branch:

**Software**  
Ubuntu Focal 18.04.6  
ROS Melodic  

**Hardware**  
Raspberry Pi Model 3B+  
Intel RealSense D435  
RPLiDAR A1  
iRobot Create 2  

# Installing PiCreate Software

## Flashing SD card with Raspbian

Launch [Raspberry Pi Imager](https://www.raspberrypi.com/software/) v1.6.2 or greater.

Set **Operating System** to **Ubuntu Server 18.04.6 LTS (64-bit)**. If this version is no longer available, you can download the image directly from Ubuntu's [archives](https://releases.ubuntu.com/18.04/) and select "Use custom".

Set **Storage** to the device hosting your SD card (+ gb, 32 gb recommended).

There are two methods of enabling SSH and establishing a WiFi connection on the device.

### Method 1 - Raspberry Pi Imager

Open the Advanced Options section in the installer by clicking on the COG button.

Enable the following options:

* Set Hostname: [robotname].local
* Enable SSH (Use password authentication unless you know what your doing)
* Set username and password (I recommend administrator and your last name for local development)
* Configure wireless LAN
* Set locale settings

You may leave Persistent Settings as default.

### Method 2 - Manual 

Write to the storage device - A warning will appear declaring all existing data on the storage device will be erased.

### Set wireless connection via boot partition

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

You can view the exact process locking the resource via `ps aux | grep -i apt`.

# Running the robot

Create 2 Bridge  
`roslaunch create_bringup create_2.launch`  
RPLiDAR  
`roslaunch rplidar_ros rplidar.launch`  
RealSense  
`roslaunch realsense2_camera rs_camera.launch color_width:=540 color_height:=960`  
ROSBridge Suite  
`roslaunch rosbridge_server rosbridge_websocket.launch`  
Web Video Server  
`rosrun web_video_server web_video_server _port:=8080`  

## Additional packages

To play audio or sound, it is recommended to install the audio_common ros driver.  You will need to run the following commands as an example:

```
rosrun sound_play soundplay_node.py
rosrun sound_play say.py 'Hello World'
```

#### Enabling audio on Ubuntu 18.04

`sudo nano /boot/firmware/usercfg.txt`
insert the following line:
`dtparam=audio=on`
reboot.

### Building Packages

```
cd ~/catkin_ws
rosdep install --from-paths src -i  
catkin build
```

#### Failed packages

In the case that some packages failed the build process due to running out of memory, such as the example below:
```
Starting >>> create_driver
--- stderr: create_driver
c++: fatal error: Killed signal terminated program cc1plus
compilation terminated.
make[2]: *** [CMakeFiles/create_driver.dir/build.make:63: CMakeFiles/create_driver.dir/src/create_driver.cpp.o] Error 1
make[1]: *** [CMakeFiles/Makefile2:78: CMakeFiles/create_driver.dir/all] Error 2
make: *** [Makefile:141: all] Error 2
---
Failed   <<< create_driver [38min 46s, exited with code 2]

Summary: 0 packages finished [38min 48s]
  1 package failed: create_driver
  1 package had stderr output: create_driver
  2 packages not processed
  ```
  The size of the swap file can be changed, allowing for harddisk space to  be used as additional ram when needed.  To complete this process, follow the steps outlined below:
  1. Turn off all running swap processes: `sudo swapoff -a` (You can also run this when done with your extra "ram")
  2. Resize swap `sudo fallocate -l 1G /swapfile` (change 1G to the gigabyte size you want it to be)
  3. CHMOD swap: `sudo chmod 600 /swapfile`
  4. Make file usable as swap `sudo mkswap /swapfile`
  5. Active the swap file `sudo swapon /swapfile`
  
Thats it! Some commands may take some time to be executed, just wait patiently for the commands to finish.
To verify your swap size run the following command and you will see the swap size: `free -m`

#### Failed RealSense ROS Package

If you see an error stating that you are unable to open the USB interface when running the realsense package, you will need to create a rules file as described in https://github.com/IntelRealSense/realsense-ros/issues/1408. 

`sudo nano /etc/udev/rules.d/99-realsense-libusb.rules`

Copy the content of https://raw.githubusercontent.com/IntelRealSense/librealsense/master/config/99-realsense-libusb.rules in the file, unplug & replug your realsense camera, run the ROS package.
