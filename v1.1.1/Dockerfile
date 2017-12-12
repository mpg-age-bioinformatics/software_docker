# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

# From docker pull mpgagebioinformatics/bioinformatics_software:v1.1.0 .
FROM mpgagebioinformatics/bioinformatics_software@sha256:9cbfe88f0c35b433569818a203d12eef74d5f145f9f2f8d552f3f6f13603f782


LABEL maintainer "bioinformatics@age.mpg.de"

USER root

RUN apt-get install -y pkg-config libfreetype6-dev libpng-dev liblmdb-dev

# Installing QUAST version 4.6.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  module load python/2.7.13 && \
  module load perl/5.24.1 && \
  mkdir -p $SOFT/quast/4.6.0/bin && \
  export PYTHONUSERBASE=$SOFT/quast/4.6.0/ && \
  pip install future --user && \
  pip install qutils --user && \
  pip install matplotlib --user && \
  cpanm Time::HiRes -l $SOFT/quast/4.6.0/ && \
  export PERL5LIB=$SOFT/quast/4.6.0/lib/perl5:$PERL5LIB && \
  cd $SOUR && \
  wget https://downloads.sourceforge.net/project/quast/quast-4.6.0.tar.gz && \
  tar -xzf quast-4.6.0.tar.gz && \
  cd quast-4.6.0 && \
  ./setup.py install --user && \
  cp -r * $SOFT/quast/4.6.0/bin/ && \
  newmod.sh \
  -s quast \
  -p $MODF/bioinformatics/ \
  -v 4.6.0 \
  -d 4.6.0 && \
  echo "module load perl/5.24.1 python/2.7.13" && \
  echo "setenv PYTHONUSERBASE $SOFT/quast/4.6.0/lib/python2.7" >> $MODF/bioinformatics/quast/4.6.0 && \
  echo "prepend-path PERL5LIB $SOFT/quast/4.6.0/lib/perl5" >> $MODF/bioinformatics/quast/4.6.0'


