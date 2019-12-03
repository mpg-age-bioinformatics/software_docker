# software container

[Introduction](#introduction)

[Usage](#usage)

[Environment Modules Project](environment-modules-project)

[Versioning/Tags](#versioningtags)

[Shifter/Singularity](#shiftersingularity)

[Contributing](#contributing)

## Introduction

This image contains some of the most popular software used at **Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing**.

Software is versioned by making use of *Environment Modules*.

Additionally to the standard bioinformatics tools, there is also a *Jupyter* and *RStudio server*  installation.  

The *Jupyter* installation comes with *Python 2*, *Python 3*, and *R* kernels ready to go.

The container is available from the [docker hub](https://hub.docker.com/r/mpgagebioinformatics/bioinformatics_software).

## Usage
* Create a folder to map to the container's user home folder
```
mkdir -p ~/bioinf-container
```
----
* Start the container from the latest version of the image
```
sudo docker run -d -p 8787:8787 -p 8888:8888 \
-v ~/bioinf-container:/home/mpiage --name bioinf-container \
-it mpgagebioinformatics/bioinformatics_software:latest
```
----
* Alternatively you can start the container from a specific tag/version of the image
```
sudo docker run -d -p 8787:8787 -p 8888:8888 \
-v ~/bioinf-container:/home/mpiage --name bioinf-container \
-it mpgagebioinformatics/bioinformatics_software:<tag>
```
----
* Connect to the running container
```
sudo docker exec -i -t bioinf-container /bin/bash
```
----
* Stop the container
```
sudo docker stop bioinf-container
```
----
* Jupyter

Once you have connected to the running container you can start `jupyter` with
```
module load jupyterhub
jupyter notebook --ip=0.0.0.0
```
A URL will be presented to you, and it should be pasted into your host's browser (Chrome  recommended).

For using the `ruby` kernel you will have to get your kernel registered by running once
```
module load jupyterhub
iruby notebook
```
----
* RStudio-server
Once you have connected to the running container you can start `Rstudio server` with
```
module load rlang
sudo rstudio-server start
```
You can then get access by connecting on your host's browser to [http://localhost:8787](http://localhost:8787).

For stopping the server use:
```
sudo rstudio-server stop
```

----

* X forward

On a Mac install `socat` and `xquartz`:
```
brew install socat
brew install xquartz
```
Open Xquartz:
```
open -a Xquartz
```
Then navigate to XQuartz > Preferences > Security  and tick the box 'Allow connections from network clients'.

Check your ip address:
```
IP=$(ifconfig en0 | grep inet | awk '{ print $2 }')
```
Start `socat`:
```
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```
an then start the container by adding the `-e DISPLAY=${IP}:0` argument. 

Complete example call: 
```
IP=$(ifconfig en0 | grep inet | awk '{ print $2 }') && \
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" & \
docker run -d -e DISPLAY=${IP}:0 -p 8787:8787 -p 8888:8888 \
-v ~/bioinf-container:/home/mpiage --name bioinf-container \
-it mpgagebioinformatics/bioinformatics_software:latest
```

----
* User account

User: `mpiage`

Pass: `bioinf`

----
**Note** : As only the home folder in the guest container gets mapped to the local host, all files NOT placed IN the home folder will be lost if the container is removed.

## [Environment Modules Project](http://modules.sourceforge.net)
A centralized software system.
The modules system loads software (version of choice) and changes environment
variables (eg. LD_LIBRARY_PATH).
* show available modules:
`module avail`
* show a description of the samtools module:
`module whatis samtools`
* show environment changes for samtools:
`module show samtools`
* load default samtools version:
`module load samtools`		
* load specific samtools version:
`module load samtools/1.2.1`
* list all loaded modules:
`module list`
* unload the samtools module:
`module unload samtools`
* unload all loaded modules:
`module purge`  

## Versioning/Tags

All images are released with the following tag structure:

**`<major release>.<changed system package>.<changed software module>`**

* **v3.0.0**:

```
container:~$ module avail
------------------------------- /modules/modulefiles/bioinformatics -------------------------------
bamutil/1.0.14(default)        hisat/2.1.0(default)      samtools/0.1.19            
bcl2fastq/2.20.0.422(default)  homer/4.11.0(default)     samtools/1.9.0(default)    
bedtools/2.29.0(default)       igor/1.3.0(default)       segemehl/0.2.0(default)    
blast/2.9.0(default)           igrec/3.1.1(default)      seqtk/1.3.0(default)       
bowtie/1.2.3                   iseerna/1.2.2(default)    skewer/0.2.2(default)      
bowtie/2.3.5(default)          kallisto/0.46.1(default)  snpeff/4.3.t(default)      
bwa/0.7.17(default)            kenttools/390(default)    spades/3.11.1(default)     
bwtool/face601(default)        lofreq/2.1.3(default)     sratoolkit/2.9.6(default)  
cufflinks/2.2.1(default)       meme/5.1.0(default)       star/2.7.3a(default)       
cytoscape/3.7.2(default)       methpipe/3.4.3(default)   stringtie/2.0.4(default)   
emboss/6.6.0(default)          mitools/1.5.0(default)    subread/2.0.0(default)     
epiteome/1.0.0(default)        ngsutils/0.5.9(default)   tophat/2.1.1(default)      
expat/2.2.9(default)           picard/2.21.4(default)    trimmomatic/0.39(default)  
fastqc/0.11.8(default)         primer3/2.5.0(default)    vcftools/0.1.16(default)   
flexbar/3.5.0(default)         quast/5.0.2(default)      vdjtools/1.2.1(default)    
gatk/4.1.4(default)            rsem/1.3.1(default)       walt/1.1.0(default)        

---------------------------------- /modules/modulefiles/general -----------------------------------
jdk/13.0.1(default)   jupyterhub/1.0.0(default)  python/2.7.16(default)  rlang/3.6.1(default)  
jre/8.0.231(default)  perl/5.28.1(default)       python/3.8.0            

------------------------------------ /modules/modulefiles/libs ------------------------------------
bzip2/1.0.8(default)  imagemagick/7.0.9-7(default)  xz/5.2.4(default)  
gsl/2.6.0(default)    openblas/0.3.7(default)       
```

## Shifter/Singularity

Shifer and Singularity users should add the following line to their host `~/.bashrc`:

```bash
if [[ -e /home/mpiage/.bashrc ]]; then module purge; unset PYTHONHOME PYTHONUSERBASE PYTHONPATH; source /home/mpiage/.bashrc; fi
```

## Contributing

Clone this repo:
```bash
git clone https://github.com/mpg-age-bioinformatics/software_docker.git
```
Make a new version folder in agreement with [Versioning/Tags](#versioningtags):
```bash
cd software_docker
mkdir v1.0.1
cd v1.0.1
touch Dockerfile
```
Generate the content of the Dockerfile making sure that on the "FROM" you are using the key for latest available version and using the examples from previous Dockerfiles.

Build the image with:
```bash
sudo docker build .
```
Try the image and test respective changes
```bash
mkdir -p ~/bioinf-container

sudo docker run -d -p 8787:8787 -p 8888:8888 \
-v ~/bioinf-container:/home/mpiage --name bioinf-container \
-it <image tag>

sudo docker exec -i -t bioinf-container /bin/bash
```
Push your changes to the repo to github.

Python and perl Modules should be installed by the user with the ```--user``` option.
If modules are needed for the installation of software on module environment they should be installed inside the package.
Example:
```
  echo "setenv PYTHONUSERBASE $SOFT/package/1.0.0/lib/python2.7" >> $MODF/bioinformatics/quast/4.6.0 && \
  echo "prepend-path PERL5LIB $SOFT/package/1.0.0/lib/perl5" >> $MODF/bioinformatics/quast/4.6.0
```
