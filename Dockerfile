# https://tex.stackexchange.com/questions/397174/minimal-texlive-installation
# https://latexindentpl.readthedocs.io/en/latest/appendices.html#required-perl-modules
FROM alpine

ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1 \
    NOPERLDOC=1 \
    PATH=/usr/local/texlive/2020/bin/x86_64-linuxmusl:$PATH

WORKDIR /tmp/texlive

COPY install.profile ./

RUN apk --no-cache add \
      wget \
      biber \
      fontconfig-dev \
      freetype-dev \
      perl \
      perl-log-log4perl \
      perl-log-dispatch \
      perl-namespace-autoclean \
      perl-specio \
      perl-unicode-linebreak &&\
    apk --no-cache add --virtual build-dependencies \
      build-base \
      make \
      tar \
      perl-app-cpanminus &&\
    rm -rf /var/cache/apk/*

RUN wget http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/install-tl-unx.tar.gz &&\
    tar xzvf install-tl-unx.tar.gz &&\
    cd install-tl* &&\
    ./install-tl -profile ../install.profile &&\
    tlmgr install \
      latexindent \
      latexmk &&\
    cd .. &&\
    rm -rf install-tl* install.profile

# Install missing modules for latexindent
RUN cpanm -n \
      File::HomeDir \
      Params::ValidationCompiler \
      YAML::Tiny \
      Unicode::GCString

RUN apk del build-dependencies

COPY latexmkrc /root/.latexmkrc
