# The MIT License
#
#  Copyright (c) 2017, Markus Helm
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

FROM mhelm/docker-centos-slave:latest
MAINTAINER Markus Helm <markus.m.helm@live.de>

# Switch to user `root` to install the packages
USER root

# Workaround for fixing a locale bug, see https://github.com/CentOS/sig-cloud-instance-images/issues/71
RUN \
	sudo sed -i 's/en_US\.UTF-8/en_US.utf8/' /etc/yum.conf

# Install the additional packages which are need for build the project's software
RUN \
	yum -y install \
		xorg-x11-server-Xvfb \
		unzip \
		tar \
		git \
		perl-Data-Dumper \
		perl-Sort-Versions \
		perl-XML-Parser \
		gcc-c++ \
		wget \
		p7zip \
		p7zip-plugins \
	&& \
	wget \
		http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm \
	&& \
	yum -y install \
		xmlstarlet-1.6.1-1.el7.x86_64.rpm \
	&& \
	rm -rf xmlstarlet-1.6.1-1.el7.x86_64.rpm \
	&& \
	yum -y erase \
		wget \
	&& yum -y install \
	    device-mapper-persistent-data \
		lvm2 \
		docker \
	&& \
	yum clean all

ENV LANG="en_US.UTF-8"
ENV LC_CTYPE="en_US.UTF-8"
ENV LC_NUMERIC="en_US.UTF-8"
ENV LC_TIME="en_US.UTF-8"
ENV LC_COLLATE="en_US.UTF-8"
ENV LC_MONETARY="en_US.UTF-8"
ENV LC_MESSAGES="en_US.UTF-8"
ENV LC_PAPER="en_US.UTF-8"
ENV LC_NAME="en_US.UTF-8"
ENV LC_ADDRESS="en_US.UTF-8"
ENV LC_TELEPHONE="en_US.UTF-8"
ENV LC_MEASUREMENT="en_US.UTF-8"
ENV LC_IDENTIFICATION="en_US.UTF-8"
ENV LC_ALL=

# Switch back to user `jenkins`
USER jenkins
