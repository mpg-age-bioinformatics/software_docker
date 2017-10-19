# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.0.0 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:f53096da59a6975c5ce22ea953d97fe703c6307904fb05df036c39564a7248d8

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN cd $SOUR && wget ftp://ftp.gnu.org/gnu/gsl//gsl-2.4.tar.gz && \
  mkdir -p $SOFT/gsl/2.4.0 && \
  tar -zxvf gsl-2.4.tar.gz && \
  cd gsl-2.4 && \
  ./configure --prefix=$SOFT/gsl/2.4.0 && \
  make && \
  make install && \
  newmod.sh \
  -s gsl \
  -p $MODF/libs/ \
  -v 2.4.0 \
  -d 2.4.0 && \
  echo "prepend-path LIBRARY_PATH /modules/software/gsl/2.4.0/lib" >> $MODF/libs/gsl/2.4.0

RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load gsl/2.4.0 && \
  cd $SOUR && wget http://smithlabresearch.org/downloads/methpipe-3.4.3.tar.bz2 && \
  mkdir -p $SOFT/methpipe/3.4.3 && \
  tar -jxvf methpipe-3.4.3.tar.bz2 && \
  cd methpipe-3.4.3 && \
  make all && \
  make install && \
  cp -r *  $SOFT/methpipe/3.4.3/ && \
  newmod.sh \
  -s methpipe \
  -p $MODF/bioinformatics/ \
  -v 3.4.3 \
  -d 3.4.3 && \
  echo "module load gsl/2.4.0" >> $MODF/bioinformatics/methpipe/3.4.3'

RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load gsl/2.4.0 && \
  cd $SOUR && git clone https://github.com/smithlabcode/walt.git && \
  mkdir -p $SOFT/walt/1.0.0 && \
  cd walt && \
  make all && \
  make install && \
  cp -r * $SOFT/walt/1.0.0/ && \
  newmod.sh \
  -s walt \
  -p $MODF/bioinformatics/ \
  -v 1.0.0 \
  -d 1.0.0 && \
  echo "module load gsl/2.4.0" >> $MODF/bioinformatics/walt/1.0.0'

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.0.1
COPY Dockerfile /Dockerfiles/v1.0.1/Dockerfile
USER $NB_USER
