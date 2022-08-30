# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0-1

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

# Installing QUAST
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load python/3.9.13 && \
  module load perl && \
  mkdir -p $SOFT/quast/5.2.0/bin && \
  export PYTHONUSERBASE=$SOFT/quast/5.2.0/ && \
  pip3 install future --user && \
  pip3 install qutils --user && \
  pip3 install matplotlib --user && \
  cpanm Time::HiRes -l $SOFT/quast/5.2.0/ && \
  export PERL5LIB=$SOFT/quast/5.2.0/lib/perl5:$PERL5LIB && \
  cd $SOUR && \
  wget https://downloads.sourceforge.net/project/quast/quast-5.2.0.tar.gz && \
  tar -xzf quast-5.2.0.tar.gz && \
  cd quast-5.2.0 && \
  python3 setup.py install --user && \
  cp -r * $SOFT/quast/5.2.0/bin/ && \
  newmod.sh \
  -s quast \
  -p $MODF/bioinformatics/ \
  -v 5.2.0 \
  -d 5.2.0 && \
  echo "module load perl python/3.9.13" && \
  echo "setenv PYTHONUSERBASE $SOFT/quast/5.2.0/lib/python3.8" >> $MODF/bioinformatics/quast/5.2.0 && \
  echo "prepend-path PERL5LIB $SOFT/quast/5.2.0/lib/perl5" >> $MODF/bioinformatics/quast/5.2.0 && \
  echo "module load perl python" >> $MODF/bioinformatics/quast/5.2.0' && \
  rm -rf ${SOUR}/*

