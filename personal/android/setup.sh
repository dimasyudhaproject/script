#!/bin/bash
#
# Copyright (C) Dimas Yudha Pratama <fsdimasyudha@gmail.com>
#
read -p 'Input your Git email ~> ' gitEmail
read -p 'Input your Git name ~> ' gitName
read -p 'Input your desire number for ccache size in gigs ~> ' ccacheSize

clear

dpkg --add-architecture i386

sudo apt-get install -y openjdk-11-jdk \
                        bison \
                        g++-multilib \
                        git \
                        gperf \
                        libxml2-utils \
                        make \
                        zlib1g-dev:i386 \
                        zip \
                        liblz4-tool \
                        libncurses5 \
                        libssl-dev \
                        bc \
                        flex \
                        curl \
                        python-is-python3 \
                        zlib1g-dev

mkdir ~/bin \
&& curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo \
&& chmod a+x ~/bin/repo

git config --global user.email "$gitEmail" \
&& git config --global user.name "$gitName"

echo "
export PATH=~/bin:$PATH
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
" >> ~/.bashrc

ccache -M ${ccacheSize}G

exit 0