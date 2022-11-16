#!/bin/bash

# ---------------------------------------------

# Set Background
desktopPictureLocation="/Users/Shared/weallcode-background.png"

unset rows data_id key lastrow major option_arg stop value
db="$HOME/Library/Application Support/Dock/desktoppicture.db"
major=$(system_profiler SPSoftwareDataType | awk '/System Version/ {print $4}' | cut -d . -f 1)
export version=$major
export option_arg=$desktopPictureLocation

# We've got this far, let's quit System Preferences – if open – before continuing.
# Write STDOUT and STDERR to /dev/null to supress messages if process isn't running
killall System\ Preferences >/dev/null 2>&1

rows[0]="'$option_arg'":1
unset value key

lastrow[0]=$(sqlite3 "$db" "SELECT ROWID FROM data ORDER BY ROWID DESC LIMIT 1;")

# If 'data' contains 0 rows, lastrow[0] is empty/null so explicitily set lastrow[0] to 0
[ -z "${lastrow[0]}" ] && lastrow[0]=0

# Get the rowid of the last row to be inserted in the 'preferences' table.
# This will be used to insert new rows later in the script.
lastrow[1]=$(sqlite3 "$db" "SELECT ROWID FROM preferences ORDER BY ROWID DESC LIMIT 1;")

# if 'preferences' contains 0 rows, lastrow[1] is empty/null so explicitily set lastrow[1] to 0
[ -z "${lastrow[1]}" ] && lastrow[1]=0

# Delete all rows in the 'data' table.
sqlite3 "$db" "DELETE FROM data;"

# Delete all rows in the 'preferences' table. Causes the 'preferences_deleted' trigger to fire.
sqlite3 "$db" "DELETE FROM preferences;"

for i in "${rows[@]}"; do

    value=$(echo $i | cut -d ':' -f1)
    key=$(echo $i | cut -d ':' -f2)

    # Insert a new row into the 'data' table.
    sqlite3 "$db" "INSERT INTO data(rowid,value) VALUES( $((++lastrow[0])), $value );"

    # Insert new rows into the 'preferences' table.
    data_id=$(sqlite3 "$db" "SELECT rowid FROM data WHERE value=$value;")

    sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES( $((++lastrow[1])),$key,${data_id},3);"
    sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES( $((++lastrow[1])),$key,${data_id},4);"
    sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES( $((++lastrow[1])),$key,${data_id},2);"
    sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES( $((++lastrow[1])),$key,${data_id},1);"

    unset value key

done

# ---------------------------------------------

# Update Dock
/usr/local/bin/dockutil --remove all \
    --add /Applications/Safari.app \
    --add /Applications/Google\ Chrome.app \
    --add /Applications/Firefox.app \
    --add /Applications/Visual\ Studio\ Code.app

# ---------------------------------------------

# Kill Dock
killall Dock

# ---------------------------------------------
