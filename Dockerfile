# Dockerizing Catmandu

FROM debian:buster
MAINTAINER Vitali Peil

RUN apt-get update && apt-get install -y \
  sudo \
  cpanminus \
  build-essential \
  libexpat1-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  libxml-libxslt-perl \
  libgdbm-dev \
  libxml-parser-perl \
  libcapture-tiny-perl \
  curl \
  wget \
  nano \
  vim \
  bsdmainutils \
  tree \
  man-db \
  perl-doc \
  python \
  python-pip

RUN adduser --disabled-password --gecos "" catmandu

COPY . /home/catmandu

WORKDIR /home/catmandu

# Add this to change to a different mirror
# cpanm --mirror https://cpan.metacpan.org --mirror-only 

RUN cpanm -n -q --installdeps . && \
  rm -rf /var/lib/apt/lists/*

RUN chown catmandu:catmandu *

USER catmandu

CMD ["/bin/bash"]
