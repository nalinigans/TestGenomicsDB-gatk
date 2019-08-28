#!/bin/bash

BRANCH=master
if [ "$#" -eq 1  ]; then
        BRANCH=$1
fi

(docker build --build-arg os=centos:7 --build-arg branch=$1 -t gatk:centos7 . && \
docker build --build-arg os=ubuntu --build-arg branch=$1 -t gatk:ubuntu . && \
docker image rm -f gatk:centos7 && \
docker image rm -f gatk:ubuntu) || \
(echo "Something wrong with the gatk-GenomicsDB Integration!" && \
exit 1)
