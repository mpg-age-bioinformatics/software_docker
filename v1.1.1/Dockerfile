# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.1.0 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:9cbfe88f0c35b433569818a203d12eef74d5f145f9f2f8d552f3f6f13603f782


LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN apt-get install -y pkg-config libfreetype6-dev libpng-dev liblmdb-dev

# installing QUAST version 4.6.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load python/2.7.13 && \
  module load perl/5.24.1 && \
  mkdir -p $SOFT/quast/4.6.0/bin && \
  export PYTHONUSERBASE=$SOFT/quast/4.6.0/ && \
  pip install future --user && \
  pip install qutils --user && \
  pip install matplotlib --user && \
  cpanm Time::HiRes -l $SOFT/quast/4.6.0/ && \
  export PERL5LIB=$SOFT/quast/4.6.0/lib/perl5:$PERL5LIB && \
  cd $SOUR && \
  wget https://downloads.sourceforge.net/project/quast/quast-4.6.0.tar.gz && \
  tar -xzf quast-4.6.0.tar.gz && \
  cd quast-4.6.0 && \
  ./setup.py install --user && \
  cp -r * $SOFT/quast/4.6.0/bin/ && \
  newmod.sh \
  -s quast \
  -p $MODF/bioinformatics/ \
  -v 4.6.0 \
  -d 4.6.0 && \
  echo "module load perl/5.24.1 python/2.7.13" && \
  echo "setenv PYTHONUSERBASE $SOFT/quast/4.6.0/lib/python2.7" >> $MODF/bioinformatics/quast/4.6.0 && \
  echo "prepend-path PERL5LIB $SOFT/quast/4.6.0/lib/perl5" >> $MODF/bioinformatics/quast/4.6.0' 

  
# installing BLAST+ version 2.7.1
RUN mkdir -p $SOFT/blast/2.7.1 && \
  cd $SOUR && \
  wget -O d.tar.gz ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz && \
  mv d.tar.gz blast-2.7.1+-x64-linux.tar.gz && \
  tar -xzf blast-2.7.1+-x64-linux.tar.gz && \
  cd ncbi-blast-2.7.1+ && \
  cp -r * $SOFT/blast/2.7.1 && \
  chmod 775 $SOFT/blast/2.7.1/bin/* && \
  newmod.sh \
  -s blast \
  -p $MODF/bioinformatics/ \
  -v 2.7.1 \
  -d 2.7.1

# FIX R module file for debian
RUN sed -i 's/lib64/lib/g' /modules/modulefiles/general/rlang/3.3.2

# Installing primer3

RUN mkdir -p $SOFT/primer3/2.4.0/bin && \
  cd $SOUR && \ 
  wget -O primer3-2.4.0.tar.gz 'https://downloads.sourceforge.net/project/primer3/primer3/2.4.0/primer3-2.4.0.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fprimer3%2F&ts=1511256562&use_mirror=netix' && \ 
  tar -xzf primer3-2.4.0.tar.gz && \
  cd primer3-2.4.0/src && \
  make all && \
  cp -r * $SOFT/primer3/2.4.0/bin && \
  newmod.sh \
  -s primer3 \
  -p $MODF/bioinformatics/ \
  -v 2.4.0 \
  -d 2.4.0

#RUN mkdir -p teste3

#instaling trimmomatic 

RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \ 
  mkdir -p $SOFT/trimmomatic/0.36/bin && \
  module load java && \
  cd $SOUR && \
  wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip && \
  unzip Trimmomatic-0.36.zip && \
  cd Trimmomatic-0.36 && \
  cp -r * $SOFT/trimmomatic/0.36/bin && \
  chmod 775 $SOFT/trimmomatic/0.36/bin/*.jar && \
  newmod.sh \
  -s trimmomatic \
  -p $MODF/bioinformatics/ \
  -v 0.36 \
  -d 0.36 && \
  echo "module load java" >> $MODF/bioinformatics/trimmomatic/0.36 && \
  echo "setenv TRIMMOMATIC $SOFT/trimmomatic/0.36/bin/trimmomatic-0.36.jar" >> $MODF/bioinformatics/trimmomatic/0.36' 




##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.1.1
COPY Dockerfile /Dockerfiles/v1.1.1/Dockerfile
USER $NB_USER
