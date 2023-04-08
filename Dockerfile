
FROM debian:11-slim AS wget
ARG DEBIAN_FRONTEND
RUN apt-get update \
    && apt-get install -y wget xz-utils \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /rootfs
RUN wget -O /rootfs/ffmpeg.deb "https://repo.jellyfin.org/releases/server/debian/versions/jellyfin-ffmpeg/5.0.1-8/jellyfin-ffmpeg5_5.0.1-8-bullseye_amd64.deb"

FROM ghcr.io/blakeblackshear/frigate:0.12.0-rc2
COPY --from=wget /rootfs/ffmpeg.deb /tmp/ffmpeg.deb

RUN cd /tmp \
    && apt-get update \
    && apt-get -qq install --no-install-recommends --no-install-suggests -y /tmp/ffmpeg.deb \
    && rm /tmp/ffmpeg.deb \
    && apt-get clean autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/lib/jellyfin-ffmpeg:$PATH