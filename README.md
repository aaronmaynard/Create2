# ROS on Create2

This is the deployment branch of the ROS on Create2 project. This branch has purposefully been stripped to the bare tools to be downloaded onto the filesystem, and will include an executable file that will download dependencies if neccessary and install them.  The goal is to have a robot ready to go once the executable has finished.

# Installing PiCreate Software

## Flashing SD card with Raspbian

Launch Raspberry Pi Imager v1.6.2

Set **Operating System** to **RASPBERRY PI OS LITE (32-BIT)**

Set **Storage** to the device hosting your SD card

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

