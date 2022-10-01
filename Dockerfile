FROM blakeblackshear/frigate:stable

RUN cd /tmp \
    && wget -O /tmp/ffmpeg.deb "https://repo.jellyfin.org/releases/server/debian/versions/jellyfin-ffmpeg/5.0.1-8/jellyfin-ffmpeg5_5.0.1-8-bullseye_amd64.deb" \
    && apt-get update \
    && apt-get -qq install --no-install-recommends --no-install-suggests -y /tmp/ffmpeg.deb \
    && rm /tmp/ffmpeg.deb \
    && apt-get clean autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/lib/jellyfin-ffmpeg:$PATH