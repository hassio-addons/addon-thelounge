#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: The Lounge
# This adds the default user and installs any requested themes
# ==============================================================================
export THELOUNGE_HOME=/data/thelounge

if ! bashio::fs.directory_exists "/data/thelounge"; then
    bashio::log.info "Creating default hassio user.."
    mkdir -p /data/thelounge/users
    cp /etc/thelounge/users/hassio.json /data/thelounge/users
else
    for theme in $(bashio::config "themes")
    do
        /usr/local/bin/thelounge install "${theme}"
    done
fi
