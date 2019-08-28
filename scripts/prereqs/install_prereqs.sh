#!/bin/bash

PREREQS_ENV=/etc/profile.d/prereqs.sh
touch $PREREQS_ENV

apt_get_install() {
	apt-get --version && source install_ubuntu_prereqs.sh && install_prerequisites_ubuntu
}

yum_install() {
	yum version && source install_centos_prereqs.sh && install_prerequisites_centos
}

install_os_prerequisites() {
	case `uname` in
		Linux )
			apt_get_install || yum_install
			;;
		Darwin )
			echo "Mac OS not yet supported"
			exit 1
	esac
}

install_prerequisites() {
	install_os_prerequisites &&
	source $PREREQS_ENV
}

install_prerequisites
