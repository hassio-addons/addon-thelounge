ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:9.1.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Install packages
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        g++=10.2.1_pre1-r3 \
        make=4.3-r0 \
        python2=2.7.18-r1 \
        yarn=1.22.10-r0 \
    \
    && apk add --no-cache \
        nginx=1.18.0-r13	\
        nodejs=14.16.0-r0 \
    \
    && yarn global add \
        modclean@3.0.0-beta.1 \
        thelounge@4.2.0 \
    \
    && modclean \
        --path /usr/local/share/.config/yarn/global \
        --no-progress \
        --keep-empty \
        --run \
    \
    && yarn global remove modclean \
    && yarn cache clean \
    && apk del --no-cache --purge .build-dependencies \
    && rm -fr /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Timmo <contact@timmo.xyz>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Timmo <contact@timmo.xyz>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
