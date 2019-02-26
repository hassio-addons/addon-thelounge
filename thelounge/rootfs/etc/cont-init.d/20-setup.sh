#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: The Lounge
# This adds the default user and installs any requested themes
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

export THELOUNGE_HOME=/data/thelounge

if ! hass.directory_exists "/data/thelounge"; then
    hass.log.info "Creating default hassio user.."
    mkdir -p /data/thelounge/users
    cp /etc/thelounge/users/hassio.json /data/thelounge/users
else
    for theme in $(hass.config.get "themes")
    do
        /usr/local/bin/thelounge install "${theme}"
    done
fi
