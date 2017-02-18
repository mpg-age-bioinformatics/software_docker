# Copyright (c) Jorge Boucas.
# Distributed under the terms of the Modified BSD License.

# Debian Jessie 8.7 image available as latest 2017 February 14.
FROM debian@sha256:abbe80c8c87b7e1f652fe5e99ff1799cdf9e0878c7009035afe1bccac129cad8

LABEL maintainer "bioinformatics@age.mpg.de

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ftp.debian.org/debian jessie main non-free contrib" >> /etc/apt/sources.list \
&& echo "deb-src http://ftp.debian.org/debian jessie main non-free contrib" >> /etc/apt/sources.list \
&& echo "deb http://ftp.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
&& echo "deb-src http://ftp.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list

RUN REPO=http://cdn-fastly.deb.debian.org \
&& echo "deb $REPO/debian jessie main\ndeb $REPO/debian-security jessie/updates main" > /etc/apt/sources.list \
&& apt-get update && apt-get -yq dist-upgrade \
&& apt-get install -yq --no-install-recommends \
   libreadline-dev \
   xorg-dev \
   apt-utils \
   wget \
   bzip2 \
   ca-certificates \
   sudo \
   locales \
   git \
   vim \
   jed \
   emacs \
   build-essential \
   python-dev \
   unzip \
   libsm6 \
   pandoc \
   texlive-latex-base \
   texlive-latex-extra \
   texlive-fonts-extra \
   texlive-fonts-recommended \
   texlive-generic-recommended \
   libxrender1 \
   inkscape \
   pkg-config \
   libxml2-dev \
   libcurl4-gnutls-dev \
   libatlas3-base \
   libopenblas-base \
   libfreetype6-dev \
   pigz \
   zlib1g-dev \
   autoconf \
   automake \
   libtool \
   libexpat1-dev \
   libxml2-dev \
   libxslt1-dev \
   ghostscript \
   environment-modules \
   gcc \
   f2c \
   gfortran \
   libpcre3 \
   libpcre3-dev \
   libssl-dev \
   libsqlite3-dev \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
   locale-gen

RUN apt-get update && apt-get install -y libcairo2-dev libtool-bin libzmq3-dev

ENV SHELL /bin/bash
ENV NB_USER mpiage
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER ; \
echo "root:bioinf" | chpasswd ; \
echo "mpiage:bioinf" | chpasswd ; \
adduser mpiage sudo

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV MODS /modules
ENV SOFT $MODS/software
ENV SOUR $MODS/sources
ENV MODF $MODS/modulefiles
ENV LOGS $MODS/installation_logs

RUN mkdir -p $SOFT $SOUR $MODF $LOGS $MODF/bioinformatics $MODF/general $MODF/libs

RUN wget https://raw.githubusercontent.com/mpg-age-bioinformatics/draco_pipelines/master/software/newmod.sh \
&& sed -i 's/u\/jboucas\/modules/modules/g' newmod.sh && chmod 777 newmod.sh && mv newmod.sh /usr/bin

ENV MODULEPATH $MODF/bioinformatics:$MODF/general:$MODF/libs

RUN cd $SOUR && wget -O jre-8.0.111-linux-x64.tar.gz http://javadl.oracle.com/webapps/download/AutoDL?BundleId=216424 \
&& tar -zxvf jre-8.0.111-linux-x64.tar.gz \
&& cd jre1.8.0_111 \
&& mkdir -p $SOFT/java/8.0.111 \
&& cp -r * $SOFT/java/8.0.111/ \
&& newmod.sh \
    -s java \
    -p $MODF/general/ \
    -v 8.0.111 \
    -d 8.0.111

RUN cd $SOUR && wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz \
&& tar -xzf bzip2-1.0.6.tar.gz \
&& cd bzip2-1.0.6 \
&& mkdir -p $SOFT/bzip2/1.0.6 \
&& sed -i "18s/.*/CC\=gcc -fPIC/" Makefile \
&& make -f Makefile-libbz2_so COMPILE_FLAGS+=-fPIC && make clean && make COMPILE_FLAGS+=-fPIC  \
&& make -n install PREFIX=$SOFT/bzip2/1.0.6 COMPILE_FLAGS+=-fPIC && make install PREFIX=$SOFT/bzip2/1.0.6 COMPILE_FLAGS+=-fPIC \
&& cp -v bzip2-shared $SOFT/bzip2/1.0.6/bin/bzip2 \
&& cp -av libbz2.so* $SOFT/bzip2/1.0.6/lib \
&& newmod.sh \
    -s bzip2 \
    -p $MODF/libs/ \
    -v 1.0.6 \
    -d 1.0.6

