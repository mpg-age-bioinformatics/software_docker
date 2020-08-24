# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.2
LABEL maintainer "bioinformatics@age.mpg.de"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################

RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load python/3.8.0 && \
    mkdir -p $SOFT/cutadapt/2.10/ && \
    python3 -m pip install --target $SOFT/cutadapt/2.10/ cutadapt==2.10 && \
    newmod.sh \
    -s cutadapt \
    -p $MODF/bioinformatics/ \
    -v 2.10 \
    -d 2.10 && \
    echo "prepend-path PATH $SOFT/cutadapt/2.10/bin" >> $MODF/bioinformatics/cutadapt/2.10 && \
    echo "prepend-path PYTHONPATH $SOFT/cutadapt/2.10/" >> $MODF/bioinformatics/cutadapt/2.10' && \
    rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.3
COPY Dockerfile /Dockerfiles/v3.0.3
USER $NB_USER
