FROM jenkins/inbound-agent:latest-bookworm
RUN apt-get install llvm-16 gcc
