#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: The Lounge
# This adds the default user and installs any requested themes
# ==============================================================================
declare users
declare user_found

export THELOUNGE_HOME=/data/thelounge

# Require a user
bashio::config.require "users"

if ! bashio::fs.directory_exists "/data/thelounge"; then
    mkdir -p /data/thelounge/users
fi

# List current users
/usr/local/bin/thelounge list

users=$(bashio::config "users")

for user in $users
do
    if ! bashio::fs.file_exists "/data/thelounge/users/${user}.json"; then
        bashio::log.info "Creating user ${user} with default password.."
        cp /etc/thelounge/users/hassio.json "/data/thelounge/users/${user}.json"
    fi
done

# Delete removed users
for file in /data/thelounge/users/*
do
    user_found=false
    for user in $users
    do
        if [ "$(basename "${file}" .json)" == "${user}" ]; then
            user_found=true
            break
        fi
    done
    if [ ! "$user_found" == true ]; then
        bashio::log.info "Removing removed user ${file}.."
        rm -f "$file"
    fi
done

for theme in $(bashio::config "themes")
do
    /usr/local/bin/thelounge install "${theme}"
done
