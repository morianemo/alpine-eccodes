all:
	docker build -t alpine-eccodes .
pod:
	podman build --tag alpine-eccodes -f Dockerfile
help:
	podman run alpine-eccodes  grib_ls 
