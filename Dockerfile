# The MIT License (MIT)
# Copyright (c) 2019 Omics Data Automation, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Description: Docker file for building and testing gatk with GenomicsDB

# OS'es currently tested are ubuntu:trusty and centos:7
#ARG os=ubuntu:trusty
ARG os=centos:7
FROM $os

ARG branch=master
ARG user=gatk

COPY scripts/prereqs /build
WORKDIR /build
RUN ./install_prereqs.sh

RUN groupadd -r gatk && useradd -r -g gatk -m ${user} -p ${user}

# Build and install gatk from specified branch
COPY scripts/install_gatk.sh /build
WORKDIR /build
RUN ./install_gatk.sh ${user} ${branch}

# Sanity test GenomicsDB operations from gatk
COPY test/vcfs /test/vcfs
COPY test/reference /test/reference

USER ${user}
WORKDIR /home/${user}/gatk
RUN ./gatk GenomicsDBImport -V /test/vcfs/t0.vcf --genomicsdb-workspace-path gdb_ws -L 1:500-100000
RUN ./gatk SelectVariants -V gendb://gdb_ws -R /test/reference/chr1_10MB.fasta.gz -O out.vcf

#ENTRYPOINT ["/bin/bash", "--login"]
