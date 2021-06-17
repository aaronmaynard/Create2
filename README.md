# ROS on Create2

Hi! Welcome to my documentation of the trials and tribulations I may be going through when installing ROS on the iRobot Create2.  Many of the tutorials online have become outdated as versions of Ubuntu and ROS get updated.  I am using **Ubuntu 20.04** and **ROS2 Foxy**. 


## Prerequisites

To follow along with this process you will need:

 - Raspberry Pi Model B
 - USB Type-C power adapter
 - ethernet cable (optional)
 - microSD card with +8GB capacity (I'm using 16GB)
 - microSD-SD adapter (optional)
 - card reader for flashing Ubuntu 20.04 LTS image
 - computer for flashing microSD card
 - imaging software (Raspberry Pi Imager | Balena Etcher)
 - keyboard / monitor + HDMI cable
 - iRobot Create2 programmable robot
 - iRobot Create2 Serial-USB (should be included)

## Preparing the Raspberry Pi

To begin we need to get ROS running on an Ubuntu 20.04 image.  There are two ways of doing this; obtaining the image from source or using the Raspberry Pi Imager.  I will describe the process of both.

### Quick and Easy Method

This method is the most straight forward for getting a clean copy of any supported OS on your Raspberry Pi.  To get started head on over to the official [Raspberry Pi website](https://www.raspberrypi.org/).  Click the Software menu to be taken to the main download page.  In the section **Install Raspberry Pi OS using Raspberry Pi Imager** download the appropriate software for your machine that will be doing the flashing, I have installed the Windows version.

When opening the program you will see "Raspberry Pi Imager v1.6.2" ir similar in the header, with three buttons.  The first thing we will do is choose our OS.  Click the following:

 1. CHOOSE OS
 2. Other general purpose OS
 3. Ubuntu
 4. Ubuntu Server 20.04.2 LTS (RPi 2/3/4/400)

Next take the microSD card and plug it into the card reader or use an adapter if necessary.  Click CHOOSE STORAGE and select the SD card reader. 

> Be careful as to not select anything but your SD card as you may unintentionally overwrite/break your other storage devices.

Select WRITE and allow the program to finish its magic.  Once the process is complete you may remove the microSD from your computer and install it into the Raspberry Pi for initial boot.

### Detailed and Controlled Method

This is the method for downloading the image from the source.  We can obtain a copy of Ubuntu Server 20.04 LTS image for the Raspberry Pi on the official [Ubuntu website](https://ubuntu.com/) .  Clicking on the Download dropdown, select **Raspberry Pi 2, 3 or 4** under **Ubuntu for IoT.**  We are downloading Ubuntu Server 20.04.2 LTS 32-bit for the armhf architecture.  The download should start automatically.

For flashing the OS to your microSD card you can use whichever program you like, I will cover Balena Etcher as it is my preferred and has a clean interface.  You can download it on the official [Balena website](https://www.balena.io/etcher/).  Once you download the appropriate software for your machine,  open up the program.  Select "Flash from file" and choose the Ubuntu 20.04 image that you downloaded earlier.  "Select target" and choose your device containing your microSD card, it may show multiple locations if has had a previous installation on it.  Select "Flash" to begin the decompressing process.  When the process is complete you may close Etcher and move the microSD card from your computer to the Raspberry Pi.

### First Boot

Connect your RPi to a monitor via HDMI, as well as a keyboard.  If you would like it to immediately have a network connection, you can plug in an ethernet cable now. I will discuss how to establish a wireless connection further down.

As soon as you plug the RPi to power, you will see the boot process on your monitor.  After a few second you will see what is called the headless login prompt, which is basically just the terminal interface.  The default username is **ubuntu** and the default password is **ubuntu**.  You will be asked to change the password.  Type in the current password, **ubuntu**.  You will then be asked for a new password.  I suggest something easy to remember, for example **create2**.  Retype the new password and press enter.

Once you are logged in we will want to establish a network connection if you haven't done so already.  Depending on where you downloaded your OS, your network manager will be either the WPA_Supplicant or Netplan.  A simple way to see which one you have is to type `ls /etc/wpa_supplicant`, if you see a .conf file, then that is what you will follow. To verify you have Netplan type `ls /etc/netplan` and look for a .yaml file, this is what you will follow. For WPA you will edit the config via `sudo nano /etc/wpa_supplicant/wpa_supplicant.conf`, for Netplan you will use `sudo nano /etc/netplan/50-cloud-init.yaml`. 

> Netplan may use 50-cloud-init.yaml, or some other file name.  There will only be one yaml, so use that one instead.

Next we need to see which interface we will use for our wireless connection.  type `ls /sys/class/net`and you should receive some interfaces.  My output looks like the following:

![enter image description here](https://i.imgur.com/VLI2bna.png)

As my wireless LAN interface is wlan0, that is what I will use for my Netplan interface.  You could also encounter wlp2s0, wlp3s0 or similar.

A `wpa_supplicant.conf` should look similar to the following:

```
network={ 
    ssid="Your network name/SSID"
    psk="Your WPA/WPA2 security key"
    key_mgmt=WPA-PSK
}
```
For more configuration options refer to the [raspberrypi.org documentation](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md).

A `50-could-init.yaml` should look similar to the following:

```
network:
    ethernets:
        eth0:
            dhcp4: true
            optional: true
    version: 2
    wifis:
        wlan0:
            optional: true
            access-points:
                "NETWORD_SSID":
                    password: "NETWORK_PASSWORD"
            dhcp4: true
```
Whichever version you have, commit the changes by hitting `<CTRL>+X`, followed by `y` to confirm changes, then `<ENTER>` to save to the filename.  For Netplan to apply the configuration you will need to run the following command `sudo netplan apply`.  

Once your network settings are set appropriately reboot the RPi for the changes to take affect via `sudo reboot`.  Once the reboot has completed, login and take note of the assigned IP address.  Look for the wireless interface that we setup earlier.   In the following wlan0 -> inet -> 192.168.#.###.  Yours could be 192.168.0.24, 192.168.1.110, or something else.  This number is the RPi local network address, and what we will use to remotely connect to the device.
```
ubuntu@ubuntu:~$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether XX:XX:XX:XX:XX:XX brd ff:ff:ff:ff:ff:ff
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether b8:27:eb:3b:2c:e5 brd ff:ff:ff:ff:ff:ff
    inet 192.168.[SOME NUMBER].[SOME NUMBER]/24 brd 192.168.1.255 scope global dynamic wlan0
       valid_lft 69430sec preferred_lft 69430sec
    inet6 XXXX:XXXX:XXX:XXXX::XX/128 scope global dynamic noprefixroute
       valid_lft 2274sec preferred_lft 2274sec
    inet6 XXXX:XXXX:XXX:XXXX:XXXX:XXXX:XXXX:XXXX/64 scope global dynamic mngtmpaddr noprefixroute
       valid_lft 3265sec preferred_lft 3265sec
    inet6 XXXX::XXXX:XXXX:XXXX:XXXX/64 scope link
       valid_lft forever preferred_lft forever
```
Once you have this number you can unplug your monitor and keyboard from the RPi.  From this point on we will be remotely connecting via SSH.  Open up a terminal supporting SSH and type `ssh ubuntu@192.168.#.###` where # is the rest of the local IP that the device was assigned.  As this will be the first time we are remotely connecting, we will be asked to establish a fingerprint, type `yes`.  Enter the password you typed in during setup, if you had followed the example it will be `create2`.  

![enter image description here](https://i.imgur.com/7AZXVyh.jpg)

As long as you are connected to the same network as the RPi, you can connect with any device.  If you would like to connect outside of the network, you will need to set up port-forwarding, which you can find many tutorials online.

## Installing ROS Foxy Fitzroy

The first step is to add the key that is used to sign software in the ROS repository.

`sudo apt-key adv --fetch-keys https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc`

Next we will add the URL for the ROS repository to the RPi.  

`sudo apt-add-repository http://packages.ros.org/ros2/ubuntu`

Using this method, there will be no need to run an apt update as everything will already be up to date.  We can install ROS now.

`sudo apt install ros-foxy-ros-base`

We will want to add the binaries to our path.  We can also make this default every time we login.

`source /opt/ros/foxy/setup.bash`
`echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc`

Adding the following will allow us to utilize tab auto complete within ROS.

`sudo apt install python3-argcomplete`

ROS is now successfully installed on the RPi and we can view the available commands. 

```
ubuntu@ubuntu:~$ ros2 --help
usage: ros2 [-h] Call `ros2 <command> -h` for more detailed usage. ...

ros2 is an extensible command-line tool for ROS 2.

optional arguments:
  -h, --help            show this help message and exit

Commands:
  action     Various action related sub-commands
  bag        Various rosbag related sub-commands
  component  Various component related sub-commands
  daemon     Various daemon related sub-commands
  doctor     Check ROS setup and other potential issues
  interface  Show information about ROS interfaces
  launch     Run a launch file
  lifecycle  Various lifecycle related sub-commands
  multicast  Various multicast related sub-commands
  node       Various node related sub-commands
  param      Various param related sub-commands
  pkg        Various package related sub-commands
  run        Run a package specific executable
  security   Various security related sub-commands
  service    Various service related sub-commands
  topic      Various topic related sub-commands
  wtf        Use `wtf` as alias to `doctor`

  Call `ros2 <command> -h` for more detailed usage.
  ```

## To be continued
