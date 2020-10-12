# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.3
LABEL maintainer "bioinformatics@age.mpg.de"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################


# adding GSEA to module
RUN wget https://data.broadinstitute.org/gsea-msigdb/gsea/software/desktop/4.1/GSEA_Linux_4.1.0.zip && \
  unzip GSEA_Linux_4.1.0.zip && \
  cd GSEA_Linux_4.1.0 && \
  mkdir -p $SOFT/gsea/4.1.0/bin && \
  cp -r * $SOFT/gsea/4.1.0/bin && \
  newmod.sh \
  -s gsea \
  -p $MODF/bioinformatics/ \
  -v 4.1.0 \
  -d 4.1.0 &&\
  echo "module load jdk" >> $MODF/bioinformatics/gsea/4.1.0 && \
  echo "setenv gsea_cli $SOFT/gsea/4.1.0/bin/gsea-cli.sh" >> $MODF/bioinformatics/gsea/4.1.0 && \
  rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.4
COPY Dockerfile /Dockerfiles/v3.0.4
USER $NB_USER
