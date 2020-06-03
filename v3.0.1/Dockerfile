# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v3.0.0
LABEL maintainer "bioinformatics@age.mpg.de(opens in new tab)"
USER root
#########################################
#### Bioinformatics tools start here ####
#########################################
# Install R-3.6.3
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load bzip2/1.0.8 && \
    module load xz/5.2.4 && \
    module load jdk/13.0.1 && \
    cd $SOUR && wget http://ftp5.gwdg.de/pub/misc/cran/src/base/R-3/R-3.6.3.tar.gz && \
    tar -xzf R-3.6.3.tar.gz && \
    cd R-3.6.3 && \
    mkdir -p $SOFT/rlang/3.6.3/bin && \
    ./configure --prefix=$SOFT/rlang/3.6.3 \
    CFLAGS="-I$SOFT/bzip2/1.0.8/include \
    -I$SOFT/xz/5.2.4/include \
    -I$SOFT/jdk/13.0.1/include" \
    LDFLAGS="-L$SOFT/bzip2/1.0.8/lib \
    -L$SOFT/xz/5.2.4/lib \
    -L$SOFT/jdk/13.0.1/lib" \
    --with-cairo=yes --with-libpng=yes \
    --with-readline --with-tcltk --enable-R-profiling \
    --enable-R-shlib=yes --enable-memory-profiling --with-blas --with-lapack && \
    make && make install && \
    newmod.sh \
    -s rlang \
    -p $MODF/general/ \
    -v 3.6.3 \
    -d 3.6.3 && \
    echo "set home $::env(HOME)" >> $MODF/general/rlang/3.6.3 && \
    echo "exec /bin/mkdir -p \$home/.software_container/.R/3.6.3/R_LIBS_USER/" >> $MODF/general/rlang/3.6.3 && \
    echo "setenv R_LIBS_USER \$home/.software_container/.R/3.6.3/R_LIBS_USER" >> $MODF/general/rlang/3.6.3 && \
    echo "prepend-path LD_LIBRARY_PATH $SOFT/rlang/3.6.3/lib/R/lib" >> $MODF/general/rlang/3.6.3 && \
    echo "prepend-path CPATH $SOFT/rlang/3.6.3/lib/R/include" >> $MODF/general/rlang/3.6.3 && \
    echo "prepend-path C_INCLUDE_PATH $SOFT/rlang/3.6.3/lib/R/include" >> $MODF/general/rlang/3.6.3 && \
    echo "prepend-path CPLUS_INCLUDE_PATH $SOFT/rlang/3.6.3/lib/R/include" >> $MODF/general/rlang/3.6.3 && \
    echo "prepend-path OBJC_INCLUDE_PATH $SOFT/rlang/3.6.3/lib/R/include" >> $MODF/general/rlang/3.6.3 && \
    echo "module load jdk/13.0.1" >> $MODF/general/rlang/3.6.3 && \
    echo "setenv CFLAGS \"-I$SOFT/jdk/13.0.1/include -I$SOFT/bzip2/1.0.8/include -I$SOFT/xz/5.2.4/include\"" >> $MODF/general/rlang/3.6.3 && \
    echo "setenv LDFLAGS \"-L$SOFT/jdk/13.0.1/lib -L$SOFT/bzip2/1.0.8/lib -L$SOFT/xz/5.2.4/lib\"" >> $MODF/general/rlang/3.6.3' && \
    rm -rf ${SOUR}/*
##########################
#### this part to end ####
##########################
RUN mkdir -p /Dockerfiles/v3.0.1
COPY Dockerfile /Dockerfiles/v3.0.1
USER $NB_USER
