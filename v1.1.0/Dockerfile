# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.0.1 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:725bfb8a05ee5b0120cb03af0d2a0540532a6ceb1e5ea7906b3e950043832783

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN mkdir -p $SOFT/bwtool/face601 && mkdir $SOUR/bwtool-face601 && \
  cd $SOUR/bwtool-face601 && \
  git clone https://github.com/CRG-Barcelona/bwtool.git && \
  cd bwtool && git reset --hard face6010e09cd7480e2e01d1e479bb82cbfb5cbc && cd .. && \
  git clone https://github.com/CRG-Barcelona/libbeato.git && \
  cd libbeato && git reset --hard 2124facbb0ca7eb18c1df438a262d549199263fb && \
  ./configure --prefix=$SOFT/bwtool/face601 CFLAGS="-g -O0 -I${SOFT}/bwtool/face601/include" LDFLAGS=-L${SOFT}/bwtool/face601/lib && \
  make && make install && cd ../bwtool/ && \
  ./configure --prefix=$SOFT/bwtool/face601 CFLAGS="-g -O0 -I${SOFT}/bwtool/face601/include" LDFLAGS=-L${SOFT}/bwtool/face601/lib && \
  make && make install && \
  newmod.sh \
  -s bwtool \
  -p $MODF/bioinformatics/ \
  -v face601 \
  -d face601

RUN apt-get install -yq curl libcurl3 libcurl3-dev

RUN mkdir -p $SOFT/perl/5.24.1/bin && \
  cd $SOFT/perl/5.24.1/bin && \
  curl -L https://cpanmin.us/ -o cpanm && \
  chmod +x cpanm && \
  newmod.sh -s perl -p $MODF/general -v 5.24.1 -d 5.24.1 && \
  echo 'set home $::env(HOME)' >> $MODF/general/perl/5.24.1 && \
  echo 'set perluser $home/.software_container/.perl/5.24.1' >> $MODF/general/perl/5.24.1 && \
  echo 'exec /bin/mkdir -p $perluser' >> $MODF/general/perl/5.24.1 && \
  echo 'prepend-path PERL5LIB $perluser/lib/perl5' >> $MODF/general/perl/5.24.1 && \
  echo 'setenv PERLUSER $perluser' >> $MODF/general/perl/5.24.1

RUN mkdir -p $SOFT/jdk/8.0.151/bin && \
  cd $SOUR && curl -J -O https://datashare.mpcdf.mpg.de/s/WZ9q3RKowOZQAXf/download && \
  tar -zxvf jdk1.8.0_151.tar.gz && \
  cd jdk1.8.0_151 && \
  cp -r * $SOFT/jdk/8.0.151/ && \
  newmod.sh \
  -s jdk \
  -p $MODF/general/ \
  -v 8.0.151 \
  -d 8.0.151

RUN mkdir -p $SOFT/gatk/4.beta.5/bin && \
  cd $SOUR && \
  wget -O gatk-4.beta.5.zip  https://software.broadinstitute.org/gatk/download/auth?package=BETA && \
  unzip gatk-4.beta.5.zip && \
  cd gatk-4.beta.5 && \
  cp * $SOFT/gatk/4.beta.5/bin && \
  newmod.sh \
  -s gatk \
  -p $MODF/bioinformatics/ \
  -v 4.beta.5 \
  -d 4.beta.5 && \
  echo 'module load jdk/8.0.151' >> $MODF/bioinformatics/gatk/4.beta.5




##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.0.2
COPY Dockerfile /Dockerfiles/v1.0.2/Dockerfile
USER $NB_USER
