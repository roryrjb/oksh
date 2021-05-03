name = oksh
version = 6.8.0
tar = $(name)_$(version).orig.tar.gz
releases = bionic focal groovy
source_dir ?= source

default: run

$(tar):
	cd $(source_dir) && tar -czf ../$@ *

build:
	for release in $(releases); do \
		docker build \
			--build-arg=release=$$release \
			--build-arg=name=$(name) \
			--build-arg=tar=$(tar) \
			-t oksh:$$release-$(version) . ; \
	done

run: build
	for release in $(releases); do \
		docker run --rm -it \
			-v $(HOME)/.gnupg:/root/.gnupg \
			-v $(shell pwd)/output:/output/ \
			oksh:$$release-$(version); \
	done

clean:
	rm $(tar)
