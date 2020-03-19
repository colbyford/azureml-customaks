## Create your on Dockerfile from the Azure ML R SDK

library(azuremlsdk)

base_image_with_address <- paste0("mcr.microsoft.com/azureml/base:",
                                  "openmpi3.1.2-ubuntu16.04")

cran_packages = c("DBI",
                  "odbc",
                  "data.table",
                  "caret",
                  "glmnet",
                  "XML",
                  "foreach",
                  "base64enc",
                  "lubridate",
                  "jsonlite")

base_dockerfile <- azuremlsdk:::generate_docker_file(base_image_with_address,
                                                   cran_packages,
                                                   github_packages = NULL,
                                                   custom_url_packages = NULL)