# software container

This image contains some of the most popular software used at **Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing**.

Software is versioned by making use of *Environment Modules*.

Additionally to the standard bioinformatics tools, there is also a *Jupyter* and *RStudio server*  installation.  

The *Jupyter* installation comes with *Python 2*, *Python 3*, *R*, and *ruby* kernels ready to go.

The container is available from the [docker store](https://store.docker.com/community/images/mpgagebioinformatics/bioinformatics_software).

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
jupyter notebook
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
RStudio server is using the module rlang/3.3.2. 

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

* **v0.0.1**: 
First release.
```
---- /modules/modulefiles/bioinformatics ----
bedtools/2.26.0(default)
hisat/2.0.4(default)
spades/3.10.0(default)
bowtie/2.2.9(default)
igvtools/2.3.89(default)
sratoolkit/2.8.1(default)
bwa/0.7.15(default)
picard/2.8.1(default)
star/2.5.2b(default)
cufflinks/2.2.1(default)
samtools/1.3.1(default)
stringtie/1.3.0(default)
fastqc/0.11.5(default)
skewer/0.2.2(default)
tophat/2.1.1(default)
gatk/3.4.46(default)
snpeff/4.3.i(default)
vcftools/0.1.14(default)
---- /modules/modulefiles/general ----
java/8.0.111(default)
python/2.7.12(default)
python/3.6.0
ruby-install/0.6.1(default)
jupyterhub/0.7.2(default)
rlang/3.3.2(default)
ruby/2.4.0(default)
---- /modules/modulefiles/libs ----
bzip2/1.0.6(default)
openblas/0.2.19(default) 
xz/5.2.2(default)
```

* **v0.0.2**:

  Improved PS1

  Added `/Dockerfiles` for legacy maintenance of each version Dockerfile

  Added `lofreq/2.1.2(default)`

* **v1.0.0**: 

  Moved to cents 9.1.

  Removed ENV HOME from Dockerfile.

  Replaced python 2.7.12 with 2.7.13.
