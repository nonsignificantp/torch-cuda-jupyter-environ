FROM ubuntu:focal

ARG MINICONDA_URL=https://repo.anaconda.com/miniconda
ARG MINICONDA_VERSION=Miniconda3-py37_4.10.3-Linux-x86_64.sh
ARG TINI_VERSION=https://github.com/krallin/tini/releases/download/v0.19.0/tini

COPY scripts/entrypoint.sh /entrypoint.sh
ADD ${TINI_VERSION} /tini

ENV PATH=/opt/conda/bin:$PATH
ENV SHELL=/bin/bash

# Setting up environment
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        git \
	&& wget ${MINICONDA_URL}/${MINICONDA_VERSION} \
            --quiet \
            --no-check-certificate \
            --output-document /miniconda.sh \
    && sh /miniconda.sh -b -p /opt/conda \
    && apt-get purge --auto-remove -y wget \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /miniconda.sh \
    && sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc \
    && chmod +x /entrypoint.sh /tini

# Install dependencies
RUN conda install -c conda-forge \
        mamba \
    && mamba install --yes -c pytorch \
        pytorch==0.4.1 \
        torchvision==0.2.1 \
        cuda92 \
    && mamba install --yes -c anaconda \
        cudatoolkit \
    && mamba install --yes -c conda-forge \
        numpy==1.19.2 \
        h5py==3.1.0 \
        scipy==1.1.0 \
        tqdm==4.61.2 \
        matplotlib==3.4.3 \
        nltk==3.6.5 \
        pillow==8.3.2 \
        scikit-image==0.16.2 \
        jupyterlab \
    && mamba clean -afy \
    && conda clean -afy

EXPOSE 8888
WORKDIR /workspace
ENTRYPOINT [ "/tini", "-g", "--" ]
CMD [ "/entrypoint.sh" ]


