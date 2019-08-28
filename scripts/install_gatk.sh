#!/bin/bash

GATK_USER=${1:-gatk}
GATK_BRANCH=${2:-master}
GATK_USER_DIR=`eval echo ~$GATK_USER`
GATK_DIR=$GATK_USER_DIR/gatk
echo GATK_DIR=$GATK_DIR

build_gatk() {
	. /etc/profile &&
	git clone https://github.com/broadinstitute/gatk.git -b $GATK_BRANCH $GATK_DIR &&
	pushd $GATK_DIR &&
	./gradlew installDist &&
	popd
}

build_gatk
chown -R $GATK_USER:$GATK_USER $GATK_USER_DIR
