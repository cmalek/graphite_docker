RAWVERSION = $(filter-out __version__ = , $(shell grep __version__ version.txt))
VERSION = $(strip $(shell echo $(RAWVERSION)))

PACKAGE = graphite

DOCKER_REGISTRY = 467892444047.dkr.ecr.us-east-1.amazonaws.com/caltech-imss-ads

#======================================================================

clean:
	rm -rf *.tar.gz dist *.egg-info *.rpm
	find . -name "*.pyc" -exec rm '{}' ';'

build:
	docker build -t ${PACKAGE}:${VERSION} .
	docker tag -f ${PACKAGE}:${VERSION} ${PACKAGE}:latest

tag: build
	docker tag -f ${PACKAGE}:${VERSION} ${DOCKER_REGISTRY}/${PACKAGE}:${VERSION}
	docker tag -f ${PACKAGE}:latest ${DOCKER_REGISTRY}/${PACKAGE}:latest

push: tag
	docker push ${DOCKER_REGISTRY}/${PACKAGE}


