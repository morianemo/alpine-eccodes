FROM alpine:edge
RUN apk update \
 && apk add --no-cache build-base cmake g++ linux-headers openssl python3-dev ca-certificates wget vim gfortran perl git \
 && update-ca-certificates

WORKDIR /tmp
ENV HTTP=https://confluence.ecmwf.int/download/attachments/45757960 
# /eccodes-2.40.0-Source.tar.gz
ENV ECCODES=eccodes-2.42.0-Source
RUN cd /tmp && wget --output-document=${ECCODES}.tar.gz ${HTTP}/${ECCODES}.tar.gz?api=v2
RUN tar -zxvf ${ECCODES}.tar.gz

RUN git clone https://gitlab.dkrz.de/k202009/libaec.git &&\
  cd libaec && mkdir build && cd build && cmake ../ &&\
  make -j$(grep processor /proc/cpuinfo | wc -l) && make install
  
RUN cd ${ECCODES} && mkdir build && cd build && cmake .. && make -j$(grep processor /proc/cpuinfo | wc -l) && make install
# RUN apk add git netcdf jpeg
# RUN apk del cmake g++ linux-headers build-base
# RUN rm -rf /tmp${ECCODES}
# https://confluence.ecmwf.int/display/ECC/Latest+news
