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
  
RUN cd $SOUR && git clone https://github.com/nsoranzo/sspace_basic.git &&\
  cd sspace_basic && \
  mkdir -p $SOFT/sspace/2.0.0
  git checkout cdd1d392d7eb89bf21dd0c6d57055b5f86a73efe && \
  for f in $(ls *.pl); do { echo '#!/usr/bin/env perl' ; cat ${f} ; } > ${f%.pl} ; chmod +x ${f%.pl}; done && \
  cd bin && \
  for f in $(ls *.pl); do { echo '#!/usr/bin/env perl' ; cat ${f} ; } > ${f%.pl} ; chmod +x ${f%.pl}; done && \
  cd ../tools && \
  for f in $(ls *.pl); do { echo '#!/usr/bin/env perl' ; cat ${f} ; } > ${f%.pl} ; chmod +x ${f%.pl}; done && \
  cd ../ && \
  cp -r * $SOFT/sspace/2.0.0 && \
  newmod.sh \
  -s sspace \
  -p $MODF/bioinformatics/ \
  -v 2.0.0 \
  -d 2.0.0 && \
  echo "prepend-path PATH $SOFT/sspace/2.0.0" >> $MODF/bioinformatics/sspace/2.0.0

RUN apt-get install curl libcurl3 libcurl3-dev
  
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

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.0.2
COPY Dockerfile /Dockerfiles/v1.0.2/Dockerfile
USER $NB_USER
