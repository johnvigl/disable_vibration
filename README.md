# Disable Vibration Module

This Magisk module disables vibration for selected apps when they are in the foreground.
Tested in Android 10

## Configuration

1. Edit the configuration file located at:
   `/data/adb/modules/disable_vibration/config.txt`

2. Add or remove app package names as needed. Use one app package name per line. Lines starting with `#` are treated as comments.

   Example:

com.viber.voip
org.telegram.messenger


3. Changes will take effect automatically within 5 seconds.
