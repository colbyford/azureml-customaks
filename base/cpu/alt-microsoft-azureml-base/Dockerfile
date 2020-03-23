FROM mcr.microsoft.com/azureml/base:openmpi3.1.2-ubuntu16.04
MAINTAINER Colby T. Ford, Ph.D. "cford@blue-granite.com"

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl \
    apt-transport-https \
    ca-certificates

RUN conda install -c r -y \
    r-essentials=3.6.0 \
    r-reticulate \
    rpy2 \
    r-remotes \
    r-rodbc \
    r-e1071 \
    r-optparse && \
    conda install -c \
    biobuilds \
    tzdata && \
    conda clean -ay && \
    pip install --no-cache-dir \
    azureml-defaults

# RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
#   && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
#   && apt-get update \
#   && ACCEPT_EULA=Y apt-get -y install msodbcsql=13.1.4.0-1 mssql-tools=14.0.4.0-1 \
#   && ln -sfn /opt/mssql-tools/bin/sqlcmd-13.1.4.0 /usr/bin/sqlcmd \
#   && ln -sfn /opt/mssql-tools/bin/bcp-13.1.4.0 /usr/bin/bcp
#   # Driver name: [ODBC Driver 13 for SQL Server]

## Install ODBC Dependencies for MS SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get -y install msodbcsql17 mssql-tools \
  && ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd \
  && ln -sfn /opt/mssql-tools/bin/bcp /usr/bin/bcp
  # Driver name: [ODBC Driver 17 for SQL Server]

ENV TAR="/bin/tar"
#RUN R -e "remotes::install_cran('azuremlsdk', repos = 'https://cloud.r-project.org/', upgrade = FALSE)"
RUN R -e "remotes::install_github('https://github.com/Azure/azureml-sdk-for-r')"
RUN R -e "install.packages('odbc', repos='http://cran.rstudio.com/')"