# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v3.0.6

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

# Installing OPENMPI for MEME
RUN apt-get update && \
  apt-get install -yq openmpi-bin openmpi-common openssh-client openssh-server libopenmpi3 libopenmpi-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing MEME version 5.3.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load perl && \
  mkdir -p $SOFT/meme/5.3.0/bin && \
  export PERL5LIB="$SOFT/meme/5.3.0/lib/perl5" && \
  cpanm inc::latest@0.500 -l $SOFT/meme/5.3.0/ && \
  cpanm Module::Build@0.4222 -l $SOFT/meme/5.3.0/ && \
  cpanm HTML::Tree@5.06 -l $SOFT/meme/5.3.0/ && \
  cpanm HTML::Tagset@3.20 -l $SOFT/meme/5.3.0/ && \
  cpanm File::Slurp::Tiny@0.004 -l $SOFT/meme/5.3.0/ && \
  cpanm LWP@6.26 -l $SOFT/meme/5.3.0/ && \
  cpanm CGI@4.38 -l $SOFT/meme/5.3.0/ && \
  cpanm Log::Report@1.19 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile@1.56 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::Cache@1.05 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::Tester@0.90 -l $SOFT/meme/5.3.0/ && \
  cpanm IPC::Run3@0.048 -l $SOFT/meme/5.3.0/ && \
  cpanm Probe::Perl@0.03 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::NamespaceSupport@1.12 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::SAX::Base@1.09 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::SAX@0.99 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::SAX::Expat@0.51 -l $SOFT/meme/5.3.0/ && \
  cpanm HTML::Parser@3.72 -l $SOFT/meme/5.3.0/ && \
  cpanm HTML::PullParser -l $SOFT/meme/5.3.0/ && \
  cpanm HTML::Template@2.95 -l $SOFT/meme/5.3.0/ && \
  cpanm JSON@2.90 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::SOAP@3.21 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::SOAP11 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::WSDL11@3.06 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::Transport::SOAPHTTP -l $SOFT/meme/5.3.0/ && \
  cpanm Log::Log4perl@1.49 -l $SOFT/meme/5.3.0/ && \
  cpanm Math::CDF@0.1 -l $SOFT/meme/5.3.0/ && \
  cpanm Test::Script -l $SOFT/meme/5.3.0/ && \
  cpanm Test::Simple@1.302085 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Simple@2.24 -l $SOFT/meme/5.3.0/ && \
  cpanm File::Which@1.21 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Parser@2.44 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Parser::Expat -l $SOFT/meme/5.3.0/ && \
  cpanm Date::Format@2.24 -l $SOFT/meme/5.3.0/ && \
  cpanm Date::Language@1.10 -l $SOFT/meme/5.3.0/ && \
  cpanm TimeDate -l $SOFT/meme/5.3.0/ && \
  cpanm Time::Zone@2.24 -l $SOFT/meme/5.3.0/ && \
  cpanm Devel::GlobalDestruction@0.14 -l $SOFT/meme/5.3.0/ && \
  cpanm URI@1.71 -l $SOFT/meme/5.3.0/ && \
  cpanm Net::HTTP@6.17 -l $SOFT/meme/5.3.0/ && \
  cpanm XML::Compile::SOAP@3.22 -l $SOFT/meme/5.3.0/ && \
  cd $SOUR && wget https://downloads.python.org/pypy/pypy3.7-v7.3.3-linux64.tar.bz2 && \
  tar -jxvf pypy3.7-v7.3.3-linux64.tar.bz2 && \
  cp -a pypy3.7-v7.3.3-linux64 $SOFT/meme/5.3.0/ && \
  cd $SOUR && wget http://meme-suite.org/meme-software/5.3.0/meme-5.3.0.tar.gz && \
  tar -zxvf meme-5.3.0.tar.gz && cd meme-5.3.0 && \     
  cd $SOUR && cd meme-5.3.0 && \
  ./configure --prefix=${SOFT}/meme/5.3.0 --with-python=$SOFT/meme/5.3.0/pypy3.7-v7.3.3-linux64/bin/pypy --with-url=http://meme-suite.org --enable-build-libxml2 --enable-build-libxslt && \
  make && make test ; \
  cd $SOUR/meme-5.3.0 && make install && \
  newmod.sh \
  -s meme \
  -p $MODF/bioinformatics/ \
  -v 5.3.0 \
  -d 5.3.0 && \
  echo "module load perl" >> $MODF/bioinformatics/meme/5.3.0 && \
  echo "prepend-path PERL5LIB $SOFT/meme/5.3.0/lib/perl5" >> $MODF/bioinformatics/meme/5.3.0' && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v3.0.7
COPY Dockerfile /Dockerfiles/v3.0.7
USER $NB_USER
