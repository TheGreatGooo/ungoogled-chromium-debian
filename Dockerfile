FROM docker.io/jenkins/inbound-agent:latest-bookworm
USER root
RUN apt-get update; apt-get install -y  llvm-16 gcc xz-utils ninja-build clang clang-16 wget curl unzip libcups2-dev cmake lld openssl libssl-dev pkg-config libnss3 libnss3-dev libnss3-tools libglib2.0-dev libdrm-dev
USER jenkins
