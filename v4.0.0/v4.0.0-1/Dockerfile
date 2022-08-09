# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0b

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

# bowtie2
RUN cd $SOUR && \
  wget https://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.4.5/bowtie2-2.4.5-linux-x86_64.zip && \
  unzip bowtie2-2.4.5-linux-x86_64.zip && \
  mkdir -p $SOFT/bowtie/2.4.5/bin && \
  cp -r bowtie2-2.4.5-linux-x86_64/* $SOFT/bowtie/2.4.5/ && \
  mv $SOFT/bowtie/2.4.5/bowti* $SOFT/bowtie/2.4.5/bin/ && \
  newmod.sh \
  -s bowtie \
  -p $MODF/bioinformatics/ \
  -v 2.4.5 \
  -d 2.4.5 && \
  rm -rf ${SOUR}/*

# bowtie1
RUN cd $SOUR && \
  wget https://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.3.1/bowtie-1.3.1-linux-x86_64.zip && \
  unzip bowtie-1.3.1-linux-x86_64.zip && \
  mkdir -p $SOFT/bowtie/1.3.1/bin && \
  cd bowtie-1.3.1-linux-x86_64 && \
  cp bowt* $SOFT/bowtie/1.3.1/bin && \
  newmod.sh \
  -s bowtie \
  -p $MODF/bioinformatics/ \
  -v 1.3.1 && \
  rm -rf ${SOUR}/*

# cufflinks
RUN cd $SOUR && \
  wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz && \
  tar -zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz && \
  cd cufflinks-2.2.1.Linux_x86_64 && \
  mkdir -p $SOFT/cufflinks/2.2.1/bin && \
  cp cuff* g* $SOFT/cufflinks/2.2.1/bin && \
  newmod.sh \
  -s cufflinks \
  -p $MODF/bioinformatics/ \
  -v 2.2.1 \
  -d 2.2.1 && \
  rm -rf ${SOUR}/*

# fastqc
RUN cd $SOUR && \
  wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
  unzip fastqc_v0.11.9.zip && \
  cd FastQC && \
  mkdir -p $SOFT/fastqc/0.11.9/bin && \
  cp -r * $SOFT/fastqc/0.11.9/bin && \
  chmod 755 $SOFT/fastqc/0.11.9/bin/fastqc && \
  newmod.sh \
  -s fastqc \
  -p $MODF/bioinformatics/ \
  -v 0.11.9 \
  -d 0.11.9 && \
  echo "module load jdk" >> $MODF/bioinformatics/fastqc/0.11.9 && \
  rm -rf ${SOUR}/*

# samtools
RUN cd $SOUR && \
  wget https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2 && \
  tar -jxvf samtools-1.15.1.tar.bz2 && \
  cd samtools-1.15.1 && \
  mkdir -p $SOFT/samtools/1.15.1/bin && \
  ./configure --prefix=$SOFT/samtools/1.15.1 && \
  make && make install && \
  newmod.sh \
  -s samtools \
  -p $MODF/bioinformatics/ \
  -v 1.15.1 \
  -d 1.15.1  && \
  rm -rf ${SOUR}/*

# hisat2
RUN cd $SOUR && \ 
  wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip && \
  unzip hisat2-2.1.0-Linux_x86_64.zip && \
  cd hisat2-2.1.0 && \
  mkdir -p $SOFT/hisat/2.1.0/bin && \
  cp -r * $SOFT/hisat/2.1.0/bin && \
  newmod.sh \
  -s hisat \
  -p $MODF/bioinformatics/ \
  -v 2.1.0 \
  -d 2.1.0 && \
  rm -rf ${SOUR}/*

# stringtie
RUN cd $SOUR && \
  wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-2.2.1.Linux_x86_64.tar.gz && \
  tar -zxvf stringtie-2.2.1.Linux_x86_64.tar.gz && \
  cd stringtie-2.2.1.Linux_x86_64 && \
  mkdir -p $SOFT/stringtie/2.2.1/bin && \
  cp -r * $SOFT/stringtie/2.2.1/bin && \
  newmod.sh \
  -s stringtie \
  -p $MODF/bioinformatics/ \
  -v 2.2.1 \
  -d 2.2.1 && \
  rm -rf ${SOUR}/*

# bwa
RUN cd $SOUR && \
  wget https://github.com/lh3/bwa/archive/v0.7.17.tar.gz && \
  tar -zxvf v0.7.17.tar.gz && \
  cd bwa-0.7.17 && \
  make && \
  mkdir -p $SOFT/bwa/0.7.17/bin && \
  cp -r * $SOFT/bwa/0.7.17/bin && \
  newmod.sh \
  -s bwa \
  -p $MODF/bioinformatics/ \
  -v 0.7.17 \
  -d 0.7.17 && \
  rm -rf ${SOUR}/*

# tophat
RUN cd $SOUR && \ 
  wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz && \
  tar -zxvf tophat-2.1.1.Linux_x86_64.tar.gz && \
  cd tophat-2.1.1.Linux_x86_64 && \
  mkdir -p $SOFT/tophat/2.1.1/bin && \
  cp -r * $SOFT/tophat/2.1.1/bin && \
  newmod.sh \
  -s tophat \
  -p $MODF/bioinformatics/ \
  -v 2.1.1 \
  -d 2.1.1 && \
  rm -rf ${SOUR}/*

# star
RUN cd $SOUR && \
  wget https://github.com/alexdobin/STAR/archive/refs/tags/2.7.10a_alpha_220601.tar.gz && \
  tar -xzf 2.7.10a.tar.gz && \
  cd STAR-2.7.10a && \
  mkdir -p $SOFT/star/2.7.10a/bin && \
  cp -r bin/Linux_x86_64_static/* $SOFT/star/2.7.10a/bin && \
  newmod.sh \
  -s star \
  -p $MODF/bioinformatics/ \
  -v 2.7.10a && \
  rm -rf ${SOUR}/*

# skewer
RUN cd $SOUR && \
  wget http://downloads.sourceforge.net/project/skewer/Binaries/skewer-0.2.2-linux-x86_64 && \
  mkdir -p $SOFT/skewer/0.2.2/bin && \
  cp skewer-0.2.2-linux-x86_64 $SOFT/skewer/0.2.2/bin/skewer && \
  chmod 755 $SOFT/skewer/0.2.2/bin/skewer && \
  newmod.sh \
  -s skewer \
  -p $MODF/bioinformatics/ \
  -v 0.2.2 \
  -d 0.2.2 && \
  rm -rf ${SOUR}/*

# bedtools
RUN cd $SOUR && \ 
  wget https://github.com/arq5x/bedtools2/archive/v2.30.0.tar.gz && \
  tar -zxvf v2.30.0.tar.gz && \
  cd bedtools2-2.30.0 && \
  mkdir -p $SOFT/bedtools/2.30.0/ && \
  make && \
  cp -r bin $SOFT/bedtools/2.30.0 && \
  newmod.sh \
  -s bedtools \
  -p $MODF/bioinformatics/ \
  -v 2.30.0 \
  -d 2.30.0 && \
  rm -rf ${SOUR}/*

# vcftools
RUN cd $SOUR && \
  wget https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz && \
  tar -zxvf vcftools-0.1.16.tar.gz && \
  cd vcftools-0.1.16 && \
  mkdir -p $SOFT/vcftools/0.1.16 && \
  ./configure --prefix=$SOFT/vcftools/0.1.16 && make && make install && \
  newmod.sh \
  -s vcftools \
  -p $MODF/bioinformatics/ \
  -v 0.1.16 \
  -d 0.1.16 && \
  rm -rf ${SOUR}/*

# picard
RUN cd $SOUR && \
  wget https://github.com/broadinstitute/picard/releases/download/2.27.4/picard.jar && \
  mkdir -p $SOFT/picard/2.27.4/bin && \
  cp picard.jar $SOFT/picard/2.27.4/bin/picard.jar && \
  newmod.sh \
  -s picard \
  -p $MODF/bioinformatics/ \
  -v 2.27.4 \
  -d 2.27.4 && \
  echo "module load jdk" >> $MODF/bioinformatics/picard/2.27.4 && \
  echo "setenv PICARD $SOFT/picard/2.27.4/bin/picard.jar" >> $MODF/bioinformatics/picard/2.27.4 && \
  rm -rf ${SOUR}/*

# sratoolkit
RUN cd $SOUR && \
  wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.3/sratoolkit.2.11.3-ubuntu64.tar.gz && \
  tar -zxvf sratoolkit.2.11.3-ubuntu64.tar.gz && \
  mkdir -p $SOFT/sratoolkit/2.11.3/ && \
  cp -r sratoolkit.2.11.3-ubuntu64/*  $SOFT/sratoolkit/2.11.3/ && \
  newmod.sh \
  -s sratoolkit \
  -p $MODF/bioinformatics/ \
  -v 2.11.3 \
  -d 2.11.3 && \
  rm -rf ${SOUR}/*

# snpEff
RUN cd $SOUR && wget http://downloads.sourceforge.net/project/snpeff/snpEff_v4_3t_core.zip && \
  unzip snpEff_v4_3t_core.zip && \
  mv snpEff snpEff_v4_3t_core && \
  mkdir -p $SOFT/snpeff/4.3.t/bin && \
  cp -r snpEff_v4_3t_core/* $SOFT/snpeff/4.3.t/bin && \
  newmod.sh \
  -s snpeff \
  -p $MODF/bioinformatics/ \
  -v 4.3.t \
  -d 4.3.t && \
  echo "module load jdk" >> $MODF/bioinformatics/snpeff/4.3.t && \
  echo "setenv SNPEFF $SOFT/snpeff/4.3.t/bin/snpEff.jar" >> $MODF/bioinformatics/snpeff/4.3.t && \
  echo "setenv SNPSIFT $SOFT/snpeff/4.3.t/bin/SnpSift.jar" >> $MODF/bioinformatics/snpeff/4.3.t && \
  rm -rf ${SOUR}/*

# spades
RUN cd $SOUR && wget https://cab.spbu.ru/files/release3.15.4/SPAdes-3.15.4-Linux.tar.gz && \
  tar -zxvf SPAdes-3.15.4-Linux.tar.gz && \
  cd SPAdes-3.15.4-Linux && \
  mkdir -p $SOFT/spades/3.15.4 && \
  cp -r * $SOFT/spades/3.15.4/ && \
  newmod.sh \
  -s spades \
  -p $MODF/bioinformatics/ \
  -v 3.15.4 \
  -d 3.15.4 && \
  rm -rf ${SOUR}/*

# gatk
RUN mkdir -p $SOFT/gatk/4.2.6.1/bin && \
  cd $SOUR && \
  wget https://github.com/broadinstitute/gatk/releases/download/4.2.6.1/gatk-4.2.6.1.zip && \
  unzip gatk-4.2.6.1.zip && \
  cd gatk-4.2.6.1 && \
  cp -r * $SOFT/gatk/4.2.6.1/bin && \
  newmod.sh \
  -s gatk \
  -p $MODF/bioinformatics/ \
  -v 4.2.6.1 \
  -d 4.2.6.1 && \
  echo 'module load jdk' >> $MODF/bioinformatics/gatk/4.2.6.1 && \
  rm -rf ${SOUR}/*

# lofreq
RUN cd $SOUR && wget https://github.com/CSB5/lofreq/raw/master/dist/lofreq_star-2.1.5_linux-x86-64.tgz && \
  mkdir -p $SOFT/lofreq/2.1.5 && \
  tar xfvz lofreq_star-2.1.5_linux-x86-64.tgz && \
  mv lofreq_star-2.1.5/bin $SOFT/lofreq/2.1.5/ && \
  newmod.sh \
  -s lofreq \
  -p $MODF/bioinformatics/ \
  -v 2.1.5 \
  -d 2.1.5  && \
  rm -rf ${SOUR}/*

RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load jdk && \
  mkdir -p $SOFT/cytoscape/3.7.2 && \
  cd $SOFT/cytoscape/3.7.2 && wget  https://github.com/cytoscape/cytoscape/releases/download/3.7.2/Cytoscape_3_7_2_unix.sh && \
  bash Cytoscape_3_7_2_unix.sh -q && \
  newmod.sh \
  -s cytoscape \
  -p $MODF/bioinformatics/ \
  -v 3.7.2 \
  -d 3.7.2 && \
  echo "module load jdk" >> $MODF/bioinformatics/cytoscape/3.7.2  && \
  echo "prepend-path PATH /usr/local/Cytoscape_v3.7.2" >> $MODF/bioinformatics/cytoscape/3.7.2' && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v4.0.0-1
COPY Dockerfile /Dockerfiles/v4.0.0-1/

USER $NB_USER






