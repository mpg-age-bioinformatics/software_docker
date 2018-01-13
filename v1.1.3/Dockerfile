# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.1.2 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:ff806bde63bd2eb1f983c3d980f416e5b398faf1f5804777c2b66094fb5ceeca

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN apt-get install libtbb2 libtbb-dev

RUN cd $SOUR && \
  wget https://github.com/seqan/seqan/releases/download/seqan-v2.2.0/seqan-library-2.2.0.tar.xz && \
  wget https://github.com/seqan/flexbar/archive/v3.0.3.tar.gz && \
  mv v3.0.3.tar.gz flexbar-v3.0.3 && \
  tar -xvf seqan-library-2.2.0.tar.xz && \
  tar -zxvf flexbar-v3.0.3 && \
  cp -r seqan-library-2.2.0/include flexbar-3.0.3/ && \
  cd flexbar-3.0.3 && \
  cmake . && make && \
  mkdir -p $SOFT/flexbar/3.0.3/bin && \
  cp -r * $SOFT/flexbar/3.0.3 && \
  cp flexbar $SOFT/flexbar/3.0.3/bin && \
  newmod.sh \
  -s flexbar \
  -p $MODF/bioinformatics/ \
  -v 3.0.3 \
  -d 3.0.3

RUN cd $SOUR && \
  wget https://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.2.2/bowtie-1.2.2-linux-x86_64.zip && \
  unzip bowtie-1.2.2-linux-x86_64.zip && \
  mkdir -p $SOFT/bowtie/1.2.2/bin && \
  cd bowtie-1.2.2-linux-x86_64 && \
  cp bowt* $SOFT/bowtie/1.2.2/bin && \
  newmod.sh \
  -s bowtie \
  -p $MODF/bioinformatics/ \
  -v 1.2.2

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.1.3
COPY Dockerfile /Dockerfiles/v1.1.3/Dockerfile
USER $NB_USER
