CONT=alpine-eccodes
all:
	docker build -t ${CONT} .
ash:
	docker run --net=host -ti ${CONT} ash
test:
	-docker run --net=host -ti ${CONT} bufr_ls --help 
	-docker run --net=host -ti ${CONT} codes_info
	-docker run --net=host -ti ${CONT} grib_ls --help
	-docker run --net=host -ti ${CONT} gts_ls --help
	-docker run --net=host -ti ${CONT} metar_ls --help
	-docker run --net=host -ti ${CONT} ls /usr/local/bin -ltr

