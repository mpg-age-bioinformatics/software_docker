# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0-3

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

# Install expat
RUN cd $SOUR && \
    wget http://downloads.sourceforge.net/project/expat/expat/2.4.8/expat-2.4.8.tar.bz2 && \
    mkdir -p $SOFT/expat/2.4.8/bin && \
    tar -jxvf expat-2.4.8.tar.bz2 && \
    cd expat-2.4.8 && ./configure --prefix=$SOFT/expat/2.4.8 && make && make install && \
    newmod.sh \
    -s expat \
    -p $MODF/bioinformatics/ \
    -v 2.4.8 \
    -d 2.4.8 && \
    rm -rf ${SOUR}/*

# homer v2.0.0
RUN cd $SOUR && \
  mkdir -p $SOFT/homer/4.11.0/bin && \
  cd $SOFT/homer/4.11.0 && \
  wget http://homer.ucsd.edu/homer/configureHomer.pl && \
  perl configureHomer.pl -install && \
  newmod.sh \
  -s homer \
  -p $MODF/bioinformatics/ \
  -v 4.11.0 \
  -d 4.11.0 && \
  echo "module load samtools rlang" >> $MODF/bioinformatics/homer/4.10.0 && \
  rm -rf ${SOUR}/*

# Install ImageMagick 7.1.0-47
RUN cd $SOUR && \
  wget https://imagemagick.org/archive/ImageMagick.tar.gz && \
  mkdir -p $SOFT/imagemagick/7.1.0-47 && \
  tar -zxvf ImageMagick.tar.gz && \
  cd ImageMagick-7.1.0-47 && ./configure --prefix=$SOFT/imagemagick/7.1.0-47 && make && make install && \
  newmod.sh \
  -s imagemagick \
  -p $MODF/libs \
  -v 7.1.0-47 \
  -d 7.1.0-47 && \
  rm -rf ${SOUR}/*

# Install seqtk version 1.3
RUN cd $SOUR && \
  wget https://github.com/lh3/seqtk/archive/v1.3.tar.gz && \
  mkdir -p $SOFT/seqtk/1.3.0/bin && \
  tar -zxvf v1.3.tar.gz && \
  cd seqtk-1.3 && make && cp * $SOFT/seqtk/1.3.0/bin && \
  newmod.sh \
  -s seqtk \
  -p $MODF/bioinformatics/ \
  -v 1.3.0 \
  -d 1.3.0 && \
  rm -rf ${SOUR}/*

## Install bcl2fastq2
#RUN cd $SOUR && \
#  wget -O bcl2fastq2-v2-20-0-tar.zip ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip && \
#	unzip bcl2fastq2-v2-20-0-tar.zip && \
#	tar -zxvf bcl2fastq2-v2.20.0.422-Source.tar.gz && \
#	mv bcl2fastq bcl2fastq2-v2.20.0.422 && \
#	cd bcl2fastq2-v2.20.0.422 && \
#  mkdir -p $SOFT/bcl2fastq/2.20.0.422 && \
#  mkdir -p build && cd build && \
#  CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH" ../src/configure --prefix=$SOFT/bcl2fastq/2.20.0.422 && \
#  CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH" make && \
#  CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH" make install && \
#  newmod.sh \
#  -s bcl2fastq \
#  -p $MODF/bioinformatics/ \
#  -v 2.20.0.422 \
#  -d 2.20.0.422 && \
#  rm -rf ${SOUR}/*

# Install rsem version 1.3.3
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load rlang && \
  cd $SOUR && wget -O rsem-v1.3.3.tar.gz https://github.com/deweylab/RSEM/archive/v1.3.3.tar.gz && \ 
  tar -zxvf rsem-v1.3.3.tar.gz && \
  mkdir -p $SOFT/rsem/1.3.3 && \
  mv RSEM-1.3.3 $SOFT/rsem/1.3.3/bin  && \
  cd $SOFT/rsem/1.3.3/bin && \
  make && make ebseq && \
  newmod.sh \
  -s rsem \
  -p $MODF/bioinformatics/ \
  -v 1.3.3 \
  -d 1.3.3 && \
  echo "module load rlang" >> $MODF/bioinformatics/rsem/1.3.3 && \
  echo "prepend-path R_LIBS_USER $SOFT/rsem/1.3.3/bin/EBSeq" >> $MODF/bioinformatics/rsem/1.3.3' && \
  rm -rf ${SOUR}/*

# Install bamutil version 1.0.15 v2.0.0
RUN cd $SOUR && \
  wget -O bamutil-1.0.15.tar.gz https://github.com/statgen/bamUtil/archive/v1.0.15.tar.gz && \
  wget -O libStatGen-v1.0.15.tar.gz https://github.com/statgen/libStatGen/archive/refs/tags/v1.0.15.tar.gz && \
	mkdir -p $SOFT/bamutil/1.0.15/bin && \
	tar -zxvf bamutil-1.0.15.tar.gz && \
  tar -zxvf libStatGen-v1.0.15.tar.gz && \
  mv libStatGen-1.0.15 libStatGen && \
	cd bamUtil-1.0.15 && \
	make && \
	make install INSTALLDIR=$SOFT/bamutil/1.0.15/bin && \
  newmod.sh \
  -s bamutil \
  -p $MODF/bioinformatics/ \
  -v 1.0.15 \
  -d 1.0.15 && \
  rm -rf ${SOUR}/*

# kallisto; v2.0.6
RUN cd $SOUR && wget https://github.com/pachterlab/kallisto/releases/download/v0.48.0/kallisto_linux-v0.48.0.tar.gz && \
    tar -zxvf kallisto_linux-v0.48.0.tar.gz && \
    mkdir -p $SOFT/kallisto/0.48.0/bin && \
    mv kallisto/* $SOFT/kallisto/0.48.0/ && \
    mv $SOFT/kallisto/0.48.0/kallisto $SOFT/kallisto/0.48.0/bin/ && \
    rm -rf $SOUR/* && \
    newmod.sh \
    -s kallisto \
    -p $MODF/bioinformatics/ \
    -v 0.48.0 \
    -d 0.48.0 

# iSeeRNA
RUN cd $SOUR && wget --no-check-certificate https://mcell.net/iSeeRNA/data/iSeeRNA-1.2.2.x86_64.tar.gz && \
    tar -zxvf iSeeRNA-1.2.2.x86_64.tar.gz && \
    mkdir -p $SOFT/iseerna/1.2.2 && \
    mv $SOUR/iSeeRNA-1.2.2/* $SOFT/iseerna/1.2.2 && \
    rm -rf $SOUR/* && \
    newmod.sh \
    -s iseerna \
    -p $MODF/bioinformatics/ \
    -v 1.2.2 \
    -d 1.2.2 && \
    echo "prepend-path PATH $SOFT/iseerna/1.2.2" >> $MODF/bioinformatics/iseerna/1.2.2

# Installing OPENMPI for MEME
RUN apt-get update && \
  apt-get install -yq openmpi-bin openmpi-common openssh-client openssh-server libopenmpi3 libopenmpi-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing MEME version 5.4.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load perl && \
  mkdir -p $SOFT/meme/5.4.0/bin && \
  export PERL5LIB="$SOFT/meme/5.4.0/lib/perl5" && \
  cpanm inc::latest -l $SOFT/meme/5.4.0/ && \
  cpanm Module::Build -l $SOFT/meme/5.4.0/ && \
  cpanm HTML::Tree -l $SOFT/meme/5.4.0/ && \
  cpanm HTML::Tagset -l $SOFT/meme/5.4.0/ && \
  cpanm File::Slurp::Tiny -l $SOFT/meme/5.4.0/ && \
  cpanm LWP -l $SOFT/meme/5.4.0/ && \
  cpanm CGI -l $SOFT/meme/5.4.0/ && \
  cpanm Log::Report -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::Cache -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::Tester -l $SOFT/meme/5.4.0/ && \
  cpanm IPC::Run3 -l $SOFT/meme/5.4.0/ && \
  cpanm Probe::Perl -l $SOFT/meme/5.4.0/ && \
  cpanm XML::NamespaceSupport -l $SOFT/meme/5.4.0/ && \
  cpanm XML::SAX::Base -l $SOFT/meme/5.4.0/ && \
  cpanm XML::SAX -l $SOFT/meme/5.4.0/ && \
  cpanm XML::SAX::Expat -l $SOFT/meme/5.4.0/ && \
  cpanm HTML::Parser -l $SOFT/meme/5.4.0/ && \
  cpanm HTML::PullParser -l $SOFT/meme/5.4.0/ && \
  cpanm HTML::Template -l $SOFT/meme/5.4.0/ && \
  cpanm JSON -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::SOAP -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::SOAP11 -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::WSDL11 -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::Transport::SOAPHTTP -l $SOFT/meme/5.4.0/ && \
  cpanm Log::Log4perl -l $SOFT/meme/5.4.0/ && \
  cpanm Math::CDF -l $SOFT/meme/5.4.0/ && \
  cpanm Test::Script -l $SOFT/meme/5.4.0/ && \
  cpanm Test::Simple -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Simple -l $SOFT/meme/5.4.0/ && \
  cpanm File::Which -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Parser -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Parser::Expat -l $SOFT/meme/5.4.0/ && \
  cpanm Date::Format -l $SOFT/meme/5.4.0/ && \
  cpanm Date::Language -l $SOFT/meme/5.4.0/ && \
  cpanm Date::Parse -l $SOFT/meme/5.4.0/ && \
  cpanm Time::Zone -l $SOFT/meme/5.4.0/ && \
  cpanm Devel::GlobalDestruction -l $SOFT/meme/5.4.0/ && \
  cpanm URI -l $SOFT/meme/5.4.0/ && \
  cpanm Net::HTTP -l $SOFT/meme/5.4.0/ && \
  cpanm XML::Compile::SOAP -l $SOFT/meme/5.4.0/ && \
  cd $SOUR && wget https://github.com/squeaky-pl/portable-pypy/releases/download/pypy3.6-7.2.0/pypy3.6-7.2.0-linux_x86_64-portable.tar.bz2 && \
  tar -jxvf pypy3.6-7.2.0-linux_x86_64-portable.tar.bz2 && \
  cp -a pypy3.6-7.2.0-linux_x86_64-portable $SOFT/meme/5.4.0/ && \
  cd $SOUR && wget http://meme-suite.org/meme-software/5.4.0/meme-5.4.0.tar.gz && \
  tar -zxvf meme-5.4.0.tar.gz && cd meme-5.4.0 && \     
  cd $SOUR && cd meme-5.4.0 && \
  ./configure --prefix=${SOFT}/meme/5.4.0 --with-python=$SOFT/meme/5.4.0/pypy3.6-7.2.0-linux_x86_64-portable/bin/pypy --with-url=http://meme-suite.org --enable-build-libxml2 --enable-build-libxslt && \
  make && make test ; \
  cd $SOUR/meme-5.4.0 && make install && \
  newmod.sh \
  -s meme \
  -p $MODF/bioinformatics/ \
  -v 5.4.0 \
  -d 5.4.0 && \
  echo "module load perl" >> $MODF/bioinformatics/meme/5.4.0 && \
  echo "prepend-path PERL5LIB $SOFT/meme/5.4.0/lib/perl5" >> $MODF/bioinformatics/meme/5.4.0' && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v4.0.0-4
COPY Dockerfile /Dockerfiles/v4.0.0-4/

USER $NB_USER