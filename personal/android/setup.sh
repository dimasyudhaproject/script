#!/bin/bash
#
# Copyright (C) Dimas Yudha Pratama <fsdimasyudha@gmail.com>
#
# This script works flawlessly on Ubuntu 22.04 LTS
# And proly won't work on below that version
# Also haven't support yet for other distros
# But might work on Debian-based distros & other Ubuntu flavors
#

clear

read -p 'Input your Git email ~> ' gitEmail
read -p 'Input your Git name ~> ' gitName
read -p 'Input your desire number for ccache size in gigs ~> ' ccacheSize

clear

# Update installed pkgs
sudo apt-get update \
&& sudo apt-get upgrade -y

# Enable i386 architecture
dpkg --add-architecture i386

# Install needed pkgs
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
                        zlib1g-dev \
                        ccache

# Install repo
mkdir -p ~/bin \
&& curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo \
&& chmod a+x ~/bin/repo

# Specify user's git email & name
git config --global user.email "$gitEmail" \
&& git config --global user.name "$gitName"

# Export needed variables & store them all on bashrc
echo "
export PATH=~/bin:$PATH
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
" >> ~/.bashrc

# Define ccache size
ccache -M ${ccacheSize}G

exit 0
