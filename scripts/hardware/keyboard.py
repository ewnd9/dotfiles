#!/usr/bin/python

# code from:
# - https://askubuntu.com/questions/138522/how-do-i-run-a-script-when-a-bluetooth-device-connects/140452
# - https://github.com/cshnick/my_script_environment/blob/69152a9b210784676e417dda518f26a3f02d9304/python/bluetooth_start.py

import dbus
import gobject
import subprocess
import os
import time

from dbus.mainloop.glib import DBusGMainLoop

def handler(interface, data, dbs):
    if interface != 'org.bluez.Device1' or data['Connected'] != True:
        return
    print 'connected'
    time.sleep(1) # race condition as always
    subprocess.call(["bash", os.environ['HOME'] + "/xk"])

dbus_loop = DBusGMainLoop()

bus = dbus.SystemBus(mainloop=dbus_loop)
keyboard = bus.get_object('org.bluez', '/org/bluez/hci0/dev_34_88_5D_63_48_A3')

prop = dbus.Interface(keyboard, 'org.freedesktop.DBus.Properties')
prop.connect_to_signal("PropertiesChanged", handler)

loop = gobject.MainLoop()
loop.run()
