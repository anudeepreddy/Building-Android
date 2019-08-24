FROM ubuntu:latest

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m gitpod && echo "gitpod:gitpod" | chpasswd && adduser gitpod sudo

USER gitpod

RUN sudo apt-get remove openjdk-* icedtea-* icedtea6-* && \
    sudo apt-get install openjdk-8-jdk git ccache automake lzop bison gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev squashfs-tools pngcrush schedtool dpkg-dev liblz4-tool make optipng maven && \
    sudo add-apt-repository ppa:openjdk-r/ppa && \
    sudo apt-get update && sudo apt-get install openjdk-8-jdk && \
    mkdir ~/bin && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo

ENV PATH=~/bin:$PATH \
    USE_CCACHE=1

RUN mkdir pe && cd pe && \
    repo init -u https://github.com/PixelExperience/manifest -b pie && \
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


