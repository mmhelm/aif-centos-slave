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

# Install the additional packages which are need for build the project's software
RUN \
	yum -y install \
		unzip \
		tar \
		git \
		perl-Data-Dumper \
		perl-Sort-Versions \
		perl-XML-Parser \
		gcc-c++ \
		time \
		bc \
		rpm-build \
		wget \
	&& \
	wget \
		http://dl.fedoraproject.org/pub/epel/7/x86_64/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm \
	&& \
	yum -y install \
		xmlstarlet-1.6.1-1.el7.x86_64.rpm \
	&& \
	rm -rf xmlstarlet-1.6.1-1.el7.x86_64.rpm \
	&& \
		wget \
		https://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz \
	&& \
	tar -xzf apache-maven-3.3.3-bin.tar.gz -C /opt \
	&& \
	rm -rf apache-maven-3.3.3-bin.tar.gz \
	&& \
	ln -s /opt/apache-maven-3.3.3/bin/mvn /usr/bin/mvn \
	&& \
	yum -y remove \
		jdk.x86_64 \
		wget \
	&& \
	yum clean all

# Switch back to user `jenkins`
USER jenkins