RUN cd $SOUR && wget http://tukaani.org/xz/xz-5.2.2.tar.gz \
&& tar -xzf xz-5.2.2.tar.gz \
&& cd xz-5.2.2 \
&& mkdir -p $SOFT/xz/5.2.2 \
&& ./configure --prefix=$SOFT/xz/5.2.2 && make && make install \
&& newmod.sh \
 -s xz \
 -p $MODF/libs/ \
 -v 5.2.2 \
 -d 5.2.2

RUN cd $SOUR && wget https://github.com/xianyi/OpenBLAS/archive/v0.2.19.tar.gz \
&& mv v0.2.19.tar.gz openblas-0.2.19.tar.gz \
&& tar -xzf openblas-0.2.19.tar.gz \
&& cd OpenBLAS-0.2.19 \
&& mkdir -p $SOFT/openblas/0.2.19 \
&& make PREFIX=$SOFT/openblas/0.2.19 \
&& make install PREFIX=$SOFT/openblas/0.2.19 \
&& newmod.sh \
 -s openblas \
 -p $MODF/libs/ \
 -v 0.2.19 \
 -d 0.2.19

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load bzip2/1.0.6 \
&& module load xz/5.2.2 \
&& module load openblas/0.2.19 \
&& cd $SOUR && wget http://ftp5.gwdg.de/pub/misc/cran/src/base/R-3/R-3.3.2.tar.gz \
&& tar -xzf R-3.3.2.tar.gz \
&& cd R-3.3.2 \
&& mkdir -p $SOFT/rlang/3.3.2/bin \
&& ./configure --prefix=$SOFT/rlang/3.3.2 \
 CFLAGS="-I$SOFT/bzip2/1.0.6/include \
 -I$SOFT/xz/5.2.2/include \
 -I$SOFT/openblas/0.2.19/include" \
 LDFLAGS="-L$SOFT/bzip2/1.0.6/lib \
 -L$SOFT/xz/5.2.2/lib \
 -L$SOFT/openblas/0.2.19/lib" \
 --with-x=no --with-cairo=yes --with-libpng=yes \
 --with-readline --with-tcltk --enable-BLAS-shlib --enable-R-profiling \
 --enable-R-shlib=yes --enable-memory-profiling --with-blas --with-lapack \
&& make && make install \
&& newmod.sh \
 -s rlang \
 -p $MODF/general/ \
 -v 3.3.2 \
 -d 3.3.2 \
&& echo "set home $::env(HOME)" >> $MODF/general/rlang/3.3.2 \
&& echo "exec /bin/mkdir -p \$home/.R/3.3.2/R_LIBS_USER/" >> $MODF/general/rlang/3.3.2 \
&& echo "setenv R_LIBS_USER \$home/.R/3.3.2/R_LIBS_USER" >> $MODF/general/rlang/3.3.2 \
&& echo "prepend-path LD_LIBRARY_PATH $SOFT/rlang/3.3.2/lib64/R/lib" >> $MODF/general/rlang/3.3.2 \
&& echo "prepend-path CPATH $SOFT/rlang/3.3.2/lib64/R/include" >> $MODF/general/rlang/3.3.2 \
&& echo "prepend-path C_INCLUDE_PATH $SOFT/rlang/3.3.2/lib64/R/include" >> $MODF/general/rlang/3.3.2 \
&& echo "prepend-path CPLUS_INCLUDE_PATH $SOFT/rlang/3.3.2/lib64/R/include" >> $MODF/general/rlang/3.3.2 \
&& echo "prepend-path OBJC_INCLUDE_PATH $SOFT/rlang/3.3.2/lib64/R/include" >> $MODF/general/rlang/3.3.2 \
&& echo "module load openblas/0.2.19" >> $MODF/general/rlang/3.3.2  \
&& echo "setenv CLFAGS \"-I$SOFT/bzip2/1.0.6/include -I$SOFT/xz/5.2.2/include -I$SOFT/openblas/0.2.19/include\"" >> $MODF/general/rlang/3.3.2  \
&& echo "setenv LDFLAGS \"-L$SOFT/bzip2/1.0.6/lib -L$SOFT/xz/5.2.2/lib -L$SOFT/openblas/0.2.19/lib\"" >> $MODF/general/rlang/3.3.2 \
&& mv $SOFT/rlang/3.3.2/lib/R/lib/libRblas.so $SOFT/rlang/3.3.2/lib/R/lib/old_libRblas.so \
&& ln -s $SOFT/openblas/0.2.19/lib/libopenblas.so $SOFT/rlang/3.3.2/lib/R/lib/libRblas.so'

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load openblas/0.2.19 \
&& cd $SOUR && wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz \
&& tar xzf Python-2.7.12.tgz \
&& cd Python-2.7.12 \
&& mkdir -p $SOFT/python/2.7.12/bin \
&& ./configure --prefix=$SOFT/python/2.7.12 --enable-loadable-sqlite-extensions --enable-shared --with-ensurepip=yes \
  CLFAGS="-I$SOFT/openblas/0.2.19/include" \
  LDFLAGS="-L$SOFT/openblas/0.2.19/lib" \
