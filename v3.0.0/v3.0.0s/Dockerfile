# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# Debian buster-slim (10.1) image available on 20 Wednesday 2020.
FROM debian@sha256:11253793361a12861562d1d7b15b8b7e25ac30dd631e3d206ed1ca969bf97b7d

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

ENV DEBIAN_FRONTEND noninteractive

ENV MODS /modules
ENV SOFT $MODS/software
ENV SOUR $MODS/sources/
ENV MODF $MODS/modulefiles
ENV LOGS $MODS/installation_logs

RUN mkdir -p $SOFT $SOUR $MODF $LOGS $MODF/bioinformatics $MODF/general $MODF/libs

RUN echo "deb http://ftp.debian.org/debian buster main non-free contrib" >> /etc/apt/sources.list && \
echo "deb-src http://ftp.debian.org/debian buster main non-free contrib" >> /etc/apt/sources.list && \
echo "deb http://ftp.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list && \
echo "deb-src http://ftp.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list

RUN REPO=http://cdn-fastly.deb.debian.org && \
echo "deb $REPO/debian buster main\ndeb $REPO/debian-security buster/updates main" > /etc/apt/sources.list && \
apt-get update && apt-get -yq dist-upgrade && \
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
   texlive-generic-recommended \
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
   libssl-dev \
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
   libclang-dev && \
   apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd ${SOUR} && \
    wget http://ftp.de.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1d-0+deb10u2_amd64.deb && \
    dpkg -i libssl1.1_1.1.1d-0+deb10u2_amd64.deb && \
    rm -rf ${SOUR}/*


RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/debian stable-buster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt update && apt-get -y install mono-devel && apt-get clean && rm -rf /var/lib/apt/lists/*

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

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

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

RUN mkdir -p /Dockerfiles/v3.0.0s
COPY Dockerfile /Dockerfiles/v3.0.0s/

USER $NB_USER