# Installing BLAST+ version 2.7.1
RUN mkdir -p $SOFT/blast/2.7.1 && \
  cd $SOUR && \
  wget -O d.tar.gz ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz && \
  mv d.tar.gz blast-2.7.1+-x64-linux.tar.gz && \
  tar -xzf blast-2.7.1+-x64-linux.tar.gz && \
  cd ncbi-blast-2.7.1+ && \
  cp -r * $SOFT/blast/2.7.1 && \
  chmod 775 $SOFT/blast/2.7.1/bin/* && \
  newmod.sh \
  -s blast \
  -p $MODF/bioinformatics/ \
  -v 2.7.1 \
  -d 2.7.1

# FIX R module file for debian
RUN sed -i 's/lib64/lib/g' /modules/modulefiles/general/rlang/3.3.2

# Installing primer3
RUN mkdir -p $SOFT/primer3/2.4.0/bin && \
  cd $SOUR && \
  wget -O primer3-2.4.0.tar.gz 'https://downloads.sourceforge.net/project/primer3/primer3/2.4.0/primer3-2.4.0.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fprimer3%2F&ts=1511256562&use_mirror=netix' && \
  tar -xzf primer3-2.4.0.tar.gz && \
  cd primer3-2.4.0/src && \
  make all && \
  cp -r * $SOFT/primer3/2.4.0/bin && \
  newmod.sh \
  -s primer3 \
  -p $MODF/bioinformatics/ \
  -v 2.4.0 \
  -d 2.4.0

# Installing trimmomatic
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
  mkdir -p $SOFT/trimmomatic/0.36/bin && \
  module load java && \
  cd $SOUR && \
  wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip && \
  unzip Trimmomatic-0.36.zip && \
  cd Trimmomatic-0.36 && \
  cp -r * $SOFT/trimmomatic/0.36/bin && \
  chmod 775 $SOFT/trimmomatic/0.36/bin/*.jar && \
  newmod.sh \
  -s trimmomatic \
  -p $MODF/bioinformatics/ \
  -v 0.36 \
  -d 0.36 && \
  echo "module load java" >> $MODF/bioinformatics/trimmomatic/0.36 && \
  echo "setenv TRIMMOMATIC $SOFT/trimmomatic/0.36/bin/trimmomatic-0.36.jar" >> $MODF/bioinformatics/trimmomatic/0.36'

# Fixin python 2.7.13
RUN rm -rf $MODF/general/python/2.7.13 &&\
  newmod.sh \
  -s python \
  -p $MODF/general/ \
  -v 2.7.13 \
  -d 2.7.13 \
&& echo "set home $::env(HOME)" >> $MODF/general/python/2.7.13 \
&& echo "set pythonuser \$home/.software_container/.python/2.7.13/bin" >> $MODF/general/python/2.7.13 \
&& echo "exec /bin/mkdir -p \$pythonuser" >> $MODF/general/python/2.7.13 \
&& echo "prepend-path PATH \$home/.software_container/.python/2.7.13/bin" >> $MODF/general/python/2.7.13 \
&& echo "set jupyter_runtime_dir \$home/.software_container/.python/2.7.13/jupyter/run" >> $MODF/general/python/2.7.13 \
&& echo "exec /bin/mkdir -p \$jupyter_runtime_dir" >> $MODF/general/python/2.7.13 \
&& echo "setenv JUPYTER_RUNTIME_DIR \$home/.software_container/.python/2.7.13/jupyter/run" >> $MODF/general/python/2.7.13 \
&& echo "set jupyter_data_dir \$home/.software_container/.python/2.7.13/jupyter/data" >> $MODF/general/python/2.7.13 \
&& echo "exec /bin/mkdir -p \$jupyter_data_dir" >> $MODF/general/python/2.7.13 \
&& echo "setenv JUPYTER_DATA_DIR \$home/.software_container/.python/2.7.13/jupyter/data" >> $MODF/general/python/2.7.13 \
&& echo "setenv PYTHONHOME $SOFT/python/2.7.13/" >> $MODF/general/python/2.7.13 \
&& echo "setenv PYTHONPATH $SOFT/python/2.7.13/lib/python2.7" >> $MODF/general/python/2.7.13 \
&& echo "setenv PYTHONUSERBASE \$home/.software_container/.python/2.7.13/" >> $MODF/general/python/2.7.13 \
&& echo "exec /bin/mkdir -p \$home/.software_container/.python/2.7.13/pythonpath/site-packages" >> $MODF/general/python/2.7.13 \
&& echo "module load openblas/0.2.19" >> $MODF/general/python/2.7.13 \
&& echo "setenv CLFAGS -I$SOFT/openblas/0.2.19/include" >> $MODF/general/python/2.7.13 \
&& echo "setenv LDFLAGS -L$SOFT/openblas/0.2.19/lib" >> $MODF/general/python/2.7.13

# Install R-3.4.3

RUN /bin/bash -c 'source /etc/profile.d/modules.sh \
  && module load bzip2/1.0.6 \
  && module load xz/5.2.2 \
  && module load openblas/0.2.19 \
  && module load java/8.0.111 \
  && cd $SOUR && wget http://ftp5.gwdg.de/pub/misc/cran/src/base/R-3/R-3.4.3.tar.gz \
  && tar -xzf R-3.4.3.tar.gz \
  && cd R-3.4.3 \
  && mkdir -p $SOFT/rlang/3.4.3/bin \
  && ./configure --prefix=$SOFT/rlang/3.4.3 \
   CFLAGS="-I$SOFT/bzip2/1.0.6/include \
   -I$SOFT/xz/5.2.2/include \
   -I$SOFT/openblas/0.2.19/include" \
   LDFLAGS="-L$SOFT/bzip2/1.0.6/lib \
   -L$SOFT/xz/5.2.2/lib \
   -L$SOFT/openblas/0.2.19/lib" \
   --with-cairo=yes --with-libpng=yes \
   --with-readline --with-tcltk --enable-BLAS-shlib --enable-R-profiling \
   --enable-R-shlib=yes --enable-memory-profiling --with-blas --with-lapack \
  && make && make install \
  && newmod.sh \
   -s rlang \
   -p $MODF/general/ \
   -v 3.4.3 \
   -d 3.4.3 \
  && echo "set home $::env(HOME)" >> $MODF/general/rlang/3.4.3 \
  && echo "exec /bin/mkdir -p \$home/.software_container/.R/3.4.3/R_LIBS_USER/" >> $MODF/general/rlang/3.4.3 \
  && echo "setenv R_LIBS_USER \$home/.software_container/.R/3.4.3/R_LIBS_USER" >> $MODF/general/rlang/3.4.3 \
  && echo "prepend-path LD_LIBRARY_PATH $SOFT/rlang/3.4.3/lib/R/lib" >> $MODF/general/rlang/3.4.3 \
  && echo "prepend-path CPATH $SOFT/rlang/3.4.3/lib/R/include" >> $MODF/general/rlang/3.4.3 \
  && echo "prepend-path C_INCLUDE_PATH $SOFT/rlang/3.4.3/lib/R/include" >> $MODF/general/rlang/3.4.3 \
  && echo "prepend-path CPLUS_INCLUDE_PATH $SOFT/rlang/3.4.3/lib/R/include" >> $MODF/general/rlang/3.4.3 \
  && echo "prepend-path OBJC_INCLUDE_PATH $SOFT/rlang/3.4.3/lib/R/include" >> $MODF/general/rlang/3.4.3 \
  && echo "module load openblas/0.2.19 java/8.0.111" >> $MODF/general/rlang/3.4.3  \
  && echo "setenv CLFAGS \"-I$SOFT/bzip2/1.0.6/include -I$SOFT/xz/5.2.2/include -I$SOFT/openblas/0.2.19/include\"" >> $MODF/general/rlang/3.4.3  \
  && echo "setenv LDFLAGS \"-L$SOFT/bzip2/1.0.6/lib -L$SOFT/xz/5.2.2/lib -L$SOFT/openblas/0.2.19/lib\"" >> $MODF/general/rlang/3.4.3 \
  && mv $SOFT/rlang/3.4.3/lib/R/lib/libRblas.so $SOFT/rlang/3.4.3/lib/R/lib/old_libRblas.so \
  && ln -s $SOFT/openblas/0.2.19/lib/libopenblas.so $SOFT/rlang/3.4.3/lib/R/lib/libRblas.so'

RUN apt-get install -y libmariadb-client-lgpl-dev

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v1.1.1
COPY Dockerfile /Dockerfiles/v1.1.1/Dockerfile
USER $NB_USER
