# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0-4

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

RUN apt-get update && \
  apt-get install -yq rsync && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing kentTools version 390
RUN mkdir -p $SOFT/kenttools/435/bin && \
    cd $SOFT/kenttools/435/bin/ && \
    rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./ && \
    chmod -R +x ./* && \
    mv blat blatdir && \
    ln -s ./blatdir/blat ./ && \
    ln -s ./blatdir/gf* ./ && \
    newmod.sh \
    -s kenttools \
    -p $MODF/bioinformatics/ \
    -v 435 \
    -d 435 && \
    rm -rf ${SOUR}/*




##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v4.0.0-5
COPY Dockerfile /Dockerfiles/v4.0.0-5/

USER $NB_USER