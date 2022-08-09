# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# Debian bullseye-slim (10.1) image available on 08/01/2022.
FROM debian@sha256:4cdb3e09504f2ad8650da3aa8233d79227647b9943b6c31b5d383b2da9cc6670

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

ENV DEBIAN_FRONTEND noninteractive

ENV MODS /modules
ENV SOFT $MODS/software
ENV SOUR $MODS/sources/
ENV MODF $MODS/modulefiles
ENV LOGS $MODS/installation_logs

RUN mkdir -p $SOFT $SOUR $MODF $LOGS $MODF/bioinformatics $MODF/general $MODF/libs

RUN echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list && \
echo "deb-src http://deb.debian.org/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list && \
echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
echo "deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list && \
echo "deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && apt-get -yq dist-upgrade && \
apt-get install -yq --no-install-recommends locales && \
apt-get clean && rm -rf /var/lib/apt/lists/* && \
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN apt-get update && \
apt-get install -yq --no-install-recommends \ 
   libreadline-dev \
   xorg-dev \
   apt-utils \
   wget \
   bzip2 \
   ca-certificates \
   sudo \
   jed \
   emacs \
   build-essential \
   python-dev \
   unzip \
   libsm6 \
   pkg-config \
   pigz \
   zlib1g-dev \
   autoconf \
   automake \
   environment-modules \
   gcc && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
apt-get install -yq --no-install-recommends \
   f2c \   
   git \
   vim \
   texlive-latex-base \
   texlive-latex-extra \
   texlive-fonts-extra \
   texlive-fonts-recommended \
   pandoc \
   texlive-base \
   texlive-science \
   texlive-pictures \
   libxrender1 \
   inkscape \
   libxml2-dev \
   libcurl4-gnutls-dev \
   libatlas3-base \
   libopenblas-base \
   libfreetype6-dev \
   libtool \
   libexpat1-dev \
   libxml2-dev \
   libxslt1-dev && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
apt-get install -yq --no-install-recommends \ 
   ghostscript \
   gfortran \
   libpcre3 \
   libpcre3-dev \
   libssl-dev \
   libsqlite3-dev \
   libfreetype6-dev \
   libpng-dev \
   liblmdb-dev \
   libmariadb-dev \
   libmariadb-client-lgpl-dev-compat \
   libtbb2 \
   libtbb-dev \
   curl \
   libcurl4 \
   libcurl4-openssl-dev \
   libncurses5-dev \
   libcairo2-dev \
   libtool-bin \
   libzmq3-dev \
   zip && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
apt-get install -yq --no-install-recommends \ 
   tk \
   tcl \
   openssl \
   libssl1.1 \
   libssl-dev \
   libssh2-1-dev \
   libtool \
   libffi-dev \
   ruby \
   ruby-dev \
   make \
   libzmq3-dev \
   libczmq-dev \
   apt-transport-https \
   dirmngr \
   cmake \
   libpam0g-dev \
   lsb-release \
   libedit2 \
   libapparmor1 \
   gnupg \
   liblzma-dev \
   psmisc \
   less \
   mono-devel \
   tini \
   openjdk-11-jdk \
   libgit2-dev \
   libclang-dev && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
apt-get install -yq --no-install-recommends \
   libfreetype6-dev \
   libpng-dev \
   libbz2-dev \
   libc6 \
   tcl-dev \
   tcllib \
   tk-dev \
   tk8.6 \
   tk8.6-dev \
   tklib \
   libgdbm-dev \
   libcrypt1 \
   libgcc-s1 \
   gcc-10-base \
   texinfo \
   libtiff5-dev \
   libjpeg-dev \
   libfribidi-bin \
   libfribidi-dev \
   libharfbuzz-dev && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

ENV SHELL /bin/bash
ENV NB_USER mpiage
ENV NB_UID 1000
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER ; \
echo "root:bioinf" | chpasswd ; \
echo "mpiage:bioinf" | chpasswd ; \
adduser mpiage sudo

RUN wget https://raw.githubusercontent.com/mpg-age-bioinformatics/draco_pipelines/master/software/newmod.sh \
&& sed -i 's/u\/jboucas\/modules/modules/g' newmod.sh && chmod 777 newmod.sh && mv newmod.sh /usr/bin

ENV MODULEPATH $MODF/bioinformatics:$MODF/general:$MODF/libs

##########################
#### this part to end ####
##########################

# Jupyter port
EXPOSE 8888
# rstudio server port
EXPOSE 8787

USER $NB_USER

COPY .bashrc /home/$NB_USER/.bashrc

RUN echo "options(bitmapType='cairo')" > /home/$NB_USER/.Rprofile
RUN mkdir -p /home/$NB_USER/.software_container/.jupyter
COPY jupyter_notebook_config.py /home/$NB_USER/.software_container/.jupyter/
USER root

# Folders in home folder that should be kept
ENV HOFOL ".bashrc .bash_logout .Rprofile .software_container"

RUN for i in $(ls /home/mpiage/) ; do echo ${i}; done

RUN mkdir -p /home/_mpiage \
&& for f in $HOFOL ; do \
  if [ ! -e /home/mpiage/${f} ] ;\
    then echo 'no ${f}..' ;\
  else cp -rv /home/mpiage/${f} /home/_mpiage/; \
  fi \ 
done

ENTRYPOINT /bin/bash -c '\
for f in $HOFOL ; do \
  if [[ ! -e /home/mpiage/${f} ]] ; \
    then cp -vr /home/_mpiage/${f} /home/mpiage/${f}; \
  fi \
done \
&& source /home/mpiage/.bashrc \
&& /bin/bash'
WORKDIR /home/mpiage
RUN chown -R mpiage: /home/mpiage

RUN mkdir -p /Dockerfiles/v4.0.0s
COPY Dockerfile /Dockerfiles/v4.0.0s/

USER $NB_USER