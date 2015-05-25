DOCKER = $(shell which docker)
MAJOR=8
UPDATE=45
VERSION=1.$(MAJOR).0_$(UPDATE)
VERSION_U=$(MAJOR)u$(UPDATE)

ifeq ($(DOCKER),)
$(error "Docker not available on this system")
endif

#fpm -s dir -t deb -n jdk7 -v 7u12ea --template-scripts --after-install =(echo "update-alternatives --install /usr/bin/java java <%= prefix %>/jre/bin/java  100") --after-remove =(echo "update-alternatives --remove java <%= prefix %>/jre/bin/java") --prefix /usr/lib/jvm/jdk-7u11 .