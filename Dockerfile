FROM continuumio/miniconda3:master

RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

RUN conda update --yes conda && \
    conda update -n base -c defaults conda -y && \
    conda update --all -y 

RUN eval "$(/opt/conda/bin/conda shell.bash hook)" && \
    conda create --name pyem  && \
    conda activate pyem && \
    conda install numpy scipy matplotlib seaborn numba pandas natsort && \
    conda install -c conda-forge pyfftw healpy pathos

RUN eval "$(/opt/conda/bin/conda shell.bash hook)" && \
    conda activate pyem && \
    git clone https://github.com/asarnow/pyem.git && \
    cd pyem && \
    pip install --no-dependencies -e . && \
    chmod 755 {angdist.py,cfsc.py,csparc2star.py,ctf2star.py,emcalc.py,map.py,mask.py,par2star.py,pose.py,project.py,projection_subtraction.py,recenter.py,reconstruct.py,sort.py,stack.py,star.py,star2bild.py,subparticles.py,subset.py,varmap.py} && \
    ln -s /pyem/{angdist.py,cfsc.py,csparc2star.py,ctf2star.py,emcalc.py,map.py,mask.py,par2star.py,pose.py,project.py,projection_subtraction.py,recenter.py,reconstruct.py,sort.py,stack.py,star.py,star2bild.py,subparticles.py,subset.py,varmap.py}  /opt/conda/envs/pyem/bin
