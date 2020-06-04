# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.1
LABEL maintainer "bioinformatics@age.mpg.de"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################
RUN apt-get update && \ 
  apt-get install -yq libjpeg-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.2
COPY Dockerfile /Dockerfiles/v3.0.2
USER $NB_USER
