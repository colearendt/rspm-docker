FROM ubuntu:18.04

RUN apt-get update -y && \
	apt-get install -y \
		gdebi-core \
		net-tools \
		openssl1.0 \
		psutils \
		vim \
		wget

# install rspm
RUN wget --no-verbose \
	https://s3.amazonaws.com/rstudio-package-manager/ubuntu-14.04/x86_64/rstudio-pm_0.4.0-3_amd64.deb \
	-O rstudio-pm.deb && \
	gdebi -n rstudio-pm.deb && \
	# licensing
	mkdir /var/run/rstudio-pm && \
	# CLI on path
	ln -s /opt/rstudio-pm/bin/rspm /usr/local/bin/rspm

COPY rstudio-pm.gcfg /etc/rstudio-pm/rstudio-pm.gcfg
COPY setup.sh /setup.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]


