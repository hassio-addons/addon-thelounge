ARG BUILD_FROM=hassioaddons/base:7.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Install packages
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        yarn=1.19.2-r0 \
    \
    && apk add --no-cache \
        nginx=1.16.1-r6	\
        nodejs=12.15.0-r1 \
    \
    && yarn global add \
        modclean@3.0.0-beta.1 \
        thelounge@4.0.0 \
    \
    && modclean \
        --path /usr/local/share/.config/yarn/global \
        --no-progress \
        --keep-empty \
        --run \
    \
    && yarn global remove modclean \
    && yarn cache clean \
    && apk del --purge .build-dependencies \
    && rm -fr /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="The Lounge" \
    io.hass.description="A self-hosted web IRC client." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Timmo <contact@timmo.xyz>" \
    org.label-schema.description="A self-hosted web IRC client." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="The Lounge" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/?u=timmo001" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-thelounge/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-thelounge" \
    org.label-schema.vendor="Community Hass.io Add-ons"
