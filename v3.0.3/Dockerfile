# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.
FROM mpgagebioinformatics/bioinformatics_software:v3.0.2
LABEL maintainer "bioinformatics@age.mpg.de"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################


# python 3.9.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load openblas/0.3.7 && \
    cd $SOUR && \
    wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz && \
    tar xzf Python-3.9.0.tgz && \
    cd Python-3.9.0 && \
    mkdir -p $SOFT/python/3.9.0/bin && \
    ./configure --prefix=$SOFT/python/3.9.0 --enable-loadable-sqlite-extensions --enable-shared -with-ensurepip=yes \
      CLFAGS="-I$SOFT/openblas/0.3.7/include" \
      LDFLAGS="-L$SOFT/openblas/0.3.7/lib" && \
    make && make install && \
    newmod.sh \
      -s python \
      -p $MODF/general/ \
      -v 3.9.0 && \
    echo "set home $::env(HOME)" >> $MODF/general/python/3.9.0 && \
    echo "set pythonuser \$home/.software_container/.python/3.9.0/bin" >> $MODF/general/python/3.9.0 && \
    echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/python/3.9.0 && \
    echo "prepend-path PATH \$home/.software_container/.python/3.9.0/bin" >> $MODF/general/python/3.9.0 && \
    echo "set jupyter_runtime_dir \$home/.software_container/.python/3.9.0/jupyter/run" >> $MODF/general/python/3.9.0 && \
    echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/python/3.9.0 && \
    echo "setenv JUPYTER_RUNTIME_DIR \$home/.software_container/.python/3.9.0/jupyter/run" >> $MODF/general/python/3.9.0 && \
    echo "set jupyter_data_dir \$home/.software_container/.python/3.9.0/jupyter/data" >> $MODF/general/python/3.9.0 && \
    echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/python/3.9.0 && \
    echo "setenv JUPYTER_DATA_DIR \$home/.software_container/.python/3.9.0/jupyter/data" >> $MODF/general/python/3.9.0 && \
    echo "setenv PYTHONHOME $SOFT/python/3.9.0/" >> $MODF/general/python/3.9.0 && \
    echo "setenv PYTHONPATH $SOFT/python/3.9.0/lib/python3.9" >> $MODF/general/python/3.9.0 && \
    echo "setenv PYTHONUSERBASE \$home/.software_container/.python/3.9.0/" >> $MODF/general/python/3.9.0 && \
    echo "exec /bin/mkdir -p \$home/.software_container/.python/3.9.0/pythonpath/site-packages" >> $MODF/general/python/3.9.0 && \
    echo "module load openblas/0.3.7" >> $MODF/general/python/3.9.0 && \
    echo "setenv CLFAGS -I$SOFT/openblas/0.3.7/include" >> $MODF/general/python/3.9.0 && \
    echo "setenv LDFLAGS -L$SOFT/openblas/0.3.7/lib" >> $MODF/general/python/3.9.0' && \
    rm -rf ${SOUR}/*

RUN wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1h.tar.gz && \
    tar -zxvf OpenSSL_1_1_1h.tar.gz && \
    cd openssl-OpenSSL_1_1_1h/ && \
    ./config && \
    make && \
    make install && \
    cd .. && \
    rm -rf openssl-OpenSSL_1_1_1h


RUN apt-get update && \
    apt-get install -yq --no-install-recommends \ 
    libssl-dev \
    libcurl4-openssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.3
COPY Dockerfile /Dockerfiles/v3.0.3
USER $NB_USER