&& make && make install \
&& newmod.sh \
  -s python \
  -p $MODF/general/ \
  -v 2.7.12 \
  -d 2.7.12 \
&& echo "set home $::env(HOME)" >> $MODF/general/python/2.7.12 \
&& echo "set pythonuser \$home/.python/2.7.12/bin" >> $MODF/general/python/2.7.12 \
&& echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/python/2.7.12 \
&& echo "prepend-path PATH \$home/.python/2.7.12/bin" >> $MODF/general/python/2.7.12 \
&& echo "set jupyter_runtime_dir \$home/.python/2.7.12/jupyter/run" >> $MODF/general/python/2.7.12 \
&& echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/python/2.7.12 \
&& echo "setenv JUPYTER_RUNTIME_DIR \$home/.python/2.7.12/jupyter/run" >> $MODF/general/python/2.7.12 \
&& echo "set jupyter_data_dir \$home/.python/2.7.12/jupyter/data" >> $MODF/general/python/2.7.12 \
&& echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/python/2.7.12 \
&& echo "setenv JUPYTER_DATA_DIR \$home/.python/2.7.12/jupyter/data" >> $MODF/general/python/2.7.12 \
&& echo "setenv PYTHONHOME $SOFT/python/2.7.12/" >> $MODF/general/python/2.7.12 \
&& echo "setenv PYTHONPATH $SOFT/python/2.7.12/lib/python2.7" >> $MODF/general/python/2.7.12 \
&& echo "setenv PYTHONUSERBASE \$home/.python/2.7.12/" >> $MODF/general/python/2.7.12 \
&& echo "exec /bin/mkdir -p \$home/.python/2.7.12/pythonpath/site-packages" >> $MODF/general/python/2.7.12 \
&& echo "module load openblas/0.2.19" >> $MODF/general/python/2.7.12 \
&& echo "setenv CLFAGS -I$SOFT/openblas/0.2.19/include" >> $MODF/general/python/2.7.12 \
&& echo "setenv LDFLAGS -L$SOFT/openblas/0.2.19/lib" >> $MODF/general/python/2.7.12'

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load openblas/0.2.19 \
&& cd $SOUR \
&& wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz \
&& tar xzf Python-3.6.0.tgz \
&& cd Python-3.6.0 \
&& mkdir -p $SOFT/python/3.6.0/bin \
&& ./configure --prefix=$SOFT/python/3.6.0 --enable-loadable-sqlite-extensions --enable-shared -with-ensurepip=yes \
  CLFAGS="-I$SOFT/openblas/0.2.19/include" \
  LDFLAGS="-L$SOFT/openblas/0.2.19/lib" \
&& make && make install \
&& newmod.sh \
  -s python \
  -p $MODF/general/ \
  -v 3.6.0 \
