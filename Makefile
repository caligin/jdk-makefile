DOCKER = $(shell which docker)
MAJOR=8
UPDATE=45
VERSION=1.$(MAJOR).0_$(UPDATE)
VERSION_U=$(MAJOR)u$(UPDATE)
VERSION_OUT=$(VERSION_U)~anima
PACKAGE=oracle-jdk$(MAJOR)-jce-unlimited
DEB=$(PACKAGE)_$(VERSION_OUT)_amd64.deb
JDK_TAR=jdk-$(VERSION_U)-linux-x64.tar.gz
JDK_TAR_ROOT=jdk$(VERSION)
JCE_ZIP=jce_policy-$(MAJOR).zip
JCE_ZIP_ROOT=UnlimitedJCEPolicyJDK$(MAJOR)

ifeq ($(DOCKER),)
$(error "Docker not available on this system")
endif

.PHONY: all debpkg clean test

all: test

debpkg: target/$(DEB)

target/:
	mkdir -p target

target/$(JDK_TAR_ROOT): $(JDK_TAR) | target/
	tar xvzf $(JDK_TAR) -C target

target/$(JCE_ZIP_ROOT): $(JCE_ZIP) | target/
	unzip $(JCE_ZIP) -d target

target/$(DEB): target/$(JDK_TAR_ROOT)/ target/$(JCE_ZIP_ROOT)/ postinst.template postrm.template | target/
	echo $(DEB)
	cp target/$(JCE_ZIP_ROOT)/local_policy.jar target/jdk$(VERSION)/jre/lib/security/
	cp target/$(JCE_ZIP_ROOT)/US_export_policy.jar target/jdk$(VERSION)/jre/lib/security/
	cp postinst.template target/
	cp postrm.template target/
	docker run --rm -v $$PWD/target:/target -w /target tenzer/fpm fpm -s dir -t deb -n $(PACKAGE) -v $(VERSION_OUT) --template-scripts --after-install postinst.template --after-remove postrm.template --prefix /usr/lib/jvm/$(PACKAGE) --provides java --provides java8 --provides jdk --provides jdk8 -C jdk$(VERSION)

clean:
	rm -rf target/

test: debpkg tests.sh
	cp tests.sh target/
	docker run -v $$PWD/target:/deb -w /deb -e DEB=$(DEB) -e VERSION=$(VERSION) -e PACKAGE=$(PACKAGE) ubuntu:trusty bash tests.sh