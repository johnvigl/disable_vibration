#!/system/bin/sh
# Magisk service script

MODDIR=${0%/*}

# Function to disable vibration
disable_vibration() {
    stop vendor.vibrator-1-0
    stop vendor.qti.vibrator
}

# Function to re-enable vibration
enable_vibration() {
    start vendor.vibrator-1-0
    start vendor.qti.vibrator
}

vibration_disabled=0


# Function to load app list from config.txt
load_app_list() {
    APP_LIST=$(cat "$MODDIR/config.txt" | grep -v '^#' | grep -v '^$') # Exclude comments and empty lines
}


# Monitoring loop
while true; do

    # Reload the app list in case it's modified
    load_app_list

    # Get the current foreground app
    foreground_app=$(dumpsys activity activities | grep mResumedActivity | awk '{print $4}' | cut -d '/' -f 1)

    # Check if the foreground app matches any app in the list
    match_found=0
    for app in $APP_LIST; do
        if [ "$foreground_app" == "$app" ]; then
            match_found=1
            break
        fi
    done

    # Toggle vibration based on app state
    if [ "$match_found" -eq 1 ]; then
        if [ "$vibration_disabled" -eq 0 ]; then
            disable_vibration
            vibration_disabled=1
        fi
    else
        if [ "$vibration_disabled" -eq 1 ]; then
            enable_vibration
            vibration_disabled=0
        fi
    fi

    # Sleep for 5 seconds before checking again
    sleep 5
done 
