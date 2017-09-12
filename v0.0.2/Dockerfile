# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v0.0.1 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:fd25c85d5dc40c39b29312b9b1783f5bcb74f38c779aeea645b94517093f1d0e 

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN cd $SOUR && wget -O l.zip https://sourceforge.net/projects/lofreq/files/lofreq_star-2.1.2_linux-x86-64.tgz/download && \
    mv l.zip lofreq_star-2.1.2_linux-x86-64.tgz && \
    rm -rf lofreq && \
    mkdir -p $SOFT/lofreq/2.1.2 && \
    tar xfvz lofreq_star-2.1.2_linux-x86-64.tgz && \
    mv lofreq_star-2.1.2/bin $SOFT/lofreq/2.1.2/ && \
    rmdir lofreq_star-2.1.2 && \
    newmod.sh \
    -s lofreq \
    -p $MODF/bioinformatics/ \
    -v 2.1.2 \
    -d 2.1.2

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v0.0.1 /Dockerfiles/v0.0.2
COPY .Dockerfile.v0.0.1 /Dockerfiles/v0.0.1/Dockerfile
COPY Dockerfile /Dockerfiles/v0.0.2/

USER $NB_USER
COPY .bashrc $HOME/.bashrc
