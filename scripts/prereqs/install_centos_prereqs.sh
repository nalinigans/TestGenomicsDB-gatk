#!/bin/bash

install_openjdk() {
	echo "Installing openjdk" &&
	yum install -y java-1.8.0-openjdk-devel &&
	echo "export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk" >> $PREREQS_ENV &&
	echo "export JRE_HOME=/usr/lib/jvm/jre" >> $PREREQS_ENV
}

install_prerequisites_centos() {
	yum update -y -q &&
	yum install -y -q epel-release &&
	yum install -y -q which wget git git-lfs &&
	git lfs install --skip-smudge &&
	install_openjdk
}
