# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.8
LABEL maintainer "bioinformatics@age.mpg.de"
USER root

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \ 
    libxml-libxml-perl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    cd ${SOUR} && \
    V=2.11.0 && \
    wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/$V/sratoolkit.$V-centos_linux64-cloud.tar.gz && \
    tar -zxvf  sratoolkit.2.11.0-centos_linux64-cloud.tar.gz && \
    mkdir -p $SOFT/sratoolkit/2.11.0/ && \
    mv ./usr/local/ncbi/sra-tools/bin $SOFT/sratoolkit/2.11.0/ && \
    newmod.sh \
    -s sratoolkit \
    -p $MODF/bioinformatics/ \
    -v 2.11.0 \
    -d 2.11.0 &&\
    rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.9
COPY Dockerfile /Dockerfiles/v3.0.9
USER $NB_USER