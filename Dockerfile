FROM registry.k8s.kudikala.com/chrome-k8s
USER root
RUN apt-get update; apt-get install -y  llvm-16 gcc xz-utils gcc-dev
USER jenkins
