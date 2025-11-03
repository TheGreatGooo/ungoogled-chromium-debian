FROM docker.io/jenkins/inbound-agent:latest-bookworm
USER root
RUN apt-get update; apt-get install -y  libpipewire-0.3-dev llvm-16 gcc xz-utils ninja-build clang clang-16 wget curl unzip libcups2-dev cmake lld openssl libssl-dev pkg-config libnss3 libnss3-dev libnss3-tools libglib2.0-dev libdrm-dev  debhelper dh-exec lsb-release generate-ninja gperf libncurses-dev libkrb5-dev libcurl4-openssl-dev libgtk-3-dev qtbase5-dev libfontconfig-dev libx11-xcb-dev libxshmfence-dev libgbm-dev mesa-common-dev libva-dev libpulse-dev libasound2-dev libpci-dev libxml2-dev libopus-dev libwebp-dev libjpeg-dev libxslt1-dev libflac-dev libsnappy-dev libminizip-dev libevent-dev liblcms2-dev libopenjp2-7-dev libjsoncpp-dev
USER jenkins
