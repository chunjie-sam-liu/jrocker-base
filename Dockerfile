ARG BASE_CONTAINER=rocker/rstudio:latest
FROM $BASE_CONTAINER

LABEL maintainer="Chun-Jie Liu <chunjie-sam-liu@foxmail.com>"

## DEPENDENCIES
RUN apt-get update -qq \
  && apt-get -y --no-install-recommends install \
  openjdk-8-jdk \
  openjdk-8-jre \
  mesa-common-dev \
  libglu1-mesa-dev \
  libbz2-dev \
  liblzma-dev \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  tk \
  # bioconductor needs
  gdb \
  python-pip \
  libz-dev \
  libpng-dev \
  ## For units
  libudunits2-dev \
  ssh \
  less \
  vim \
  #Rmpi
  openmpi-common \
  openmpi-bin \
  libopenmpi-dev \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && pip install awscli \
  && echo '\n \
  \noptions(defaultPackages=c(getOption("defaultPackages"),"BiocManager")) \
  \n# Blogdown options -------------------------------------------------------- \
  \noptions(blogdown.author = "Chun-Jie Liu") \
  \noptions(servr.daemon = FALSE) \
  \noptions(blogdown.ext = ".Rmd") \
  \noptions(blogdown.subdir = "post") \
  \noptions(blogdown.yaml.empty = TRUE) \
  \n# General options --------------------------------------------------------- \
  \noptions(repos = c(CRAN = "https://cloud.r-project.org"), download.file.method = "libcurl") \
  \noptions(prompt = "Jrocker>", digits = 4, show.signif.stars = FALSE) \
  \noptions(stringsAsFactors = FALSE) \
  \noptions(expressions = 5e5) \
  \n# ggplot2 v3 options ------------------------------------------------------ \
  \noptions( \
  \n  ggplot2.continuous.color = "viridis", \
  \n  ggplot2.continuous.fill = "viridis" \
  \n)' >> /usr/local/lib/R/etc/Rprofile.site \
  && echo '\n \
  \n# Never suspend session \
  \nsession-timeout-minutes=0 \
  \n' >> /etc/rstudio/rsession.conf \
  && echo '\n \
  \n R_LIBS=/usr/local/lib/R/host-site-library:\${R_LIBS} \
  \n R_LIBS_USER="" \
  \n' >> /usr/local/lib/R/etc/Renviron.site \
  && install2.r --error --deps TRUE BiocManager


