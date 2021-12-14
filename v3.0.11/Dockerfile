# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.10
LABEL maintainer "bioinformatics@age.mpg.de"
USER root

# installing TrimGalore
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load python/3.9.0 && \
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
  echo "module load fastqc python/3.9.0" && \
  echo "setenv PYTHONUSERBASE $SOFT/trimgalore/0.6.7/lib/python3.9" >> $MODF/bioinformatics/trimgalore/0.6.7 && \
  echo "module load fastqc python/3.9.0" >> $MODF/bioinformatics/trimgalore/0.6.7' && \
  rm -rf ${SOUR}/*

# Installing Bismark
RUN mkdir -p $SOFT/bismark/0.23.0/bin && \
  cd $SOUR && \
  wget https://github.com/FelixKrueger/Bismark/archive/refs/tags/0.23.0.tar.gz && \
  tar -xzf 0.23.0.tar.gz && \
  cd Bismark-0.23.0/ && \
  cp -r * $SOFT/bismark/0.23.0/bin/ && \
  newmod.sh \
  -s bismark \
  -p $MODF/bioinformatics/ \
  -v 0.23.0 \
  -d 0.23.0 && \
  echo "module load bowtie" >> $MODF/bioinformatics/bismark/0.23.0 && \
  echo "module load hisat" >> $MODF/bioinformatics/bismark/0.23.0 && \
  rm -rf ${SOUR}/*



##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.11
COPY Dockerfile /Dockerfiles/v3.0.11
USER $NB_USER
