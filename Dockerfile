# https://tex.stackexchange.com/questions/397174/minimal-texlive-installation
FROM alpine

ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1 \
    NOPERLDOC=1 \
    PATH=/usr/local/texlive/2020/bin/x86_64-linuxmusl:$PATH

WORKDIR /tmp/texlive

COPY install.profile ./

RUN apk add --no-cache fontconfig-dev freetype-dev perl &&\
    apk add --no-cache --virtual build-dependencies build-base wget tar &&\
    rm -rf /var/cache/apk/*

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz &&\
    tar xzvf install-tl-unx.tar.gz && rm install-tl-unx.tar.gz &&\
    cd install-tl* &&\
    ./install-tl -profile ../install.profile &&\
    tlmgr install \
      latexindent \
      latexmk &&\
    cd .. && rm -rf install-tl*

RUN apk del build-dependencies

COPY latexmkrc /root/.latexmkrc
