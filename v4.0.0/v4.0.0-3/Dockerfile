# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM mpgagebioinformatics/bioinformatics_software:v4.0.0-2

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

#########################################
#### Bioinformatics tools start here ####
#########################################

# Install emboss version 6.6.0 v2.0.0
RUN cd $SOUR && \
    mkdir emboss && cd emboss && \
    wget https://zlib.net/zlib-1.2.12.tar.gz && \
    wget ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-1.6.34.tar.gz && \
    wget https://github.com/libgd/libgd/releases/download/gd-2.3.3/libgd-2.3.3.tar.gz && \
    wget http://www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz && \
    wget https://github.com/primer3-org/primer3/archive/v2.6.1.tar.gz && \
    wget https://downloads.sourceforge.net/project/primer3/primer3/1.1.4/primer3-1.1.4.tar.gz && \
    wget ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-6.6.0.tar.gz && \
    tar xfvz zlib-1.2.12.tar.gz && \
    tar xfvz libpng-1.6.34.tar.gz && \
    tar xfvz libgd-2.3.3.tar.gz && \
    tar xfvz clustalw-2.1-linux-x86_64-libcppstatic.tar.gz && \
    tar xfvz v2.6.1.tar.gz && \
    tar xfvz EMBOSS-6.6.0.tar.gz && \
    mkdir primer3-1.1.4 && tar xvfz primer3-1.1.4.tar.gz -C primer3-1.1.4 && \
    mkdir -p $SOFT/emboss/6.6.0/bin && \
    cd zlib-1.2.12 && ./configure --prefix=$SOFT/emboss/6.6.0 --eprefix=$SOFT/emboss/6.6.0 && make install && \
    cd ../libpng-1.6.34 && ./configure --prefix=$SOFT/emboss/6.6.0 && make check && make install && \
    cd ../libgd-2.3.3 && ./configure --prefix=$SOFT/emboss/6.6.0 --with-zlib=$SOFT/emboss/6.6.0 --with-png=$SOFT/emboss/6.6.0 && make install && \
    cd ../clustalw-2.1-linux-x86_64-libcppstatic && cp clustalw2 $SOFT/emboss/6.6.0/bin && \
    cd ../primer3-2.6.1/src && make all && make test && cp -a primer3_core primer3_config $SOFT/emboss/6.6.0/bin && mv $SOFT/emboss/6.6.0/bin/primer3_core $SOFT/emboss/6.6.0/bin/primer32_core && \
    cd ../../primer3-1.1.4/src && make all && make test && cp -a primer3_core $SOFT/emboss/6.6.0/bin && \
    cd ../../EMBOSS-6.6.0 && ./configure --disable-shared --with-pngdriver=$SOFT/emboss/6.6.0 --prefix=$SOFT/emboss/6.6.0 && make && make install && \
    newmod.sh \
    -s emboss \
    -p $MODF/bioinformatics/ \
    -v 6.6.0 \
    -d 6.6.0 && \
    echo "module load perl" >> $MODF/bioinformatics/emboss/6.6.0 && \
    cd $SOUR && tar -zcvf emboss-6.6.0.tar.gz emboss && \
    rm -rf ${SOUR}/*

# Install segemehl version 0.3.4 v2.0.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load python && \
    module load htslib && \
    mkdir -p $SOFT/segemehl/0.3.4/bin && \
    cd $SOUR && \
    wget http://www.bioinf.uni-leipzig.de/Software/segemehl/downloads/segemehl-0.3.4.tar.gz && \
    tar -zxvf segemehl-0.3.4.tar.gz && \
    cd segemehl-0.3.4 && \
    make && cp lack.x segemehl.x testrealign.x $SOFT/segemehl/0.3.4/bin && \
    newmod.sh \
    -s segemehl \
    -p $MODF/bioinformatics/ \
    -v 0.3.4 \
    -d 0.3.4' && \
    rm -rf ${SOUR}/*

# Installing ngsutils version 0.5.9 needed for epiTEome v2.0.0
RUN cd $SOUR && \
    wget https://github.com/ngsutils/ngsutils/archive/ngsutils-0.5.9.tar.gz && \
    mkdir -p $SOFT/ngsutils/0.5.9 && cd $SOFT/ngsutils/0.5.9 && \
    tar xfvz $SOUR/ngsutils-0.5.9.tar.gz --strip-components 1 && \
    make && \
    newmod.sh \
    -s ngsutils \
    -p $MODF/bioinformatics/ \
    -v 0.5.9 \
    -d 0.5.9 && \
    rm -rf ${SOUR}/*

# #COPY epiteome.sh ${SOUR}epiteome.sh
# #RUN chmod +x ${SOUR}epiteome.sh
# #RUN ${SOUR}epiteome.sh && \
# #    curl -T ${SOUR}v1.0.tar.gz ${WEBDAV_URL}epiteome-v1.0.tar.gz --anyauth && \
# #    rm -rf ${SOUR}/*

# Installing epiTEome v2.0.0
RUN /bin/bash -c 'source /etc/profile.d/modules.sh && \
    module load python perl bedtools segemehl ngsutils && \
    export PERL5LIB="$SOFT/epiteome/1.0.0/lib/perl5:\$PERL5LIB" && \
    export SAMTOOLS="$SOFT/epiteome/1.0.0/samtools-1.15.1" && \
    mkdir -p $SOFT/epiteome/1.0.0/bin && \
    cd $SOFT/epiteome/1.0.0 && \
    wget -O samtools-1.15.1.tar.bz2 http://sourceforge.net/projects/samtools/files/samtools/1.15.1/samtools-1.15.1.tar.bz2/download && \
    tar -jxvf samtools-1.15.1.tar.bz2 && \
    cd $SOFT/epiteome/1.0.0/samtools-1.15.1 && sed -i '"'"'s/-g -Wall -O2/-g -Wall -O2 -fPIC/g'"'"' Makefile && make && cd ../ && rm -rf samtools-1.15.1.tar.bz2 && \
    cd $SOUR && wget http://www.cpan.org/authors/id/M/MI/MIROD/XML-DOM-XPath-0.14.tar.gz && \
    tar -zxvf XML-DOM-XPath-0.14.tar.gz && sed -i '"'"'10s/.*/use utf8;/'"'"' XML-DOM-XPath-0.14/t/test_non_ascii.t && \
    cpanm ./XML-DOM-XPath-0.14 -l $SOFT/epiteome/1.0.0/ && \
    cpanm ./XML-DOM-XPath-0.14 -l $SOFT/epiteome/1.0.0/ && \
    cpanm -f inc::latest -l $SOFT/epiteome/1.0.0/ && \
    cpanm -f Bio::DB::Sam -l $SOFT/epiteome/1.0.0/ && \
    cpanm -f File::Which -l $SOFT/epiteome/1.0.0/ && \
    cpanm -f IPC::Run -l $SOFT/epiteome/1.0.0/ && \
    cpanm -f Bio::SeqIO -l $SOFT/epiteome/1.0.0/ && \
    cpanm Bio::Tools::GFF -l $SOFT/epiteome/1.0.0/ && \
    cpanm Set::IntervalTree -l $SOFT/epiteome/1.0.0/ && \
    cpanm Statistics::Descriptive -l $SOFT/epiteome/1.0.0/ && \
    cd $SOUR && \
    wget https://github.com/jdaron/epiTEome/archive/v1.0.tar.gz && \
    mv v1.0.tar.gz epiTEome-1.0.tar.gz && \
    tar -zxvf epiTEome-1.0.tar.gz && \
    cd epiTEome-1.0 && \
    sed -i '"'"'s/usr\/bin\/perl/usr\/bin\/env perl/g'"'"' epiTEome.pl && \
    sed -i '"'"'s/usr\/bin\/perl/usr\/bin\/env perl/g'"'"' idxEpiTEome.pl && \
    sed -i '"'"'s/usr\/bin\/perl/usr\/bin\/env perl/g'"'"' insertTEsintoFasta.pl && \
    chmod 755 epiTEome.pl idxEpiTEome.pl insertTEsintoFasta.pl && \
    cp epiTEome.pl idxEpiTEome.pl insertTEsintoFasta.pl $SOFT/epiteome/1.0.0/bin && \
    newmod.sh \
    -s epiteome \
    -p $MODF/bioinformatics/ \
    -v 1.0.0 \
    -d 1.0.0 && \
    echo "module load python perl ngsutils samtools/1.15.1 bedtools segemehl" >> $MODF/bioinformatics/epiteome/1.0.0 && \
    echo "prepend-path PERL5LIB $SOFT/epiteome/1.0.0/lib/perl5" >> $MODF/bioinformatics/epiteome/1.0.0' && \
    rm -rf ${SOUR}/*

##########################
#### this part to end ####
##########################

RUN mkdir -p /Dockerfiles/v4.0.0-3
COPY Dockerfile /Dockerfiles/v4.0.0-3/

USER $NB_USER






