# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0s

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

# gsl
RUN cd $SOUR && wget ftp://ftp.gnu.org/gnu/gsl//gsl-2.7.1.tar.gz && \
  mkdir -p $SOFT/gsl/2.7.1 && \
  tar -zxvf gsl-2.7.1.tar.gz && \
  cd gsl-2.7.1 && \
  ./configure --prefix=$SOFT/gsl/2.7.1 && \
  make && \
  make install && \
  newmod.sh \
  -s gsl \
  -p $MODF/libs/ \
  -v 2.7.1 \
  -d 2.7.1 && \
  echo "prepend-path LIBRARY_PATH /modules/software/gsl/2.7.1/lib" >> $MODF/libs/gsl/2.7.1 && \
  rm -rf $SOUR/*

# bzip2
RUN cd $SOUR && wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz && \
    tar -xzf bzip2-1.0.8.tar.gz && \
    cd bzip2-1.0.8 && \
    mkdir -p $SOFT/bzip2/1.0.8 && \
    sed -i "18s/.*/CC\=gcc -fPIC/" Makefile && \
    make -f Makefile-libbz2_so COMPILE_FLAGS+=-fPIC && make clean && make COMPILE_FLAGS+=-fPIC && \
    make -n install PREFIX=$SOFT/bzip2/1.0.8 COMPILE_FLAGS+=-fPIC && make install PREFIX=$SOFT/bzip2/1.0.8 COMPILE_FLAGS+=-fPIC && \
    cp -v bzip2-shared $SOFT/bzip2/1.0.8/bin/bzip2 && \
    cp -av libbz2.so* $SOFT/bzip2/1.0.8/lib && \
    newmod.sh \
    -s bzip2 \
    -p $MODF/libs/ \
    -v 1.0.8 \
    -d 1.0.8 && \
    rm -rf $SOUR/*