# Installing BLAST+
RUN mkdir -p $SOFT/blast/2.13.0 && \
  cd $SOUR && \
  wget -O d.tar.gz ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.13.0+-x64-linux.tar.gz && \
  mv d.tar.gz ncbi-blast-2.13.0+-x64-linux.tar.gz && \
  tar -xzf ncbi-blast-2.13.0+-x64-linux.tar.gz && \
  cd ncbi-blast-2.13.0+ && \
  cp -r * $SOFT/blast/2.13.0 && \
  chmod 775 $SOFT/blast/2.13.0/bin/* && \
  newmod.sh \
  -s blast \
  -p $MODF/bioinformatics/ \
  -v 2.13.0 \
  -d 2.13.0 && \
  rm -rf ${SOUR}/*

# Installing primer3 
RUN mkdir -p $SOFT/primer3/2.6.1/bin && \
  cd $SOUR && \
  wget https://github.com/primer3-org/primer3/archive/v2.6.1.tar.gz && \
  tar -xzf v2.6.1.tar.gz && \
  cd primer3-2.6.1/src && \
  make all && \
  cp -r * $SOFT/primer3/2.6.1/bin && \
  newmod.sh \
  -s primer3 \
  -p $MODF/bioinformatics/ \
  -v 2.6.1 \
  -d 2.6.1 && \
  rm -rf ${SOUR}/*

# Installing trimmomatic
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  mkdir -p $SOFT/trimmomatic/0.39/bin && \
  module load jdk && \
  cd $SOUR && \ 
  wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip && \
  unzip Trimmomatic-0.39.zip && \
  cd Trimmomatic-0.39 && \
  cp -r * $SOFT/trimmomatic/0.39/bin && \
  chmod 775 $SOFT/trimmomatic/0.39/bin/*.jar && \
  newmod.sh \
  -s trimmomatic \
  -p $MODF/bioinformatics/ \
  -v 0.39 \
  -d 0.39 && \
  echo "module load jdk" >> $MODF/bioinformatics/trimmomatic/0.39 && \
  echo "setenv TRIMMOMATIC $SOFT/trimmomatic/0.39/bin/trimmomatic-0.39.jar" >> $MODF/bioinformatics/trimmomatic/0.39' && \
  rm -rf ${SOUR}/*

# methpipe
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load gsl && \
  cd $SOUR && wget http://smithlabresearch.org/downloads/methpipe-5.0.0.tar.gz && \
  wget https://github.com/samtools/htslib/releases/download/1.16/htslib-1.16.tar.bz2 && \
  mkdir -p $SOFT/methpipe/5.0.0 && \
  tar -zxvf methpipe-5.0.0.tar.gz && \
  tar -jxvf htslib-1.16.tar.bz2 && \
  cd htslib-1.16 && \
  ./configure --prefix=$SOFT/methpipe/5.0.0 && make && make install && \
  cd $SOUR/methpipe-5.0.0 && \
  mkdir build && cd build && \
  ../configure --prefix=$SOFT/methpipe/5.0.0 CPPFLAGS='-I /modules/software/methpipe/5.0.0/include' LDFLAGS='-L/modules/software/methpipe/5.0.0/lib' && \
  make && \
  make install && \
  cp -r ../*  $SOFT/methpipe/5.0.0/ && \
  newmod.sh \
  -s methpipe \
  -p $MODF/bioinformatics/ \
  -v 5.0.0 \
  -d 5.0.0 && \
  echo "module load gsl" >> $MODF/bioinformatics/methpipe/5.0.0' && \
  rm -rf ${SOUR}/*

# abismal
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  cd $SOUR && wget https://github.com/smithlabcode/abismal/releases/download/v3.0.0/abismal-3.0.0.tar.gz && \
  tar -zxvf abismal-3.0.0.tar.gz && \
  mkdir -p $SOFT/abismal/3.0.0 && \
  cd abismal-3.0.0 && \
  ./configure --prefix=$SOFT/abismal/3.0.0 && \
  make all && \
  make install && \
  newmod.sh \
  -s abismal \
  -p $MODF/bioinformatics/ \
  -v 3.0.0 \
  -d 3.0.0 && \
  rm -rf ${SOUR}/*

# walt
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load gsl && \
  cd $SOUR && wget https://github.com/smithlabcode/walt/archive/v1.01.tar.gz && \
  tar -zxvf v1.01.tar.gz && \
  mkdir -p $SOFT/walt/1.1.0 && \
  cd walt-1.01 && \
  make all && \
  make install && \
  cp -r * $SOFT/walt/1.1.0/ && \
  newmod.sh \
  -s walt \
  -p $MODF/bioinformatics/ \
  -v 1.1.0 \
  -d 1.1.0 && \
  echo "module load gsl" >> $MODF/bioinformatics/walt/1.1.0' && \
  rm -rf ${SOUR}/*

# bwtool
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
  -d face601 && \
  cd $SOUR && tar -zcvf bwtool-face601.tar.gz bwtool-face601 && \
  rm -rf ${SOUR}/*

# flexbar
RUN cd $SOUR && \
  wget https://github.com/seqan/seqan/releases/download/seqan-v2.4.0/seqan-library-2.4.0.tar.xz && \
  wget https://github.com/seqan/flexbar/archive/v3.5.0.tar.gz && \
  mv v3.5.0.tar.gz flexbar-v3.5.0.tar.gz && \
  tar -xvf seqan-library-2.4.0.tar.xz && \
  tar -zxvf flexbar-v3.5.0.tar.gz && \
  cp -r seqan-library-2.4.0/include flexbar-3.5.0/ && \
  cd flexbar-3.5.0 && \
  cmake . && make && \
  mkdir -p $SOFT/flexbar/3.5.0/bin && \
  cp -r * $SOFT/flexbar/3.5.0 && \
  cp flexbar $SOFT/flexbar/3.5.0/bin && \
  newmod.sh \
  -s flexbar \
  -p $MODF/bioinformatics/ \
  -v 3.5.0 \
  -d 3.5.0 && \
  rm -rf ${SOUR}/*

# igrec v2.0.0
RUN cd $SOUR && \
    wget https://github.com/ablab/y-tools/releases/download/3.1.1/igrec-3.1.1-Linux.deb && \
    mkdir igrec-3.1.1-Linux && \
    dpkg-deb -x igrec-3.1.1-Linux.deb igrec-3.1.1-Linux && \
    mkdir -p $SOFT/igrec/3.1.1 && \
    cp -r igrec-3.1.1-Linux/usr/local/* $SOFT/igrec/3.1.1 && \
    newmod.sh \
    -s igrec \
    -p $MODF/bioinformatics/ \
    -v 3.1.1 \
    -d 3.1.1 && \
    rm -rf ${SOUR}/*

# igor v2.0.0
RUN cd $SOUR && \
    wget https://github.com/qmarcou/IGoR/releases/download/1.4.0/igor_1-4-0.zip && \
    unzip igor_1-4-0.zip && \
    mkdir -p $SOFT/igor/1.4.0/share/igor/ && \
    cd igor_1-4-0 && \
    ./configure --prefix=$SOFT/igor/1.4.0 && make && make install && \
    newmod.sh \
    -s igor \
    -p $MODF/bioinformatics/ \
    -v 1.4.0 \
    -d 1.4.0 && \
    rm -rf ${SOUR}/*

# mitools v2.0.0
RUN cd $SOUR && \
    wget https://github.com/milaboratory/mitools/releases/download/v1.5/mitools-1.5.zip && \
    unzip mitools-1.5.zip && \
    mkdir -p $SOFT/mitools/1.5.0/bin && \
    cp -r mitools-1.5/* $SOFT/mitools/1.5.0/bin && \
    newmod.sh \
    -s mitools \
    -p $MODF/bioinformatics/ \
    -v 1.5.0 \
    -d 1.5.0 && \
    echo "module load jdk" >> $MODF/bioinformatics/mitools/1.5.0 && \
    echo "setenv MITOOLS $SOFT/mitools/1.5.0/bin/mitools.jar" >> $MODF/bioinformatics/mitools/1.5.0 && \
    rm -rf ${SOUR}/*

# vdjtools v2.0.0
RUN cd $SOUR && \
    wget https://github.com/mikessh/vdjtools/releases/download/1.2.1/vdjtools-1.2.1.zip && \
    unzip vdjtools-1.2.1.zip && \
    mkdir -p $SOFT/vdjtools/1.2.1/bin && \
    cp -r vdjtools-1.2.1/* $SOFT/vdjtools/1.2.1/bin && \
    newmod.sh \
    -s vdjtools \
    -p $MODF/bioinformatics/ \
    -v 1.2.1 \
    -d 1.2.1 && \
    echo "module load jre" >> $MODF/bioinformatics/vdjtools/1.2.1 && \
    echo "setenv VDJTOOLS $SOFT/vdjtools/1.2.1/bin/vdjtools-1.2.1.jar" >> $MODF/bioinformatics/vdjtools/1.2.1 && \
    rm -rf ${SOUR}/*

# subread
RUN cd $SOUR && \
    wget https://downloads.sourceforge.net/project/subread/subread-2.0.3/subread-2.0.3-Linux-x86_64.tar.gz && \
    tar -zxvf subread-2.0.3-Linux-x86_64.tar.gz && \
    cd subread-2.0.3-Linux-x86_64 && \
    mkdir -p $SOFT/subread/2.0.3/bin && \
    cp -r bin/utilities/* $SOFT/subread/2.0.3/bin && \
    cp -r * $SOFT/subread/2.0.3 && \
    newmod.sh \
    -s subread \
    -p $MODF/bioinformatics/ \
    -v 2.0.3 && \
    rm -rf ${SOUR}/*

# Installing samtools version 1.15.1 needed for epiTEome v2.0.0
RUN cd $SOUR && \
    wget http://sourceforge.net/projects/samtools/files/samtools/1.15.1/samtools-1.15.1.tar.bz2/download && \
    mv download samtools-1.15.1.tar.bz2 && \
    tar -jxvf samtools-1.15.1.tar.bz2 && \
    cd samtools-1.15.1 && \
    sed -i 's/-g -Wall -O2/-g -Wall -O2 -fPIC/g' Makefile && \
    mkdir -p $SOFT/samtools/1.15.1/bin && \
    make && cp samtools bcftools/bcftools misc/*.pl misc/*.java misc/maq2sam-long misc/maq2sam-short misc/md5fa misc/md5sum-lite misc/*.py misc/wgsim $SOFT/samtools/1.15.1/bin && \
    newmod.sh \
    -s samtools \
    -p $MODF/bioinformatics/ \
    -v 1.15.1 && \
    rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v4.0.0-2
COPY Dockerfile /Dockerfiles/v4.0.0-2/

USER $NB_USER






