ARG release
FROM roryrjb/ubuntu-builder:$release
ARG release
ARG name
ARG tar

RUN mkdir -p /work/$name/
COPY $tar /work/
WORKDIR /work/
RUN tar -zxf $tar -C /work/$name/
COPY debian/ /work/$name/debian/
COPY changelog.$release /work/$name/debian/changelog

WORKDIR /work/$name/
ENTRYPOINT debuild -S -sa && cp -rv ../*~* /output/