# xz
RUN cd $SOUR && wget http://tukaani.org/xz/xz-5.2.5.tar.gz && \
    tar -xzf xz-5.2.5.tar.gz && \
    cd xz-5.2.5 && \
    mkdir -p $SOFT/xz/5.2.5 && \
    ./configure --prefix=$SOFT/xz/5.2.5 && make && make install && \
    newmod.sh \
    -s xz \
    -p $MODF/libs/ \
    -v 5.2.5 \
    -d 5.2.5 && \
    rm -rf $SOUR/*

# openblas
RUN cd $SOUR && wget https://github.com/xianyi/OpenBLAS/archive/v0.3.21.tar.gz && \
    mv v0.3.21.tar.gz openblas-0.3.21.tar.gz && \
    tar -xzf openblas-0.3.21.tar.gz && \
    cd OpenBLAS-0.3.21 && \
    mkdir -p $SOFT/openblas/0.3.21 && \
    make PREFIX=$SOFT/openblas/0.3.21 && \
    make install PREFIX=$SOFT/openblas/0.3.21 && \
    newmod.sh \
    -s openblas \
    -p $MODF/libs/ \
    -v 0.3.21 \
    -d 0.3.21 && \
    rm -rf $SOUR/*

# jdk
RUN cd $SOUR && \
    wget https://download.java.net/java/GA/jdk18.0.2/f6ad4b4450fd4d298113270ec84f30ee/9/GPL/openjdk-18.0.2_linux-x64_bin.tar.gz && \
    tar -xvzf openjdk-18.0.2_linux-x64_bin.tar.gz && \
    mkdir -p $SOFT/jdk/18.0.2/bin && \
    cd jdk-18.0.2 && \
    cp -r * $SOFT/jdk/18.0.2/ && \
    newmod.sh \
    -s jdk \
    -p $MODF/general/ \
    -v 18.0.2 \
    -d 18.0.2 && \
    echo "setenv JAVA_HOME $SOFT/jdk/18.0.2" >> $MODF/general/jdk/18.0.2 && \
    rm -rf $SOUR/*

# perl/cpanm
RUN mkdir -p $SOFT/perl/5.32.1/bin && \
    cd $SOFT/perl/5.32.1/bin && \
    curl -L https://cpanmin.us/ -o cpanm && \
    chmod +x cpanm && \
    newmod.sh -s perl -p $MODF/general -v 5.32.1 -d 5.32.1 && \
    echo 'set home $::env(HOME)' >> $MODF/general/perl/5.32.1 && \
    echo 'set perluser $home/.software_container/.perl/5.32.1' >> $MODF/general/perl/5.32.1 && \
    echo 'exec /bin/mkdir -p $perluser' >> $MODF/general/perl/5.32.1 && \
    echo 'prepend-path PERL5LIB $perluser/lib/perl5' >> $MODF/general/perl/5.32.1 && \
    echo 'setenv PERLUSER $perluser' >> $MODF/general/perl/5.32.1

# Install R-4.2.1
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load bzip2/1.0.8 && \
    module load xz/5.2.5 && \
    module load jdk/18.0.2 && \
    cd $SOUR && wget http://ftp5.gwdg.de/pub/misc/cran/src/base/R-4/R-4.2.1.tar.gz && \
    tar -xzf R-4.2.1.tar.gz && \
    cd R-4.2.1 && \
    mkdir -p $SOFT/rlang/4.2.1/bin && \
    ./configure --prefix=$SOFT/rlang/4.2.1 \
    CFLAGS="-I$SOFT/bzip2/1.0.8/include \
    -I$SOFT/xz/5.2.5/include \
    -I$SOFT/jdk/18.0.2/include" \
    LDFLAGS="-L$SOFT/bzip2/1.0.8/lib \
    -L$SOFT/xz/5.2.5/lib \
    -L$SOFT/jdk/18.0.2/lib" \
    --with-cairo=yes --with-libpng=yes \
    --with-readline --with-tcltk --enable-R-profiling \
    --enable-R-shlib=yes --enable-memory-profiling --with-blas --with-lapack && \
    make && make install && \
    newmod.sh \
    -s rlang \
    -p $MODF/general/ \
    -v 4.2.1 \
    -d 4.2.1 && \
    echo "set home $::env(HOME)" >> $MODF/general/rlang/4.2.1 && \
    echo "exec /bin/mkdir -p \$home/.software_container/.R/4.2.1/R_LIBS_USER/" >> $MODF/general/rlang/4.2.1 && \
    echo "setenv R_LIBS_USER \$home/.software_container/.R/4.2.1/R_LIBS_USER" >> $MODF/general/rlang/4.2.1 && \
    echo "prepend-path LD_LIBRARY_PATH $SOFT/rlang/4.2.1/lib/R/lib" >> $MODF/general/rlang/4.2.1 && \
    echo "prepend-path CPATH $SOFT/rlang/4.2.1/lib/R/include" >> $MODF/general/rlang/4.2.1 && \
    echo "prepend-path C_INCLUDE_PATH $SOFT/rlang/4.2.1/lib/R/include" >> $MODF/general/rlang/4.2.1 && \
    echo "prepend-path CPLUS_INCLUDE_PATH $SOFT/rlang/4.2.1/lib/R/include" >> $MODF/general/rlang/4.2.1 && \
    echo "prepend-path OBJC_INCLUDE_PATH $SOFT/rlang/4.2.1/lib/R/include" >> $MODF/general/rlang/4.2.1 && \
    echo "module load jdk/18.0.2" >> $MODF/general/rlang/4.2.1 && \
    echo "setenv CFLAGS \"-I$SOFT/jdk/18.0.2/include -I$SOFT/bzip2/1.0.8/include -I$SOFT/xz/5.2.5/include\"" >> $MODF/general/rlang/4.2.1 && \
    echo "setenv LDFLAGS \"-L$SOFT/jdk/18.0.2/lib -L$SOFT/bzip2/1.0.8/lib -L$SOFT/xz/5.2.5/lib\"" >> $MODF/general/rlang/4.2.1' && \
    rm -rf ${SOUR}/*

# python 3.9.13
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load openblas/0.3.21 && \
    cd $SOUR && \
    curl -O https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tgz && \
    tar xzf Python-3.9.13.tgz && \
    cd Python-3.9.13 && \
    mkdir -p $SOFT/python/3.9.13/bin && \
    ./configure --prefix=$SOFT/python/3.9.13 --enable-loadable-sqlite-extensions --enable-shared -with-ensurepip=yes \
      CLFAGS="-I$SOFT/openblas/0.3.21/include" \
      LDFLAGS="-L$SOFT/openblas/0.3.21/lib" && \
    make && make install && \
    newmod.sh \
      -s python \
      -p $MODF/general/ \
      -v 3.9.13 && \
    echo "set home $::env(HOME)" >> $MODF/general/python/3.9.13 && \
    echo "set pythonuser \$home/.software_container/.python/3.9.13/bin" >> $MODF/general/python/3.9.13 && \
    echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/python/3.9.13 && \
    echo "prepend-path PATH \$home/.software_container/.python/3.9.13/bin" >> $MODF/general/python/3.9.13 && \
    echo "set jupyter_runtime_dir \$home/.software_container/.python/3.9.13/jupyter/run" >> $MODF/general/python/3.9.13 && \
    echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/python/3.9.13 && \
    echo "setenv JUPYTER_RUNTIME_DIR \$home/.software_container/.python/3.9.13/jupyter/run" >> $MODF/general/python/3.9.13 && \
    echo "set jupyter_data_dir \$home/.software_container/.python/3.9.13/jupyter/data" >> $MODF/general/python/3.9.13 && \
    echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/python/3.9.13 && \
    echo "setenv JUPYTER_DATA_DIR \$home/.software_container/.python/3.9.13/jupyter/data" >> $MODF/general/python/3.9.13 && \
    echo "setenv PYTHONHOME $SOFT/python/3.9.13/" >> $MODF/general/python/3.9.13 && \
    echo "setenv PYTHONPATH $SOFT/python/3.9.13/lib/python3.9" >> $MODF/general/python/3.9.13 && \
    echo "setenv PYTHONUSERBASE \$home/.software_container/.python/3.9.13/" >> $MODF/general/python/3.9.13 && \
    echo "exec /bin/mkdir -p \$home/.software_container/.python/3.9.13/pythonpath/site-packages" >> $MODF/general/python/3.9.13 && \
    echo "module load openblas/0.3.21" >> $MODF/general/python/3.9.13 && \
    echo "setenv CLFAGS -I$SOFT/openblas/0.3.21/include" >> $MODF/general/python/3.9.13 && \
    echo "setenv LDFLAGS -L$SOFT/openblas/0.3.21/lib" >> $MODF/general/python/3.9.13' && \
    rm -rf ${SOUR}/*

# jupyterhub v2.3.1
RUN cd $SOUR && \
    curl -O https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tgz && \
    tar xzf Python-3.9.13.tgz && \
    /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load openblas/0.3.21 && \
    cd $SOUR/Python-3.9.13 && \
    ./configure --prefix=$SOFT/jupyterhub/2.3.1 --enable-loadable-sqlite-extensions --enable-shared -with-ensurepip=yes \
    CLFAGS="-I$SOFT/openblas/0.3.21/include" \
    LDFLAGS="-L$SOFT/openblas/0.3.21/lib" && \
    make && make install && \
    newmod.sh \
    -s jupyterhub \
    -p $MODF/general/ \
    -v 2.3.1 \
    -d 2.3.1 && \
    echo "set home $::env(HOME)" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "set pythonuser \$home/.software_container/.jupyterhub/2.3.1/bin" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "prepend-path PATH \$home/.software_container/.jupyterhub/2.3.1/bin" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "set jupyter_runtime_dir \$home/.software_container/.jupyterhub/2.3.1/jupyter/run" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "setenv JUPYTER_RUNTIME_DIR \$home/.software_container/.jupyterhub/2.3.1/jupyter/run" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "set jupyter_data_dir \$home/.software_container/.jupyterhub/2.3.1/jupyter/data" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "setenv JUPYTER_DATA_DIR \$home/.software_container/.jupyterhub/2.3.1/jupyter/data" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "setenv PYTHONHOME $SOFT/jupyterhub/2.3.1/" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "setenv PYTHONUSERBASE \$home/.software_container/.jupyterhub/2.3.1/" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "exec /bin/mkdir -p \$home/.software_container/.jupyterhub/2.3.1/pythonpath/site-packages" >> $MODF/general/jupyterhub/2.3.1 && \
    echo "module load openblas/0.3.21 rlang/4.2.1" >> $MODF/general/jupyterhub/2.3.1 && \
    module load jupyterhub/2.3.1 && \
    pip3 install jupyter' && \
    rm -rf ${SOUR}/*

## Libraries required for jupyter R kernel
RUN echo "install.packages('askpass', repos='http://cran.us.r-project.org')" > $SOUR/askpass.install.R && \
    echo "install.packages('raster', repos='http://r-forge.r-project.org', type='source')" > $SOUR/raster.install.R && \
    echo "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'), lib=c('$SOFT/rlang/4.2.1/lib/R/library')  ,repos=c('http://ftp5.gwdg.de/pub/misc/cran/'), dependencies=TRUE )" > $SOUR/jupyter.install.R && \
    echo "devtools::install_github('IRkernel/IRkernel',lib=c('$SOFT/rlang/4.2.1/lib/R/library')) " >> $SOUR/_jupyter.install.R && \
    echo "IRkernel::installspec(name = 'ir421', displayname = 'R 4.2.1')" > $SOUR/.install.jupyter.R.kernel.4.2.1

RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load jupyterhub && \
    module load rlang && \
    cd $SOUR && \
    $SOFT/rlang/4.2.1/bin/Rscript $SOUR/askpass.install.R && \
    wget -O openssl_2.0.1.tar.gz https://github.com/jeroen/openssl/archive/refs/tags/v2.0.1.tar.gz && \
    $SOFT/rlang/4.2.1/bin/R CMD INSTALL -l $SOFT/rlang/4.2.1/lib/R/library openssl_2.0.1.tar.gz && \
    git clone https://github.com/ropensci/git2r.git && \
    $SOFT/rlang/4.2.1/bin/R CMD INSTALL -l $SOFT/rlang/4.2.1/lib/R/library git2r && \
    $SOFT/rlang/4.2.1/bin/Rscript $SOUR/jupyter.install.R && \
    $SOFT/rlang/4.2.1/bin/Rscript $SOUR/_jupyter.install.R && \
    Rscript $SOUR/.install.jupyter.R.kernel.4.2.1 && rm $SOUR/jupyter.install.R $SOUR/_jupyter.install.R $SOUR/.install.jupyter.R.kernel.4.2.1' && \
    rm -rf ${SOUR}/*
## Finished installation of jupyter R kernel

RUN apt-get update && \
apt-get install -yq --no-install-recommends \
   gdebi-core \
   python3-apt \
   python3-debian \
   distro-info-data \
   libapt-pkg6.0 \
   python-apt-common \
   python3 && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

## Install rstudio server ##
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load python/3.9.13 && \
    module load rlang && \
    cd ${SOUR} && \
    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.07.1-554-amd64.deb && \
    dpkg -i rstudio-server-2022.07.1-554-amd64.deb && \
    echo "rsession-which-r=$(which R)" >> /etc/rstudio/rserver.conf' && \  
    rm -rf ${SOUR}/*



##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v4.0.0b
COPY Dockerfile /Dockerfiles/v4.0.0b/

USER $NB_USER