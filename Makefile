SHELL=/bin/bash

all: clean pypy36.zip upload publish

pypy36.zip:
	./build.sh

upload: pypy36.zip
	./upload.sh

publish: pypy36.zip
	./publish.sh

clean:
	rm -rf layer pypy36.zip

shell:
	docker run --rm -v "$PWD":/opt lambci/lambda:build-provided sh
