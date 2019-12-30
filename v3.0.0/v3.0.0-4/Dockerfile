# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v3.0.0-3

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

# Install expat
RUN cd $SOUR && \
    wget http://downloads.sourceforge.net/project/expat/expat/2.2.9/expat-2.2.9.tar.bz2 && \
    mkdir -p $SOFT/expat/2.2.9/bin && \
    tar -jxvf expat-2.2.9.tar.bz2 && \
    cd expat-2.2.9 && ./configure --prefix=$SOFT/expat/2.2.9 && make && make install && \
    newmod.sh \
    -s expat \
    -p $MODF/bioinformatics/ \
    -v 2.2.9 \
    -d 2.2.9 && \
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

# Install ImageMagick 7.0.8-3
RUN cd $SOUR && \
  wget https://imagemagick.org/download/ImageMagick.tar.gz && \
  mkdir -p $SOFT/imagemagick/7.0.9-7 && \
  tar -zxvf ImageMagick.tar.gz && \
  cd ImageMagick-7.0.9-7 && ./configure --prefix=$SOFT/imagemagick/7.0.9-7 && make && make install && \
  newmod.sh \
  -s imagemagick \
  -p $MODF/libs \
  -v 7.0.9-7 \
  -d 7.0.9-7 && \
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

# Install bcl2fastq2
RUN cd $SOUR && \
  wget -O bcl2fastq2-v2-20-0-tar.zip ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip && \
	unzip bcl2fastq2-v2-20-0-tar.zip && \
	tar -zxvf bcl2fastq2-v2.20.0.422-Source.tar.gz && \
	mv bcl2fastq bcl2fastq2-v2.20.0.422 && \
	cd bcl2fastq2-v2.20.0.422 && \
  mkdir -p $SOFT/bcl2fastq/2.20.0.422 && \
  mkdir -p build && cd build && \
  CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH" ../src/configure --prefix=$SOFT/bcl2fastq/2.20.0.422 && \
  CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH" make && \
  CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu:$CPLUS_INCLUDE_PATH" make install && \
  newmod.sh \
  -s bcl2fastq \
  -p $MODF/bioinformatics/ \
  -v 2.20.0.422 \
  -d 2.20.0.422 && \
  rm -rf ${SOUR}/*

# Install rsem version 1.3.1
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load rlang && \
  cd $SOUR && wget -O rsem-v1.3.1.tar.gz https://github.com/deweylab/RSEM/archive/v1.3.1.tar.gz && \ 
  tar -zxvf rsem-v1.3.1.tar.gz && \
  mkdir -p $SOFT/rsem/1.3.1 && \
  mv RSEM-1.3.1 $SOFT/rsem/1.3.1/bin  && \
  cd $SOFT/rsem/1.3.1/bin && \
  make && make ebseq && \
  newmod.sh \
  -s rsem \
  -p $MODF/bioinformatics/ \
  -v 1.3.1 \
  -d 1.3.1 && \
  echo "module load rlang" >> $MODF/bioinformatics/rsem/1.3.1 && \
  echo "prepend-path R_LIBS_USER $SOFT/rsem/1.3.1/bin/EBSeq" >> $MODF/bioinformatics/rsem/1.3.1' && \
  rm -rf ${SOUR}/*

