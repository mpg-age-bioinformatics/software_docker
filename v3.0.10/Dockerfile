# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.9
LABEL maintainer "bioinformatics@age.mpg.de"
USER root

RUN cd $SOUR && \
    wget https://github.com/stevengj/nlopt/archive/v2.6.2.tar.gz && \
    mkdir -p $SOFT/nlopt/2.6.2/bin && \
    tar -xzvf v2.6.2.tar.gz && \
    cp -r nlopt-2.6.2/* $SOFT/nlopt/2.6.2/bin && \
    cd $SOFT/nlopt/2.6.2/bin && cmake -DCMAKE_INSTALL_PREFIX=$SOFT/nlopt/2.6.2/bin . && make && make install && \
    newmod.sh \
    -s nlopt \
    -p $MODF/bioinformatics/ \
    -v 2.6.2 \
    -d 2.6.2 && \
    echo "setenv NLOPT $SOFT/nlopt/2.6.2/bin" >> $MODF/bioinformatics/nlopt/2.6.2 && \
    echo "setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:$SOFT/nlopt/2.6.2/bin/lib" >> $MODF/bioinformatics/nlopt/2.6.2 && \
    rm -rf ${SOUR}/*

RUN cd $SOUR && \
    wget https://github.com/jszavits/NEAR/archive/refs/heads/master.zip && \
    mkdir -p $SOFT/near/1.0.0/bin && \
    unzip master.zip && \
    cp -r NEAR-master/* $SOFT/near/1.0.0/bin && \
    cd $SOFT/near/1.0.0/bin/source/ && \
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$SOFT/nlopt/2.6.2/bin/lib && \
    gfortran -c mt19937.f90 && \
    gfortran NEAR.f90 -I$SOFT/nlopt/2.6.2/bin/include -L$SOFT/nlopt/2.6.2/bin/lib -lnlopt -lm -o NEAR mt19937.o && \
    mv NEAR ../ && \
    newmod.sh \
    -s near \
    -p $MODF/bioinformatics/ \
    -v 1.0.0 \
    -d 1.0.0 && \
    echo "module load nlopt" >> $MODF/bioinformatics/near/1.0.0 && \
    rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.10
COPY Dockerfile /Dockerfiles/v3.0.10
USER $NB_USER
