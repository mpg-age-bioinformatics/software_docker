# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.0.1 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:725bfb8a05ee5b0120cb03af0d2a0540532a6ceb1e5ea7906b3e950043832783

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN mkdir -p $SOFT/bwtool/git170623 && mkdir $SOUR/bwtool-git170623 && \
  cd $SOUR/bwtool-git170623 && \
  git clone https://github.com/CRG-Barcelona/bwtool.git && \
  cd bwtool && git reset --hard face6010e09cd7480e2e01d1e479bb82cbfb5cbc && cd .. && \
  git clone https://github.com/CRG-Barcelona/libbeato.git && \
  cd libbeato && git reset --hard 2124facbb0ca7eb18c1df438a262d549199263fb && \
  ./configure --prefix=$SOFT/bwtool/git170623 CFLAGS="-g -O0 -I${SOFT}/bwtool/git170623/include" LDFLAGS=-L${SOFT}/bwtool/git170623/lib && \
  make && make install && cd ../bwtool/ && \
  ./configure --prefix=$SOFT/bwtool/git170623 CFLAGS="-g -O0 -I${SOFT}/bwtool/git170623/include" LDFLAGS=-L${SOFT}/bwtool/git170623/lib && \
  make && make install && \
  newmod.sh \
  -s bwtool \
  -p $MODF/bioinformatics/ \
  -v git170623 \
  -d git170623


##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.0.2
COPY Dockerfile /Dockerfiles/v1.0.2/Dockerfile
USER $NB_USER
