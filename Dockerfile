FROM alpine
RUN apk update \
 && apk add --no-cache build-base cmake g++ linux-headers openssl python3-dev ca-certificates wget vim gfortran perl \
 && update-ca-certificates

WORKDIR /tmp
ENV HTTP=https://confluence.ecmwf.int/download/attachments/45757960 \
  ECCODES=eccodes-2.25.0-Source
RUN cd /tmp && wget --output-document=${ECCODES}.tar.gz ${HTTP}/${ECCODES}.tar.gz?api=v2
RUN tar -zxvf ${ECCODES}.tar.gz

RUN cd ${ECCODES} && mkdir build && cd build && cmake .. && make -j$(grep processor /proc/cpuinfo | wc -l) && make install
# RUN apk add git netcdf jpeg
# RUN apk del cmake g++ linux-headers build-base
# RUN rm -rf /tmp${ECCODES}


