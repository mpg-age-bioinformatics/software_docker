# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0
LABEL maintainer "bioinformatics@age.mpg.de(opens in new tab)"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################
RUN apt-get update && \ 
  apt-get install -yq \
  libssl-dev \
  libcurl4-openssl-dev \
  libgeos-c1v5 \
  libgeos-dev \
  libudunits2-dev \
  libudunits2-0 \
  libpng16-16 \
  libpng-dev \
  acl \
  libxml-libxml-perl \
  libjpeg-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# adding GSEA to module
RUN wget https://data.broadinstitute.org/gsea-msigdb/gsea/software/desktop/4.3/GSEA_Linux_4.3.2.zip && \
  unzip GSEA_Linux_4.3.2.zip && \
  cd GSEA_Linux_4.3.2 && \
  mkdir -p $SOFT/gsea/4.3.2/bin && \
  cp -r * $SOFT/gsea/4.3.2/bin && \
  newmod.sh \
  -s gsea \
  -p $MODF/bioinformatics/ \
  -v 4.3.2 \
  -d 4.3.2 &&\
  echo "module load jdk" >> $MODF/bioinformatics/gsea/4.3.2 && \
  echo "setenv gsea_cli $SOFT/gsea/4.3.2/bin/gsea-cli.sh" >> $MODF/bioinformatics/gsea/4.3.2 && \
  rm -rf ${SOUR}/*

RUN cd $SOUR && \
    wget https://github.com/stevengj/nlopt/archive/v2.7.1.tar.gz && \
    mkdir -p $SOFT/nlopt/2.7.1/bin && \
    tar -xzvf v2.7.1.tar.gz && \
    cp -r nlopt-2.7.1/* $SOFT/nlopt/2.7.1/bin && \
    cd $SOFT/nlopt/2.7.1/bin && cmake -DCMAKE_INSTALL_PREFIX=$SOFT/nlopt/2.7.1/bin . && make && make install && \
    newmod.sh \
    -s nlopt \
    -p $MODF/bioinformatics/ \
    -v 2.7.1 \
    -d 2.7.1 && \
    echo "setenv NLOPT $SOFT/nlopt/2.7.1/bin" >> $MODF/bioinformatics/nlopt/2.7.1 && \
    echo "setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:$SOFT/nlopt/2.7.1/bin/lib" >> $MODF/bioinformatics/nlopt/2.7.1 && \
    rm -rf ${SOUR}/*

RUN cd $SOUR && \
    wget https://github.com/jszavits/NEAR/archive/refs/heads/master.zip && \
    mkdir -p $SOFT/near/1.0.0/bin && \
    unzip master.zip && \
    cp -r NEAR-master/* $SOFT/near/1.0.0/bin && \
    cd $SOFT/near/1.0.0/bin/source/ && \
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$SOFT/nlopt/2.7.1/bin/lib && \
    gfortran -c mt19937.f90 && \
    gfortran NEAR.f90 -I$SOFT/nlopt/2.7.1/bin/include -L$SOFT/nlopt/2.7.1/bin/lib -lnlopt -lm -o NEAR mt19937.o && \
    mv NEAR ../ && \
    newmod.sh \
    -s near \
    -p $MODF/bioinformatics/ \
    -v 1.0.0 \
    -d 1.0.0 && \
    echo "module load nlopt" >> $MODF/bioinformatics/near/1.0.0 && \
    rm -rf ${SOUR}/*

# installing TrimGalore
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load python/3.9.13 && \
  module load fastqc && \
  mkdir -p $SOFT/trimgalore/0.6.7/bin && \
  export PYTHONUSERBASE=$SOFT/trimgalore/0.6.7/ && \
  pip3 install cutadapt --user && \
  cd $SOUR && \
  curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.7.tar.gz -o trim_galore.tar.gz && \
  tar -xzf trim_galore.tar.gz && \
  cd TrimGalore-0.6.7/ && \
  cp -r * $SOFT/trimgalore/0.6.7/bin/ && \
  newmod.sh \
  -s trimgalore \
  -p $MODF/bioinformatics/ \
  -v 0.6.7 \
  -d 0.6.7 && \
  echo "module load fastqc python/3.9.13" && \
  echo "setenv PYTHONUSERBASE $SOFT/trimgalore/0.6.7/lib/python3.9" >> $MODF/bioinformatics/trimgalore/0.6.7 && \
  echo "module load fastqc python/3.9.13" >> $MODF/bioinformatics/trimgalore/0.6.7' && \
  rm -rf ${SOUR}/*

# Installing Bismark
RUN mkdir -p $SOFT/bismark/0.24.0/bin && \
  cd $SOUR && \
  wget https://github.com/FelixKrueger/Bismark/archive/refs/tags/0.24.0.tar.gz && \
  tar -xzf 0.24.0.tar.gz && \
  cd Bismark-0.24.0/ && \
  cp -r * $SOFT/bismark/0.24.0/bin/ && \
  newmod.sh \
  -s bismark \
  -p $MODF/bioinformatics/ \
  -v 0.24.0 \
  -d 0.24.0 && \
  echo "module load bowtie" >> $MODF/bioinformatics/bismark/0.24.0 && \
  echo "module load hisat" >> $MODF/bioinformatics/bismark/0.24.0 && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v4.0.1
COPY Dockerfile /Dockerfiles/v4.0.1
USER $NB_USER
