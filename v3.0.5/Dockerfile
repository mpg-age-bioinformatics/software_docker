# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.4
LABEL maintainer "bioinformatics@age.mpg.de"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################


# adding GSEA to module
RUN wget https://launchpad.net/~ubuntu-security/+archive/ubuntu/ppa/+build/15108504/+files/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb && \
  sudo dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb 

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.5
COPY Dockerfile /Dockerfiles/v3.0.5
USER $NB_USER
