CONT=alpine-eccodes
all:
	docker build -t ${CONT} .
pod:
	podman build --tag ${CONT} -f Dockerfile
help:
	podman run ${CONT}  grib_ls 
ash:
	docker run --net=host -ti ${CONT} ash
test:
	-docker run --net=host -ti ${CONT} bufr_ls --help 
	-docker run --net=host -ti ${CONT} codes_info
	-docker run --net=host -ti ${CONT} grib_ls --help
	-docker run --net=host -ti ${CONT} gts_ls --help
	-docker run --net=host -ti ${CONT} metar_ls --help
	-docker run --net=host -ti ${CONT} ls /usr/local/bin -ltr
slim:
	slim build --target ${CONT}:latest --tag ${CONT}:light --http-probe=false --exec "grib_copy --help; grib_dump --help; grib_get --help; grib_histogram --help; grib_ls --help; grib_set --help; grib_compare --help; grib_count --help; grib_filter --help; grib_get_data --help; grib_index_build --help; grib_merge --help; bufr-ls --help; codes_info --help; git-ls --help; metar_ls --help; "