&& echo "set home $::env(HOME)" >> $MODF/general/python/3.6.0 \
&& echo "set pythonuser \$home/.python/3.6.0/bin" >> $MODF/general/python/3.6.0 \
&& echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/python/3.6.0 \
&& echo "prepend-path PATH \$home/.python/3.6.0/bin" >> $MODF/general/python/3.6.0 \
&& echo "set jupyter_runtime_dir \$home/.python/3.6.0/jupyter/run" >> $MODF/general/python/3.6.0 \
&& echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/python/3.6.0 \
&& echo "setenv JUPYTER_RUNTIME_DIR \$home/.python/3.6.0/jupyter/run" >> $MODF/general/python/3.6.0 \
&& echo "set jupyter_data_dir \$home/.python/3.6.0/jupyter/data" >> $MODF/general/python/3.6.0 \
&& echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/python/3.6.0 \
&& echo "setenv JUPYTER_DATA_DIR \$home/.python/3.6.0/jupyter/data" >> $MODF/general/python/3.6.0 \
&& echo "setenv PYTHONHOME $SOFT/python/3.6.0/" >> $MODF/general/python/3.6.0 \
&& echo "setenv PYTHONPATH $SOFT/python/3.6.0/lib/python3.6" >> $MODF/general/python/3.6.0 \
&& echo "setenv PYTHONUSERBASE \$home/.python/3.6.0/" >> $MODF/general/python/3.6.0 \
&& echo "exec /bin/mkdir -p \$home/.python/3.6.0/pythonpath/site-packages" >> $MODF/general/python/3.6.0 \
&& echo "module load openblas/0.2.19" >> $MODF/general/python/3.6.0 \
&& echo "setenv CLFAGS -I$SOFT/openblas/0.2.19/include" >> $MODF/general/python/3.6.0 \
&& echo "setenv LDFLAGS -L$SOFT/openblas/0.2.19/lib" >> $MODF/general/python/3.6.0'

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load openblas/0.2.19 \
&& cd $SOUR/Python-2.7.12 \
&& mkdir -p $SOFT/jupyterhub/0.7.2/bin \
&& ./configure --prefix=$SOFT/jupyterhub/0.7.2 --enable-loadable-sqlite-extensions --enable-shared --with-ensurepip=yes \
  CLFAGS="-I$SOFT/openblas/0.2.19/include" \
  LDFLAGS="-L$SOFT/openblas/0.2.19/lib" \
&& make && make install \
&& cd $SOUR/Python-3.6.0 \
&& ./configure --prefix=$SOFT/jupyterhub/0.7.2 --enable-loadable-sqlite-extensions --enable-shared -with-ensurepip=yes \
CLFAGS="-I$SOFT/openblas/0.2.19/include" \
LDFLAGS="-L$SOFT/openblas/0.2.19/lib" \
&& make && make install \
&& newmod.sh \
 -s jupyterhub \
 -p $MODF/general/ \
 -v 0.7.2 \
 -d 0.7.2 \
&& echo "set home $::env(HOME)" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "set pythonuser \$home/.jupyterhub/0.7.2/bin" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "prepend-path PATH \$home/.jupyterhub/0.7.2/bin" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "set jupyter_runtime_dir \$home/.jupyterhub/0.7.2/jupyter/run" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "setenv JUPYTER_RUNTIME_DIR \$home/.jupyterhub/0.7.2/jupyter/run" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "set jupyter_data_dir \$home/.jupyterhub/0.7.2/jupyter/data" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "setenv JUPYTER_DATA_DIR \$home/.jupyterhub/0.7.2/jupyter/data" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "setenv PYTHONHOME $SOFT/jupyterhub/0.7.2/" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "setenv PYTHONUSERBASE \$home/.jupyterhub/0.7.2/" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "exec /bin/mkdir -p \$home/.jupyterhub/0.7.2/pythonpath/site-packages" >> $MODF/general/jupyterhub/0.7.2 \
&& echo "module load openblas/0.2.19 rlang/3.3.2" >> $MODF/general/jupyterhub/0.7.2 \
&& module load jupyterhub/0.7.2 \
&& pip3 install jupyter \
&& python2 -m pip install ipykernel \
&& python2 -m ipykernel install'

