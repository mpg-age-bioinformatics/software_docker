# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.7
LABEL maintainer "bioinformatics@age.mpg.de"
USER root

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \ 
    acl   && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.8
COPY Dockerfile /Dockerfiles/v3.0.8
USER $NB_USER