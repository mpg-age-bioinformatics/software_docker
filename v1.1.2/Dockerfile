# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.1.1 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:0e17cca421e430edec9253f5f6b2007a82238bd0668fa2c37b229c7d9c4e8f87

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN cd $SOUR && \
  wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.1.Linux_x86_64.tar.gz && \
  tar -zxvf stringtie-1.3.1.Linux_x86_64.tar.gz && \
  cd stringtie-1.3.1.Linux_x86_64 && \
  mkdir -p $SOFT/stringtie/1.3.1/bin && \
  cp -r * $SOFT/stringtie/1.3.1/bin && \
  newmod.sh \
  -s stringtie \
  -p $MODF/bioinformatics/ \
  -v 1.3.1 \
  -d 1.3.1

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.1.2
COPY Dockerfile /Dockerfiles/v1.1.2/Dockerfile
USER $NB_USER
