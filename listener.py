#!/usr/bin/env python

import rospy
from std_msgs.msg import String
import subprocess

def callback(data):
    message = data.data
    if message == "AUX1":
        command = "rosrun sound_play say.py 'Auxillary button, Y, has been pressed.'"
    elif message == "AUX2":
        command = "rosrun sound_play say.py 'The second auxillary button, X, has been pressed.'"
    else:
        print("Unknown command: {}".format(message))
        return

    subprocess.Popen(command, shell=True)

def listener():
    rospy.init_node('command_listener', anonymous=True)
    rospy.Subscriber("amc2_command", String, callback)
    rospy.spin()

if __name__ == '__main__':
    listener()
