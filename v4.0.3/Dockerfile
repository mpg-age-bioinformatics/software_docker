# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.2
LABEL maintainer "bioinformatics@age.mpg.de"
USER root

#########################################
#### Bioinformatics tools start here ####
#########################################


##########################
#### this part to end ####
##########################

# Set bashrc
COPY bash.bashrc /etc/bash.bashrc

RUN mkdir -p /Dockerfiles/v4.0.3
COPY Dockerfile /Dockerfiles/v4.0.3

USER $NB_USER