## Libraries required for jupyter R kernel
RUN echo "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'), lib=c('$SOFT/rlang/3.3.2/lib/R/library')  ,repos=c('http://ftp5.gwdg.de/pub/misc/cran/'), dependencies=TRUE )" > $SOUR/jupyter.install.R \
&& echo "devtools::install_github('IRkernel/IRkernel',lib=c('$SOFT/rlang/3.3.2/lib/R/library')) " >> $SOUR/_jupyter.install.R \
&& echo "IRkernel::installspec(name = 'ir332', displayname = 'R 3.3.2')" > $SOUR/.install.jupyter.R.kernel.3.3.2

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load jupyterhub \
&& module load rlang \
&& cd $SOUR \
&& wget -O openssl_0.9.5.tar.gz https://github.com/jeroenooms/openssl/archive/v0.9.5.tar.gz \
&& $SOFT/rlang/3.3.2/bin/R CMD INSTALL --configure-vars="INCLUDE_DIR=$SOFT/openssl/1.1.0c/include LIB_DIR=$SOFT/openssl/1.1.0c/lib" -l $SOFT/rlang/3.3.2/lib/R/library openssl_0.9.5.tar.gz \
&& git clone https://github.com/ropensci/git2r.git \
&& $SOFT/rlang/3.3.2/bin/R CMD INSTALL --configure-vars="INCLUDE_DIR=$SOFT/openssl/1.1.0c/include LIB_DIR=$SOFT/openssl/1.1.0c/lib" -l $SOFT/rlang/3.3.2/lib/R/library git2r \
&& $SOFT/rlang/3.3.2/bin/Rscript $SOUR/jupyter.install.R \
&& $SOFT/rlang/3.3.2/bin/Rscript $SOUR/_jupyter.install.R \
&& Rscript $SOUR/.install.jupyter.R.kernel.3.3.2 && rm $SOUR/jupyter.install.R $SOUR/_jupyter.install.R $SOUR/.install.jupyter.R.kernel.3.3.2'
## Finished installation of jupyter R kernel

RUN wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz \
&& tar -xzvf ruby-install-0.6.1.tar.gz \
&& cd ruby-install-0.6.1/ \
&& mkdir -p $SOFT/ruby-install/0.6.1 \
&& make install PREFIX=$SOFT/ruby-install/0.6.1 \
&& newmod.sh \
    -s ruby-install \
    -p $MODF/general/ \
    -v 0.6.1 \
    -d 0.6.1

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load ruby-install \
&& mkdir -p $SOFT/ruby/2.4.0 \
&& $SOFT/ruby-install/0.6.1/bin/ruby-install ruby 2.4.0 --no-install-deps --install-dir $SOFT/ruby/2.4.0 \
&& newmod.sh \
  -s ruby \
  -p $MODF/general/ \
  -v 2.4.0 \
  -d 2.4.0 \
&& echo "set home $::env(HOME)" >> $MODF/general/ruby/2.4.0 \
&& echo "prepend-path PATH \$home/.gem/ruby/2.4.0/bin" >> $MODF/general/ruby/2.4.0 \
&& module load jupyterhub/0.7.2 \
&& module load ruby/2.4.0 \
&& pip3 install -I ipython[notebook] \
&& gem install rbczmq \
&& gem install cztop \
&& gem install iruby \
&& echo "module load ruby/2.4.0" >> $MODF/general/jupyterhub/0.7.2'

## Install rstudio server ##
RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
&& module load python/2.7.12 \
&& module load rlang \
&& apt-get update && apt-get install -y cmake libpam0g-dev lsb-release libedit2 libapparmor1 \
&& wget https://download2.rstudio.org/rstudio-server-1.0.136-amd64.deb \
&& dpkg -i rstudio-server-1.0.136-amd64.deb \
&& echo "rsession-which-r=$(which R)" >> /etc/rstudio/rserver.conf'


##########################
#### this part to end ####
##########################

# Jupyter port
EXPOSE 8888
# rstudio server port
EXPOSE 8787

USER $NB_USER
RUN echo "options(bitmapType='cairo')" > $HOME/.Rprofile
RUN echo "source /etc/profile.d/modules.sh" >> $HOME/.bashrc
RUN echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]bioinf-container\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> $HOME/.bashrc
RUN echo "color_prompt=yes" >> $HOME/.bashrc
RUN mkdir -p $HOME/.jupyter
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
USER root

# Folders in home folder that should be kept
ENV HOFOL ".bash_logout  .bashrc  .jupyter  .profile  .texmf-var .jupyterhub .Rprofile"

RUN mkdir -p /home/_mpiage \
&& for f in $HOFOL ; do \
cp -r $HOME/${f} /home/_mpiage/; \
done

ENTRYPOINT /bin/bash -c '\
for f in $HOFOL ; do \
  if [[ ! -e $HOME/${f} ]]; \
    then cp -vr /home/_mpiage/${f} $HOME/${f}; \
  fi \
done \
&& source $HOME/.bashrc \
&& /bin/bash'
WORKDIR $HOME
RUN chown -R mpiage: $HOME

USER $NB_USER
