# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v3.0.0-4

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################


# Installing kentTools version 390
RUN mkdir -p $SOFT/kenttools/390/bin && \
    apt-get update && apt-get install rsync && \
    cd $SOFT/kenttools/390/bin/ && \
    rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./ && \
    chmod -R +x ./* && \
    mv blat blatdir && \
    ln -s ./blatdir/blat ./ && \
    ln -s ./blatdir/gf* ./ && \
    newmod.sh \
    -s kenttools \
    -p $MODF/bioinformatics/ \
    -v 390 \
    -d 390 && \
    rm -rf ${SOUR}/*




##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v3.0.0-5
COPY Dockerfile /Dockerfiles/v3.0.0-5/

USER $NB_USER