# Install bamutil version 1.0.14 v2.0.0
RUN cd $SOUR && \
  wget -O d.tar.gz https://github.com/statgen/bamUtil/archive/v1.0.14.tar.gz && \
	mv d.tar.gz bamutil-1.0.14.tar.gz && \
	mkdir -p $SOFT/bamutil/1.0.14/bin && \
	tar -zxvf bamutil-1.0.14.tar.gz && \
	cd bamUtil-1.0.14 && \
	make cloneLib && make && \
	make install INSTALLDIR=$SOFT/bamutil/1.0.14/bin && \
  newmod.sh \
  -s bamutil \
  -p $MODF/bioinformatics/ \
  -v 1.0.14 \
  -d 1.0.14 && \
  rm -rf ${SOUR}/*

# kallisto; v2.0.6
RUN cd $SOUR && wget https://github.com/pachterlab/kallisto/releases/download/v0.46.1/kallisto_linux-v0.46.1.tar.gz && \
    tar -zxvf kallisto_linux-v0.46.1.tar.gz && \
    mkdir -p $SOFT/kallisto/0.46.1/bin && \
    mv kallisto/* $SOFT/kallisto/0.46.1/ && \
    mv $SOFT/kallisto/0.46.1/kallisto $SOFT/kallisto/0.46.1/bin/ && \
    rm -rf $SOUR/* && \
    newmod.sh \
    -s kallisto \
    -p $MODF/bioinformatics/ \
    -v 0.46.1 \
    -d 0.46.1 

# iSeeRNA
RUN cd $SOUR && wget http://sunlab.cpy.cuhk.edu.hk/iSeeRNA/data/iSeeRNA-1.2.2.x86_64.tar.gz && \
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

# Installing MEME version 5.1.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load perl && \
  mkdir -p $SOFT/meme/5.1.0/bin && \
  export PERL5LIB="$SOFT/meme/5.1.0/lib/perl5" && \
  cpanm inc::latest@0.500 -l $SOFT/meme/5.1.0/ && \
  cpanm Module::Build@0.4222 -l $SOFT/meme/5.1.0/ && \
  cpanm HTML::Tree@5.06 -l $SOFT/meme/5.1.0/ && \
  cpanm HTML::Tagset@3.20 -l $SOFT/meme/5.1.0/ && \
  cpanm File::Slurp::Tiny@0.004 -l $SOFT/meme/5.1.0/ && \
  cpanm LWP@6.26 -l $SOFT/meme/5.1.0/ && \
  cpanm CGI@4.38 -l $SOFT/meme/5.1.0/ && \
  cpanm Log::Report@1.19 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile@1.56 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::Cache@1.05 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::Tester@0.90 -l $SOFT/meme/5.1.0/ && \
  cpanm IPC::Run3@0.048 -l $SOFT/meme/5.1.0/ && \
  cpanm Probe::Perl@0.03 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::NamespaceSupport@1.12 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::SAX::Base@1.09 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::SAX@0.99 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::SAX::Expat@0.51 -l $SOFT/meme/5.1.0/ && \
  cpanm HTML::Parser@3.72 -l $SOFT/meme/5.1.0/ && \
  cpanm HTML::PullParser -l $SOFT/meme/5.1.0/ && \
  cpanm HTML::Template@2.95 -l $SOFT/meme/5.1.0/ && \
  cpanm JSON@2.90 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::SOAP@3.21 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::SOAP11 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::WSDL11@3.06 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::Transport::SOAPHTTP -l $SOFT/meme/5.1.0/ && \
  cpanm Log::Log4perl@1.49 -l $SOFT/meme/5.1.0/ && \
  cpanm Math::CDF@0.1 -l $SOFT/meme/5.1.0/ && \
  cpanm Test::Script -l $SOFT/meme/5.1.0/ && \
  cpanm Test::Simple@1.302085 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Simple@2.24 -l $SOFT/meme/5.1.0/ && \
  cpanm File::Which@1.21 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Parser@2.44 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Parser::Expat -l $SOFT/meme/5.1.0/ && \
  cpanm Date::Format@2.24 -l $SOFT/meme/5.1.0/ && \
  cpanm Date::Language@1.10 -l $SOFT/meme/5.1.0/ && \
  cpanm Date::Parse@2.30 -l $SOFT/meme/5.1.0/ && \
  cpanm Time::Zone@2.24 -l $SOFT/meme/5.1.0/ && \
  cpanm Devel::GlobalDestruction@0.14 -l $SOFT/meme/5.1.0/ && \
  cpanm URI@1.71 -l $SOFT/meme/5.1.0/ && \
  cpanm Net::HTTP@6.17 -l $SOFT/meme/5.1.0/ && \
  cpanm XML::Compile::SOAP@3.22 -l $SOFT/meme/5.1.0/ && \
  cd $SOUR && wget https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-5.10.0-linux_x86_64-portable.tar.bz2 && \
  tar -jxvf pypy-5.10.0-linux_x86_64-portable.tar.bz2 && \
  cp -a pypy-5.10.0-linux_x86_64-portable $SOFT/meme/5.1.0/ && \
  cd $SOUR && wget http://meme-suite.org/meme-software/5.1.0/meme-5.1.0.tar.gz && \
  tar -zxvf meme-5.1.0.tar.gz && cd meme-5.1.0 && \     
  cd $SOUR && cd meme-5.1.0 && \
  ./configure --prefix=${SOFT}/meme/5.1.0 --with-python=$SOFT/meme/5.1.0/pypy-5.10.0-linux_x86_64-portable/bin/pypy --with-url=http://meme-suite.org --enable-build-libxml2 --enable-build-libxslt && \
  make && make test ; \
  cd $SOUR/meme-5.1.0 && make install && \
  newmod.sh \
  -s meme \
  -p $MODF/bioinformatics/ \
  -v 5.1.0 \
  -d 5.1.0 && \
  echo "module load perl" >> $MODF/bioinformatics/meme/5.1.0 && \
  echo "prepend-path PERL5LIB $SOFT/meme/5.1.0/perl/lib/perl5" >> $MODF/bioinformatics/meme/5.1.0' && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v3.0.0-4
COPY Dockerfile /Dockerfiles/v3.0.0-4/

USER $NB_USER