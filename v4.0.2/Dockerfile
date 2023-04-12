# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.1
LABEL maintainer "bioinformatics@age.mpg.de"
USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

RUN apt-get update && \ 
  apt-get install -yq \
  libssl-dev \
  libcurl4-openssl-dev \
  libgeos-c1v5 \
  libgeos-dev \
  libudunits2-dev \
  libudunits2-0 \
  libpng16-16 \
  libpng-dev \
  acl \
  libxml-libxml-perl \
  libjpeg-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*


### Adding STAR module

# star
RUN cd $SOUR && \
  wget https://github.com/alexdobin/STAR/archive/refs/tags/2.7.10b.tar.gz && \
  tar -xzf 2.7.10b.tar.gz && \
  cd STAR-2.7.10b && \
  mkdir -p $SOFT/star/2.7.10b/bin && \
  cp -r bin/Linux_x86_64_static/* $SOFT/star/2.7.10b/bin && \
  newmod.sh \
  -s star \
  -p $MODF/bioinformatics/ \
  -v 2.7.10b && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v4.0.2
COPY Dockerfile /Dockerfiles/v4.0.2
USER $NB_USER
