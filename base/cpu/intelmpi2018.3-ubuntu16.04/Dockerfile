# Copyright (c) Microsoft Corporation. All rights reserved.
# Edited by Colby T. Ford, Ph.D.
# Licensed under the MIT License.

FROM ubuntu:16.04
# FROM ubuntu:19.10

USER root:root

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ARG DEBIAN_FRONTEND=noninteractive


# Install Common Dependencies
RUN apt-get update && \
    apt-get purge runit && \
    apt-get purge git-all && \
    apt-get purge git && \
    apt-get autoremove && \
    apt-get install -y debconf-utils apt-utils && \
    apt-get install -y --no-install-recommends \
    #git
    git-daemon-sysvinit \
    git-all \
    # ODBC
    # libiodbc2-dev \
    # msodbcsql17 \
    # unixodbc-dev \
    # SSH and RDMA
    libmlx4-1 \
    libmlx5-1 \
    librdmacm1 \
    libibverbs1 \
    libmthca1 \
    libdapl2 \
    curl \
    apt-transport-https \
    dapl2-utils \
    openssh-client \
    openssh-server \
    iproute2 && \
    # Others
    apt-get install -y \
    libxml2-dev \
    build-essential \
    bzip2 \
    #git=1:2.7.4-0ubuntu1.6 \
    wget \
    cpio && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

    ## MSSQL ODBC
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list 
RUN apt-get update -y && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
# RUN install2.r odbc && \
# RUN source ~/.bashrc && \
RUN echo msodbcsql17 msodbcsql/ACCEPT_EULA boolean true | debconf-set-selections

# Conda Environment
ENV MINICONDA_VERSION 4.5.11
ENV PATH /opt/miniconda/bin:$PATH
RUN wget -qO /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash /tmp/miniconda.sh -bf -p /opt/miniconda && \
    conda clean -ay && \
    rm -rf /opt/miniconda/pkgs && \
    rm /tmp/miniconda.sh && \
    find / -type d -name __pycache__ | xargs rm -rf

# Intel MPI installation
ENV INTEL_MPI_VERSION 2018.3.222
ENV PATH $PATH:/opt/intel/compilers_and_libraries/linux/mpi/bin64
RUN cd /tmp && \
    wget -q "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/13063/l_mpi_${INTEL_MPI_VERSION}.tgz" && \
    tar zxvf l_mpi_${INTEL_MPI_VERSION}.tgz && \
    sed -i -e 's/^ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' /tmp/l_mpi_${INTEL_MPI_VERSION}/silent.cfg && \
    cd /tmp/l_mpi_${INTEL_MPI_VERSION} && \
    ./install.sh -s silent.cfg --arch=intel64 && \
    cd / && \
    rm -rf /tmp/l_mpi_${INTEL_MPI_VERSION}* && \
    rm -rf /opt/intel/compilers_and_libraries_${INTEL_MPI_VERSION}/linux/mpi/intel64/lib/debug* && \
    echo "source /opt/intel/compilers_and_libraries_${INTEL_MPI_VERSION}/linux/mpi/intel64/bin/mpivars.sh" >> ~/.bashrc

# Conda + R Environment
RUN conda install -c r -y \
    r-essentials=3.6.0 \
    r-reticulate \
    rpy2 \
    r-remotes \
    r-e1071 \
    r-optparse && \
    conda clean -ay && \
    pip install --no-cache-dir azureml-defaults && \
    pip install pyodbc

# R Packages
ENV TAR="/bin/tar"
RUN R -e "remotes::install_cran('azuremlsdk', repos = 'https://cloud.r-project.org/', upgrade = FALSE)"
RUN R -e "install.packages('odbc', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('DBI', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('RODBC', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('data.table', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('caret', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('glmnet', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('XML', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('foreach', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('base64enc', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('lubridate', repos = 'https://cloud.r-project.org/')"
RUN R -e "install.packages('jsonlite', repos = 'https://cloud.r-project.org/')"