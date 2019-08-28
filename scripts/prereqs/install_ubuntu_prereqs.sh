#!/bin/bash

install_openjdk8() {
	apt-get -y install openjdk-8-jdk icedtea-plugin &&
	apt-get update -q &&
	pushd $HOME &&
	git clone https://github.com/michaelklishin/jdk_switcher.git &&
	source jdk_switcher/jdk_switcher.sh && jdk_switcher use openjdk8 &&
	echo "export JAVA_HOME=$JAVA_HOME" >> $PREREQS_ENV &&
	popd
}

install_prerequisites_ubuntu() {
	apt-get update -q &&
	apt-get -y install \
					build-essential \
					software-properties-common \
					wget \
					git \
					git-lfs \
					zip \
					python3.6 \
					sudo &&
	apt-get update -q &&
	git lfs install --skip-smudge &&
	add-apt-repository ppa:ubuntu-toolchain-r/test -y &&
	add-apt-repository -y ppa:openjdk-r/ppa &&
	apt-get update -q &&
	install_openjdk8 &&
	update-alternatives --install /usr/bin/python python /usr/bin/python3 10 &&
	apt-get clean &&
	apt-get purge -y &&
	rm -rf /var/lib/apt/lists*
}
