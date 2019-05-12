#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: The Lounge
# This adds the default user and installs any requested themes
# ==============================================================================
export THELOUNGE_HOME=/data/thelounge

# Require a user
bashio::config.require "users"

if ! bashio::fs.directory_exists "/data/thelounge"; then
    mkdir -p /data/thelounge/users
fi

# List current users
/usr/local/bin/thelounge list

for user in $(bashio::config "users")
do
    if ! bashio::fs.file "/data/thelounge/users/${user}.json"; then
        bashio::log.info "Creating user ${user} with default password.."
        cp /etc/thelounge/users/hassio.json "/data/thelounge/users/${user}.json"
    fi
done

for theme in $(bashio::config "themes")
do
    /usr/local/bin/thelounge install "${theme}"
done
